#!/usr/local/bin/perl

$|++;

$VERSION= '$Id: checklink.pl,v 1.4 1998-08-31 20:54:03 renaudb Exp $ ';

BEGIN {
    unshift@INC,('/usr/etc/apache/PerlLib');
    package ParseLink;
    use HTML::Parser;
    use vars qw(@ISA);
    @ISA = qw(HTML::Parser);
sub new_line {
    my $self=shift;
    $self->{Line}++;
}
# called by HTML::Parser->parse
# we overload it to add line number in Parser object
sub start {
    my $self=shift;
    my ($tag,$attr)=@_;
    my $link;
    $link=$attr->{href} if $tag eq "a";
    $link=$attr{src} if $tag eq "img";
    if (defined $link){
	$self->{Links}{$link}{$self->{Line}+1}++;
    }
}
}

use CGI qw(:standard);
#use CGI::Carp qw(fatalsToBrowser);
use W3CDebugCGI;
use LWP::Parallel::UserAgent;
use HTML::LinkExtor;

%ALLOWED_SCHEMES = ( "http" => 1 );
%SCHEMES = (); # for report

###############################

if ($#ARGV == 0){
    $VERBOSE = 1;
    &checklinks($ARGV[0]);
} else {
    $CGI = 1;
    $query = new W3CDebugCGI($0, $ARGV[0] eq 'DEBUG', '/tmp/test', 0);
    #$query = new CGI;

    &main($query);
}
 
sub main {
    $q=shift;
    
    &html_header($q);

    print $q->h1('Link Checker');
    if(defined $q->param('url')){
	&checklinks($q->param('url'),$q);
    } else {
	print "bof";
	if($CGI) { print $q->h1('We are in a CGI'); }
    }
    print $q->end_html;
}



################################

sub callback_parse {
    my ($content,$response,$protocol)=@_;
    if(length $content){
	print "Parsing content from '", $response->request->url,"': ", length($content), " bytes, code ",$response->code,"\n" if($VERBOSE);
	# adding content
	$response->add_content($content);
	# waiting for rest of it
	return length $content;
    }
    # we got everything
    print "Total length: ",length $response->content,"\n" if($VERBOSE);
    # let's parse it
    for(split /(\n)/,$response->content){
	$p->parse($_);
	$p->new_line() if $_ eq "\n";
    }
    $p->parse(undef);
    # housekeeping
    $response->content("");
    # close connection
    return C_ENDCON;
}

sub callback_check {
    my ($content,$response,$protocol)=@_;
    if(length $content){
	print "Checking '",$response->request->url,": ", $response->code,"\n" if($VERBOSE);
	return length $content;
    }
    return C_ENDCON;
}

sub checklinks {
    $url=shift;
    $q = shift if($CGI);
    $ua = new LWP::Parallel::UserAgent;
    $p = ParseLink->new();

    $ua->max_hosts(10);
    $ua->max_req(20);

    # prepare the request
    # Request document and parse it as it arrives via callback
    # Then get the UA ready for the requests in the foreach loop
    $ua->register(HTTP::Request->new(GET => $url), \&callback_parse);
    $res = $ua->wait(10);
    $ua->initialize;

    # foreach not necessary since processing only one request
    # but we might be willing to checklink several pages
    foreach my $r (map {$res->{$_}->response} keys %$res){
	if ($r->is_success && $r->content_type =~ /text\/html/i){
	    # if the request is a success
	    # prepare HEAD requests for all the links in the document
	    my $base = $r->base;
	    for my $link (keys %{$p->{Links}}) {
		my $abso = new URI::URL($link,$base);
		$abso->frag(undef); # remove fragments
		$SCHEMES{$abso->abs->scheme}++; # for report
		for my $line (keys %{$p->{Links}{$link}}){
		    $URL{$abso->abs}{$line}++; # save lines in structure indexed by abs path
		}
		next if($URL{Registered}{$abso->abs}); # next if already registered
		# register HTTP request
		$ua->register(HTTP::Request->new(HEAD => $abso->abs),\&callback_check) if($ALLOWED_SCHEMES{$abso->abs->scheme});
		$URL{Registered}{$abso->abs}="True";
	    }
	    $response = $ua->wait(10);
	    &print_result();
	} else {
	    # error handling if error on fetching document to be checklink-ed
	    print "Output meaningful message\n";
	    print $r->headers_as_string,"\n";
	}
    }
}

# this is quite ugly, but I have both command-line and CGI modes here
# I should add different levels of verbosity I guess
# currently, CGI is more verbose than command-line (command-line
# does not show 200s)
# sorting by something is tricky. I'll look at it later. A nasty map-sort-map should do it
sub print_result{

    print "<table border=\"1\"><TR ALIGN=\"center\"><TD>Lines</TD><TD>URI</TD><TD>Code</TD><TD>Extra</TD></TR>\n" if($CGI);
    foreach my $resp (map {$response->{$_}->response} keys %$response){
	if($resp->code ne "200"){
	    print "<TR><TD ALIGN=\"center\">" if ($CGI);
	    print join(",",keys %{$URL{$resp->request->url}});
	    print "</TD><TD BGCOLOR=\"yellow\"><B>".$q->a({href=>$resp->request->url},$resp->request->url)."</B></TD><TD>",$resp->code,"</TD><TD>" if($CGI);
	    print " ",$resp->request->url, ": ",$resp->code," " if($VERBOSE);
	    if($resp->code == 401){
		print $resp->headers->www_authenticate;
	    }
	    print "</TD></TR>\n" if($CGI);
	} else {
	    print "<TR><TD ALIGN=\"center\">".join(",",keys %{$URL{$resp->request->url}})."</TD><TD>".$q->a({href=>$resp->request->url},$resp->request->url)."</TD><TD>",$resp->code,"</TD><TD></TD></TR>\n" if($CGI);
	}
    }
    print "</table>\n" if($CGI);
    print "\n" if($VERBOSE);
}

# I'll add links to source, and Webmaster icons later
# actually, links to source should be for Team version only
sub html_header {
    $q = shift;
    print $q->header;
    print $q->start_html(-title=>'W3C\'s Link Checker',-BGCOLOR=>'white');
}
