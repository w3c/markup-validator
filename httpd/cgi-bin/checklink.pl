#!/usr/local/bin/perl -T
use strict;
$|++;

BEGIN {
    unshift@INC,('/usr/etc/apache/PerlLib');
}

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
#	print keys %{$self->{URL}{Registered}},"\n";
	$self->{URL}{Redirect}{$request->url} = $response->headers->header('Location');
	unless(defined $self->{URL}{Registered}{$response->headers->header('Location')}){
	    $self->register(HTTP::Request->new(HEAD => $response->headers->header('Location')),\&callback_check,undef,0);
	    $self->{URL}{Registered}{$response->headers->header('Location')}="True";
	}
    }
}

use CGI qw(:standard);
#use W3CDebugCGI;

###############
# Global Variables

my $VERSION= '$Id: checklink.pl,v 1.11 1998-09-06 01:00:15 renaudb Exp $ ';
my %ALLOWED_SCHEMES = ( "http" => 1 );
my %SCHEMES = (); # for report
my %URL = ();
my %COLORS = ( 301 => ' BGCOLOR="yellow"', 302 => ' BGCOLOR="yellow"', 404 => ' BGCOLOR="red"' , 401 => ' BGCOLOR="aqua"' );
my $VERBOSE = 0;
my $CGI = 0;
my $p = ParseLink->new(); # we want the parser to be global, so we can call it from callback_parse

###############################

if ($#ARGV == 0){
    $VERBOSE = 1;
    &checklinks($ARGV[0]);
} else {
    $CGI = 1;
    #my $query = new W3CDebugCGI($0, $ARGV[0] eq 'DEBUG', '/tmp/test', 0);
    my $query = new CGI;

    &doit($query);
}
 
sub doit {
    my $q=shift;
    
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
    return $LWP::Parallel::UserAgent::C_ENDCON;
}

sub callback_check {
    my ($content,$response,$protocol)=@_;
    if(length $content){
	print "Checking '",$response->request->url,": ", length $content,"\n" if($VERBOSE);
	return length $content;
    }
    return $UserAgent::C_ENDCON;
}

sub checklinks {
    my $url=URI::URL->new(shift);
    my $q = shift if($CGI);
    #my $ua = new LWP::Parallel::UserAgent;
    my $ua = new UserAgent;
    my $request = HTTP::Request->new(GET => $url);

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
    my $res = $ua->wait(10);
    $ua->initialize;
    $ua->{URL}= \%URL;
 
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
	    my $response = $ua->wait(10);
	    &print_result($url,$response,$q);
	} else {
	    # error handling if error on fetching document to be checklink-ed
	    if($r->code == 401){
		print $q->h3($r->request->url);
		$r->headers->www_authenticate =~ /Basic realm=\"([^\"]+)\"/;
		my $realm = $1;
		if($CGI){
		    print $q->h2('Authentication Required To Fetch '.$q->a({href=>$url},$url));
		    print $q->startform('POST',$q->url);
		    print $q->textfield(-name=>'url',-size=>'50',-value=>$url),$q->br;
		    print $q->textfield(-name=>'username',-size=>'10'),"Username for Realm ",$realm,$q->br;
		    print $q->password_field(-name=>'password',-size=>'10'),"Password",$q->br;
		    print $q->submit('Proceed');
		    print $q->endform;
		}
	    } else {
		print $q->h2('Error '.$r->code) if($CGI);
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
    my $response = shift;
    my $q = shift;

    print $q->h2('Result for '.$q->a({href=>$url},$url)) if($CGI);
    print "<table border=\"1\"><TR ALIGN=\"center\"><TD>Lines</TD><TD>URI</TD><TD>Code</TD><TD>Extra</TD></TR>\n" if($CGI);
    foreach my $resp (map {$response->{$_}->response} keys %$response){
	if(keys %{$URL{$resp->request->url}}){
	    unless($resp->code eq "200"){
		print "<TR><TD ALIGN=\"center\">" if ($CGI);
		print join(", ",sort {$a <=> $b} keys %{$URL{$resp->request->url}});
		if ($CGI){
		    print "</TD><TD".$COLORS{$resp->code}.">";
		    print "<B>".$q->a({href=>$resp->request->url},$resp->request->url)."</B>";
		    print $q->br.&recurse_redirect($resp->request->url,$q) if($resp->code == 301);
		    print "</TD><TD ALIGN=\"center\">".$resp->code."</TD><TD>";
		}
		print " ",$resp->request->url, ": ",$resp->code," " if($VERBOSE);
		print $resp->headers->www_authenticate if($resp->code == 401);
		print "</TD></TR>\n" if($CGI);
		print "\n" if($VERBOSE);
	    } else {
		if($CGI){
		    print "<TR><TD ALIGN=\"center\">".join(", ",sort keys %{$URL{$resp->request->url}})."</TD>";
		    print "<TD>".$q->a({href=>$resp->request->url},$resp->request->url)."</TD>";
		    print "<TD ALIGN=\"center\">ok</TD><TD></TD></TR>\n";
		}
	    }
	}
    }
    print "</table>\n";# if($CGI);
}

# I'll add links to source later
# actually, links to source should be for Team version only
sub html_header {
    my $q = shift;
    print $q->header;
    print $q->start_html(-title=>(defined $q->param('url')?'Checking '.$q->param('url'):'W3C\'s Link Checker'),-BGCOLOR=>'#FFFFFF');
    print $q->a({href=>"http://www.w3.org"},$q->img({src=>"http://www.w3.org/Icons/w3c_home",alt=>"W3C",border=>"0"}));
    print $q->a({href=>"http://www.w3.org/Web"},$q->img({src=>"http://www.w3.org/Icons/WWW/web",border=>"0",alt=>"Web Team"}));
    print $q->h1($q->a({href=>$q->url},'Link Checker'));
}

sub recurse_redirect {
    my $url = shift;
    my $q = shift;
    my $rec = $URL{Redirect}{$URL{Redirect}{$url}}? "<BR>".&recurse_redirect($URL{Redirect}{$url},$q):"";
    return "-&gt; ".$q->a({href=>$URL{Redirect}{$url}},$URL{Redirect}{$url}).$rec;
}
