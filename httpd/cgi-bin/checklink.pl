#!/usr/local/bin/perl
$|++;

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
    sub start {
	my $self=shift;
	my ($tag,$attr)=@_;
	my $link;
	$link=$attr->{href} if $tag eq "a";
	$link=$attr->{src} if $tag eq "img";
	if (defined $link){
	    $self->{Links}{$link}{$self->{Line}+1}++;
	}
    }
package UserAgent;
use LWP::Parallel::UserAgent;
use vars qw(@ISA);
@ISA = qw(LWP::Parallel::UserAgent);
sub on_return {
    my $self = shift;
    my ($request,$response,$content) = @_;
    if($response->code == 301){
	$main::URL{Redirect}{$request->url} = $response->headers->header('Location');
	print $request->url." -> ".$response->headers->header('Location')."\n" if($main::VERBOSE);
	unless(defined $main::URL{Registered}{$response->headers->header('Location')}){
	    $self->register(HTTP::Request->new(HEAD => $response->headers->header('Location')),\&callback_check,undef,0);
	    $main::URL{Registered}{$response->headers->header('Location')}="True";
	}
    }
}
}

use CGI qw(:standard);
#use CGI::Carp qw(fatalsToBrowser);
use W3CDebugCGI;

$VERSION= '$Id: checklink.pl,v 1.10 1998-09-05 00:19:26 renaudb Exp $ ';
%ALLOWED_SCHEMES = ( "http" => 1 );
%SCHEMES = (); # for report
%URL = ();

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

    if(defined $q->param('url')){
	&checklinks($q->param('url'),$q);
    } else {
	print $q->startform($q->url);
	print "Enter a URI ",$q->textfield(-name=>'url',-size=>'50'),$q->br;
	print $q->submit('Check the Links !');
	print $q->endform;
    }
    print $q->hr,$q->i($VERSION);
    print $q->end_html;
}



################################

sub callback_parse {
    my ($content,$response,$protocol)=@_;
    if(length $content){
	print "Fetching content from '", $response->request->url,"': ", length($content), " bytes, code ",$response->code,"\n" if($VERBOSE);
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
	print "Checking '",$response->request->url,": ", length $content,"\n" if($VERBOSE);
	return length $content;
    }
    return C_ENDCON;
}

sub checklinks {
    my $url=URI::URL->new(shift);
    my $q = shift if($CGI);
    #my $ua = new LWP::Parallel::UserAgent;
    my $ua = new UserAgent;
    my $request = HTTP::Request->new(GET => $url);
    $p = ParseLink->new(); # we want the parser to be global, so we can call it from the callback function

    $ua->max_hosts(10);
    $ua->max_req(20);
    $request->headers->user_agent('W3C/Checklink');

    # prepare the request
    # Request document and parse it as it arrives via callback
    # Then get the UA ready for the requests in the foreach loop
    if($CGI){
	if(defined $q->param('username')){
	    $request->headers->authorization_basic($q->param('username'),$q->param('password'));
	}
    }
    
    $ua->register($request, \&callback_parse);
    $res = $ua->wait(10);
    $ua->initialize;

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
		$ua->register(HTTP::Request->new(HEAD => $abso->abs),\&callback_check,undef,0) if($ALLOWED_SCHEMES{$abso->abs->scheme});
		$URL{Registered}{$abso->abs}="True";
	    }
	    $response = $ua->wait(10);
	    &print_result($url);
	} else {
	    # error handling if error on fetching document to be checklink-ed
	    if($r->code == 401){
		$r->headers->www_authenticate =~ /Basic realm=\"([^\"]+)\"/;
		my $realm = $1;
		print $q->h2('Authentication Required To Fetch '.$q->a({href=>$url},$url));
		print $q->startform('POST',$q->url);
		print $q->textfield(-name=>'url',-size=>'50',-value=>$url),$q->br;
		print $q->textfield(-name=>'username',-size=>'10'),"Username for Realm ",$realm,$q->br;
		print $q->password_field(-name=>'password',-size=>'10'),"Password",$q->br;
		print $q->submit('Proceed');
		print $q->endform;
	    } else {
		print $q->h2('Error '.$r->code);
	    }
	}
    }
}

# this is quite ugly, but I have both command-line and CGI modes here
# I should add different levels of verbosity I guess
# currently, CGI is more verbose than command-line (command-line
# does not show 200s)
# sorting by something is tricky. I'll look at it later. A nasty map-sort-map should do it
sub print_result{
    my $url = shift;

    print $q->h2('Result for '.$q->a({href=>$url},$url)) if($CGI);
    print "<table border=\"1\"><TR ALIGN=\"center\"><TD>Lines</TD><TD>URI</TD><TD>Code</TD><TD>Extra</TD></TR>\n" if($CGI);
    foreach my $resp (map {$response->{$_}->response} keys %$response){
	unless($resp->code eq "200"){
	    print "<TR><TD ALIGN=\"center\">" if ($CGI);
	    print join(",",sort keys %{$URL{$resp->request->url}});
	    print "</TD><TD BGCOLOR=\"yellow\"><B>".$q->a({href=>$resp->request->url},$resp->request->url)."</B></TD><TD ALIGN=\"center\">",$resp->code,"</TD><TD>" if($CGI);
	    print " ",$resp->request->url, ": ",$resp->code," " if($VERBOSE);
	    print $resp->headers->www_authenticate if($resp->code == 401);
	    print &recurse_redirect($resp->request->url) if($resp->code == 301 && $CGI);
	    print "</TD></TR>\n" if($CGI);
	    print "\n" if($VERBOSE);
	} else {
	    print "<TR><TD ALIGN=\"center\">".join(",",sort keys %{$URL{$resp->request->url}})."</TD><TD>".$q->a({href=>$resp->request->url},$resp->request->url)."</TD><TD ALIGN=\"center\">ok</TD><TD></TD></TR>\n" if($CGI);
	}
    }
    print "</table>\n" if($CGI);
}

# I'll add links to source later
# actually, links to source should be for Team version only
sub html_header {
    $q = shift;
    print $q->header;
    print $q->start_html(-title=>(defined $q->param('url')?'Checking '.$q->param('url'):'W3C\'s Link Checker'),-BGCOLOR=>'white');
    print $query->a({href=>"http://www.w3.org"},$query->img({src=>"http://www.w3.org/Icons/w3c_home",alt=>"W3C",border=>"0"}));
    print $query->a({href=>"http://www.w3.org/Web"},$query->img({src=>"http://www.w3.org/Icons/WWW/web",border=>"0",alt=>"Web Team"}));
    print $q->h1($q->a({href=>$q->url},'Link Checker'));
}

sub recurse_redirect {
    my $url = shift;
    my $rec = $URL{Redirect}{$URL{Redirect}{$url}}? "<BR>".&recurse_redirect($URL{Redirect}{$url}):"";
    return "-&gt;".$URL{Redirect}{$url}.$rec;
}
