#!/usr/local/bin/perl

$|++;

$VERSION= '$Id: checklink.pl,v 1.3 1998-08-31 16:16:33 renaudb Exp $ ';

BEGIN {
    unshift@INC,('/usr/etc/apache/PerlLib');
}

use CGI qw(:standard);
#use CGI::Carp qw(fatalsToBrowser);
use W3CDebugCGI;
require LWP::Parallel::UserAgent;
require HTML::LinkExtor;

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
    $p->parse($response->content);
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
    $p = HTML::LinkExtor->new();

    $ua->max_hosts(10);
    $ua->max_req(20);

    # Request document and parse it as it arrives
    # prepare the request
    $ua->register(HTTP::Request->new(GET => $url), \&callback_parse);
    # process the request
    $res = $ua->wait(10);
    # reinitialize the UA
    $ua->initialize;

    # foreach not necessary since processing only one request
    # but we might be willing to checklink several pages
    foreach my $r (map {$res->{$_}->response} keys %$res){
	if ($r->is_success){
	    my $base = $r->base;
	    @links = $p->links;
	    print "$#links links\n" if($VERBOSE);
	    foreach $link (@links){
		# find absolute link
		$abso = new URI::URL($$link[2],$base);
		$SCHEMES{$abso->abs->scheme}++;
		# register HTTP request
		$ua->register(HTTP::Request->new(HEAD => $abso->abs),\&callback_check) if($ALLOWED_SCHEMES{$abso->abs->scheme});
	    }

	    # send HTTP requests down the wire
	    $response = $ua->wait(10);

	    # processing responses and pretty printing it

	    print "<table border=\"1\">\n" if($CGI);
	    foreach my $resp (map {$response->{$_}->response} keys %$response){
		if($resp->code ne "200"){
		    print $resp->request->url, ": ",,$resp->code," " if($VERBOSE);
		    print "<TR><TD>".$resp->code."</TD><TD BGCOLOR=\"yellow\"><B>".$q->a({href=>$resp->request->url},$resp->request->url)."</B></TD><TD>" if($CGI);
		    if($resp->code == 401){
			print $resp->headers->www_authenticate;
		    }
		    print "</TD></TR>\n" if($CGI);
		    print "\n" if($VERBOSE);
		} else {
		    print "<TR><TD>".$resp->code."</TD><TD>".$q->a({href=>$resp->request->url},$resp->request->url)."</TD><TD></TD></TR>\n" if($CGI);
		}
	    }
	    print "</table>\n" if($CGI);
	} else {
	    print "blobp\n";
	    print $r->headers_as_string,"\n";
	}
    }
}


sub html_header {
    $q = shift;
    print $q->header;
    print $q->start_html(-title=>'W3C\'s Link Checker',-BGCOLOR=>'white');
}
