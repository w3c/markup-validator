#! /usr/bin/perl -w
#
# W3C Link Checker
# by Hugo Haas
# (c) 1999-2000 World Wide Web Consortium
# based on Renaud Bruyeron's checklink.pl
#
# $Id: LinkChecker.pl,v 1.28 2000-02-08 21:48:34 hugo Exp $
#
# This program is licensed under the W3C(r) License.
#
# See the CVSweb interface at:
#	http://dev.w3.org/cvsweb/validator/httpd/cgi-bin/LinkChecker.pl
#
# An online version is available at:
#	http://validator.w3.org/checklink

use strict;

package W3C::LinkChecker;
require HTML::Parser;
@W3C::LinkChecker::ISA = qw(HTML::Parser);
package W3C::UserAgent;
require LWP::UserAgent;
@W3C::UserAgent::ISA = qw(LWP::UserAgent);

# Autoflush
$| = 1;

# Version info
my $PROGRAM = 'W3C LinkChecker';
my $VERSION = q$Revision: 1.28 $ . '(c) 1999-2000 W3C';
my $REVISION; ($REVISION = $VERSION) =~ s/Revision: (\d+\.\d+) .*/$1/;

# State of the program
my $_cl;
my $_quiet = 0;
my $_summary = 0;
my $_verbose = 0;
my $_progress = 0;
my $_html = 0;
my $_timeout = 60;
my $_chunksize = 1024;
my $_redirects = 1;
my $_user;
my $_password;
my $_trusted = '\.w3\.org';
my $_http_proxy;
my $first;
my $query;

if ($#ARGV >= 0) {
    $_cl = 1;
# Parse command line
    my @uris = &parse_arguments();
    if ($_user && (! $_password)) {
        &ask_password();
    }
    my $uri;
    foreach $uri (@uris) {
	if (! $_summary) {
            printf("%s %s\n", $PROGRAM ,$VERSION);
        } else {
            $_verbose = 0;
            $_progress = 0;
        }
        $uri = urize($uri);
        &check_uri($uri);
    }
} else {
    use CGI;
    use CGI::Carp qw(fatalsToBrowser);
    $query = new CGI;
    $_cl = 0;
    $_verbose = 0;
    $_progress = 0;
    if ($query->param('summary')) {
        $_summary = 1;
    } else {
    }
    if (! $query->param('redirects')) {
        $_redirects = 0;
    }
    $_html = 1;
    my $uri;
    if ($query->param('uri')) {
        $uri = $query->param('uri');
    } elsif ($query->param('url')) {
        $uri = $query->param('url');
    } else {
        &print_form($query);
    }
    if ($uri =~ m/^file:/) {
        &file_uri($uri);
    } elsif (!($uri =~ m/:/)) {
        $uri = 'http://'.$uri;
    }
    &check_uri($uri);
}

###############################################################################

################################
# Command line and usage stuff #
################################

sub parse_arguments() {
    my @uris;
    my $uris = 0;
    while (@ARGV) {
        $_ = shift(@ARGV);
        if ($uris) {
            push(@uris, $_);
        } elsif (m/^--$/) {
            $uris = 1;
        } elsif (m/^-[^-upytdc]/) {
            if (m/q/) {
                $_quiet = 1;
                $_summary = 1;
            }
            if (m/s/) {
                $_summary = 1;
            }
            if (m/b/) {
                $_redirects = 0;
            }
            if (m/v/) {
                $_verbose = 1;
            }
            if (m/i/) {
                $_progress = 1;
            }
            if (m/h/) {
                $_html = 1;
            }
        } elsif (m/^--help$/) {
            &usage();
        } elsif (m/^--quiet$/) {
            $_quiet = 1;
        } elsif (m/^--summary$/) {
            $_summary = 1;
        } elsif (m/^--broken$/) {
            $_redirects = 0;
        } elsif (m/^--verbose$/) {
            $_verbose = 1;
        } elsif (m/^--indicator$/) {
            $_progress = 1;
        } elsif (m/^--html$/) {
            $_html = 1;
        } elsif (m/^-u|--user$/) {
            $_user = shift(@ARGV);
        } elsif (m/^-p|--password$/) {
            $_password = shift(@ARGV);
        } elsif (m/^-t|--timeout$/) {
            $_timeout = shift(@ARGV);
        } elsif (m/^-d|--domain$/) {
            $_trusted = shift(@ARGV);
        } elsif (m/^-y|--proxy$/) {
            $_http_proxy = shift(@ARGV);
        } elsif (m/^-c|--chunksize$/) {
            $_chunksize = shift(@ARGV);
        } else {
            push(@uris, $_);
        }
    }
    return(@uris);
}

sub usage() {
    print STDERR "$PROGRAM $VERSION
Usage: LinkCheck.pl <options> <uris>
Options:
	-s/--summary		Result summary only.
	-b/--broken		Show only the broken links, not the redirects.
	-q/--quiet		No output if no errors are found.
	-v/--verbose		Verbose mode.
	-i/--indicator		Show progress while parsing.
	-u/--user username	Specify a username for authentication.
	-p/--password password	Specify a password.
	-t/--timeout value	Timeout for the HTTP requests.
	-d/--domain domain	Regular expression describing the domain to
				which the authetication information will be
				sent (default: $_trusted).
	-y/--proxy proxy	Specify an HTTP proxy server.
	-c/--chunk-size size	Size of the blocks parsed (default: $_chunksize).
	-h/--html		HTML output.
	--help			Show this message.
";
    exit(0);
}

sub ask_password() {
    print(STDERR 'Enter your password: ');
    system('stty -echo');
    chomp($_password = <STDIN>);
    system('stty echo');
    print(STDERR "ok.\n");
}

###############################################################################

###########################################
# Transform foo into file://localhost/foo #
###########################################

sub urize() {
    use URI;
    $_ = URI::Escape::uri_unescape($_[0]);
    my $base;
    my $res = $_;
    if (m/:/) {
        $base = URI->new($_);
    } elsif (m/^\//) {
        $base = URI->new('file://localhost');
    } else {
        my $pwd;
        chop($pwd = `pwd`);
        $base = URI->new('file://localhost'.$pwd.'/');
    }
    my $u = URI->new($res);
    my $result = $u->abs($base);
    return($result->as_string());
}

#######################
# Do the job on a URI #
#######################

sub check_uri() {
    my $uri = $_[0];
    if ($_html) {
        $first = 1;
    } else {
        $first = 0;
    }
    my $start;
    if (! $_summary) {
        $start = &get_timestamp();
        if (! $_html) {
            printf("\nProcessing\t%s\n", $uri);
        }
    }
    # Get the document
    my $response = &get_uri('GET', $uri);
    $first = 0;
    if (! $response->is_success()) {
        if ($response->code() == 401) {
            &authentication($response);
        } else {
            if ($_html) {
                &html_header($uri);
            }
            &hprintf("Error: %d %s\n",
                     $response->code(), $response->message());
            if ($_html) {
                &html_footer();
            }
        }
        exit(-1);
    }
    if ($_html) {
        &html_header($uri);
        if (! $_summary) {
            print "<pre>\n";
        }
    }
    my %redirects;
    &record_redirects(\%redirects, $response->{Redirects});
    # Parse the document
    if (! ($response->header('Content-type') =~ m/text\/html/)) {
        &hprintf("Can't check link: Content-type is '%s'.\n",
                 $response->header('Content-type'));
        return(-1);
    }
    # URL manipulation
    my $base_uri = URI->new($response->base());
    my $uri_uri = URI->new($uri);
    my $absolute_base = $base_uri->abs($uri_uri);
    my $p = &parse_document($absolute_base->as_string(), $response->content(), 1);
    my $base = URI->new($p->{base});

    # Check anchors
    ###############
    if (! $_summary) {
        print("Checking anchors:\n");
    }
    my %errors;
    my $anchor;
    foreach $anchor (keys %{$p->{Anchors}}) {
        my @lines = keys %{$p->{Anchors}{$anchor}};
        my $times = $#lines + 1;
        if ($times > 1) {
            $errors{$anchor} = 1;
        }
        if ($anchor eq '') {
            $errors{$anchor} = 1;
        }
    }
    if (! $_summary) {
        print(" done.\n");
    }

    # Check links
    #############
    my %links;
    # Record all the links
    my $link;
    foreach $link (keys %{$p->{Links}}) {
        my $link_uri = URI->new($link);
        my $abs_link_uri = URI->new_abs($link_uri, $base);
        my $lines;
        foreach $lines (keys %{$p->{Links}{$link}}) {
            my $canonical = URI->new($abs_link_uri->canonical());
            my $url = $canonical->scheme().':'.$canonical->opaque();
            my $fragment = $canonical->fragment()
                ? $canonical->fragment() : $url;
            $links{$url}{$fragment}{$lines} = 1;
        }
    }
    my $url;
    for $url (keys %links) {
        if (!defined($links{$url}{$url})) {
            $links{$url}{$url}{-1} = 1;
        }
    }
    my %results;
    # Record the paged tested in the results hash
    $results{$uri}{$uri}{code} = 200;
    $results{$uri}{$uri}{display} = $results{$uri}{$uri}{code};
    $results{$uri}{$uri}{orig} = $results{$uri}{$uri}{code};
    $results{$uri}{$uri}{message} = 'Page tested';
    $results{$uri}{$uri}{success} = 1;
    # Build the list of broken URI's
    my %broken;
    my $u;
    foreach $u (keys %links) {
        # Don't check mailto: URI's
        next if ($u =~ m/^mailto:/);
        if (! $_summary) {
            &hprintf("Checking link %s\n", $u);
        }
        &check_validity($uri, $u, \%links, \%results, \%redirects, $p->{Anchors}, $response->code());
        if ($_verbose) {
            &hprintf("\tReturn code: %s\n", $results{$u}{$u}{code});
        }
        if ($results{$u}{$u}{success}) {
            my $fragment;
            foreach $fragment (keys %{$links{$u}}) {
                next if ($fragment eq $u);
                if ($_verbose) {
                    &hprintf("\t\t%s %s - Lines: %s\n",
                             $fragment,
                             ($results{$u}{$fragment}?'OK':'Not found'),
                             join(',', keys %{$links{$u}{$fragment}}));
                }
                # A broken fragment?
                if ($results{$u}{$fragment} == 0) {
                    $broken{$u}{$fragment} += 2;
                }
            }
        } else {
            # Couldn't find the document
            $broken{$u}{$u} = 1;
            my $fragment;
            foreach $fragment (keys %{$links{$u}}) {
                $broken{$u}{$fragment}++;
            }
        }
    }
    if (! $_summary) {
        my $stop = &get_timestamp();
        &hprintf("Processed in %ss.\n", &time_diff($start, $stop));
    }
    # Display results
    if ($_html) {
        if (! $_summary) {
            print "</pre><hr>\n";
        }
    }
    if (! $_quiet) {
        print "\n";
    }
    &anchors_summary($p->{Anchors}, \%errors);
    &links_summary(\%links, \%results, \%broken, \%redirects);
    if ($_html) {
        &html_footer();
    }
}

############################
# Get the content of a URI #
############################

sub W3C::UserAgent::simple_request() {
    my $self = shift;
    my $response = $self->SUPER::simple_request(@_);
    if (! defined($self->{FirstResponse})) {
        $self->{FirstResponse} = $response->code();
        $self->{FirstMessage} = $response->message();
    }
    return $response;
}

sub W3C::UserAgent::redirect_ok {
    my ($self, $request) = @_;
    
    if (! ($_summary || $first)) {
        &hprintf("\n%s %s ", $request->method(), $request->uri());
    }

    $self->{Redirects}{$self->{fetching}} = $request->uri();
    $self->{fetching} = $request->uri();

    return 0 if $request->method() eq "POST";
    return 1;
}

sub get_uri() {
    # Here we have a lot of extra parameters in order not to lose information
    # if the function is called several times (401's)
    my ($method, $uri, $start, $redirects, $code, $realm, $message, $tested) = @_;
    if (! defined($start)) {
        $start = &get_timestamp();
    }
    # Prepare the query
    my $ua = new W3C::UserAgent;
    $ua->timeout($_timeout);
    $ua->agent('W3CLinkChecker/'.$REVISION.' '.$ua->agent());
    if ($_http_proxy) {
        $ua->proxy('http', 'http://'.$_http_proxy);
    }
    $ua->{uri} = $uri;
    $ua->{fetching} = $uri;
    if (defined($redirects)) {
        $ua->{Redirects} = $redirects;
    }
    my $count = 0;
    my $response;
    if (! ($_summary || $first)) {
        &hprintf("%s %s ", $method, $uri);
    }
    my $request = new HTTP::Request($method, $uri);
    # Are we providing authentication info?
    if (defined($tested)
        && ($request->url->netloc =~ /$_trusted$/)) {
        if (defined($ENV{HTTP_AUTHORIZATION})) {
            $request->headers->header(Authorization => $ENV{HTTP_AUTHORIZATION});
        } elsif (defined($_user) && defined($_password)) {
            use MIME::Base64;
            my $authorization = encode_base64($_user.':'.$_password);
            $request->headers->header(Authorization => 'Basic '.$authorization);
        }
    }
    # Do the query
    $response = $ua->request($request);
    # Get the results
    if (! defined($code)) {
        $code = $ua->{FirstResponse};
    }
    if (! defined($message)) {
        $message = $ua->{FirstMessage};
    }
    # Authentication requested?
    if (($response->code() == 401)
        && (defined($ENV{HTTP_AUTHORIZATION})
            || (defined($_user) && defined($_password)))
        && !defined ($tested)) {
        # Deal with authentication and avoid loops
        if (! defined ($realm)) {
            $response->headers->www_authenticate =~ /Basic realm=\"([^\"]+)\"/;
            $realm = $1;
        }
        if (! ($_summary || $first)) {
            print "\n";
        }
        return &get_uri($method, $response->request->url,
                        $start, $ua->{Redirects}, 
                        $code, $realm, $message, 1);
    }
    # Record the redirects
    $response->{Redirects} = $ua->{Redirects};
    my $stop = &get_timestamp();
    if (! ($_summary || $first)) {
        &hprintf(" fetched in %ss\n", &time_diff($start,$stop));
    }
    $response->{OriginalCode} = $code;
    $response->{OriginalMessage} = $message;
    if (defined($realm)) {
        $response->{Realm} = $realm;
    }
    return $response;
}

####################
# Parse a document #
####################

sub parse_document() {
    my ($uri, $document, $links) = @_;

    my $start;
    my $p = W3C::LinkChecker->new();
    # Loose interpretation of the HTML comments since browsers will do the same
    $p->strict_comment(0);
    if (! $_summary) {
        $start = &get_timestamp();
        print("Parsing...\n");
    }
    $p->{base} = $uri;
    $p->{Line} = 1;
    if (!$_summary || $_progress) {
        $p->{Total} = ($document =~ tr/\n//);
    }
    $p->{extract_links} = $links;
    my @chunks = unpack("a$_chunksize"x(length($document)/$_chunksize).'a*',
                        $document);
    for (@chunks) {
        $p->parse($_);
    }
    if (! $_summary) {
        my $stop = &get_timestamp();
        if ($_progress) {
            print "\r";
        }
        &hprintf(" done (%d lines in %ss).\n",
                 $p->{Total}, &time_diff($start, $stop));
    }
    return $p;
}

#######################################
# Count the number of lines in a file #
#######################################

sub W3C::LinkChecker::new_line() {
    my ($self, $string) = @_;
    my $count = ($string =~ tr/\n//);
    $self->{Line} = $self->{Line} + $count;
    if ($_progress) {
        printf("\r%4d%%", int($self->{Line}/$self->{Total}*100));
    }
}

#######################################
# start function used by HTML::Parser #
#######################################

sub W3C::LinkChecker::start() {
    my ($self, $tag, $attr, $attrseq, $text) = @_;
    my $anchor;
    # Links
    if ($self->{extract_links}) {
        my $link;
        if ($tag eq 'a') {
            $link = $attr->{href};
            $anchor = $attr->{name};
        } elsif ($tag eq 'img') {
            $link = $attr->{src};
        } elsif (($tag eq 'frame') || ($tag eq 'link')) {
            $link = $attr->{href};
        }
        if (defined($link)) {
            $self->{Links}{$link}{$self->{Line}}++;
        }
    # Just anchors
    } else {
        if ($tag eq 'a') {
            $anchor = $attr->{name};
        }
    }
    if (defined($anchor)) {
        $self->{Anchors}{$anchor}{$self->{Line}}++;
    }
    # Line counting
    if ($text =~ m/\n/) {
        $self->new_line($text);
    }
}

####################################################
# Overloading functions for line counting purposes #
####################################################

sub W3C::LinkChecker::text() {
    my ($self, $text) = @_;
    if (!$_progress) {
        return unless $self->{extract_links};
    }
    if ($text =~ /\n/) {
        $self->new_line($text);
    }
}

sub W3C::LinkChecker::end() {
    my $self = shift;
    return unless $self->{extract_links};
    shift;
    my $text = shift;
    $self->text($text);
}

sub W3C::LinkChecker::declaration() {
    my $self = shift;
    return unless $self->{extract_links};
    my $text = shift;
    $self->text($text);
}

sub W3C::LinkChecker::comment() {
    my $self = shift;
    return unless $self->{extract_links};
    my $text = shift;
    $self->text($text);
}

################################
# Check the validity of a link #
################################

sub check_validity($, $, \%, \%, \%, \%, $) {
    use HTTP::Status;
    my ($testing, $uri, $links, $results, $redirects, $anchors, $testing_code) = @_;
    # Checking file: URI's is not allowed with a CGI
    if ($testing ne $uri) {
        if ((! $_cl) && (!($testing =~ m/^file:/)) && ($uri =~ m/^file:/)) {
            # Can't test? Return 400 Bad request.
            $results->{$uri}{$uri}{code} = 400;
            $results->{$uri}{$uri}{success} = 0;
            $results->{$uri}{$uri}{message} = 'Error: \'file:\' URI not allowed';
            if ($_verbose) {
                &hprintf("Error: %d %s\n",
                         $results->{$uri}{$uri}{code},
                         $results->{$uri}{$uri}{message});
            }
            return;
        }
    }
    # Get the document with the appropriate method
    my $method;
    my @fragments = keys %{$links->{$uri}};
    if ($testing eq $uri) {
        if (! $_summary) {
            printf("Checking link %s\nNo need to be fetched.\n", $uri);
        }
    } elsif ($#fragments == 0) {
        $method = 'HEAD';
    } else {
        $method = 'GET';
    }
    my $response;
    if ($testing eq $uri) {
        # Mimic an HTTP::Response object if we already have the document
        $results->{$uri}{$uri}{code} = $testing_code;
        $results->{$uri}{$uri}{success} = 1;
    } else {
        $response = &get_uri($method, $uri);
        # Record the redirects
        &record_redirects($redirects, $response->{Redirects});
        # Get the information back from get_uri()
        $results->{$uri}{$uri}{code} = $response->code();        
        $results->{$uri}{$uri}{display} = $results->{$uri}{$uri}{code};
        $results->{$uri}{$uri}{orig} = $response->{OriginalCode};
        # Did we get a redirect?
        if ($response->{OriginalCode} != $response->code()) {
            $results->{$uri}{$uri}{orig_message} =  $response->{OriginalMessage};
            $results->{$uri}{$uri}{redirected} = 1;
        }
        $results->{$uri}{$uri}{success} = $response->is_success();
        # Stores the authentication information
        if (defined($response->{Realm})) {
            $results->{$uri}{$uri}{realm} = $response->{Realm};
            $results->{$uri}{$uri}{display} = 401;
        }
        # Did it fail?
        if (! $results->{$uri}{$uri}{success}) {
            $results->{$uri}{$uri}{message} = $response->message();
            if ($_verbose) {
                &hprintf("Error: %d %s\n",
                         $results->{$uri}{$uri}{code},
                         $results->{$uri}{$uri}{message});
            }
            return;
        }
    }
    if ($#fragments == 0) {
        return;
    }
    # There are fragments. Parse the document.
    my $p;
    if ($testing ne $uri) {
        if (!(($results->{$uri}{$uri}{type} = $response->header('Content-type')) =~ m/text\/html/i)) {
            if ($_verbose) {
                &hprintf("Can't check content: Content-type is '%s'.\n",
                         $response->header('Content-type'));
            }
            return;
        }
        $p = &parse_document($response->base(), $response->as_string(), 0);
    } else {
        $p->{Anchors} = $anchors;
    }
    # Check that the fragments exist
    my $fragment;
    foreach $fragment (keys %{$links->{$uri}}) {
        next if ($fragment eq $uri);
        if (defined($p->{Anchors}{$fragment})
            || &escape_match($fragment, $p->{Anchors})) {
            $results->{$uri}{$fragment} = 1;
        } else {
            $results->{$uri}{$fragment} = 0;
        }
    }
}

sub escape_match($, \%) {
    use URI::Escape;
    my ($a, $hash) = (uri_unescape($_[0]), $_[1]);
    foreach $b (keys %$hash) {
        if ($a eq uri_unescape($b)) {
            return(1);
        }
    }
    return(0);
}

##########################
# Ask for authentication #
##########################

sub authentication() {
    my $r = $_[0];
    $r->headers->www_authenticate =~ /Basic realm=\"([^\"]+)\"/;
    my $realm = $1;
    my $authHeader = $r->headers->www_authenticate;                                 
    if ($_cl) {
        printf(STDERR "Authentication is required for %s.\n", $r->request->url);
        printf(STDERR "The realm is %s.\n", $realm);
        print(STDERR "Use the -u and -p options to specify a username and password.\n");
    } else {
        printf("Status: 401 Authorization Required\nWWW-Authenticate: %s\nConnection: close\nContent-Type: text/html\n\n", $r->headers->www_authenticate);
        printf("<!DOCTYPE HTML PUBLIC \"-//W3C//DTD HTML 4.0//EN\">
<html>
<head>
<title>401 Authorization Required</title>
</head>
<body>
<h1>Authorization Required</h1>
<p>You need %s access to %s to perform Link Checking.</p>
</body>
</html>
", $realm, $r->request->url);
    }
}

##################
# Get statistics #
##################

sub get_timestamp() {
    require 'sys/syscall.ph';
    my $timestamp = pack('LL', ());
    syscall(&SYS_gettimeofday, $timestamp, 0) != -1 or $timestamp = 0;
    return($timestamp);
}

sub time_diff() {
    my @start = unpack('LL', $_[0]);
    my @stop = unpack('LL', $_[1]);
    for ($start[1], $stop[1]) {
        $_ /= 1_000_000;
    }
    return(sprintf("%.2f", ($stop[0]+$stop[1])-($start[0]+$start[1])));
}

########################
# Handle the redirects #
########################

# Record the redirects in a hash
sub record_redirects(\%, \%) {
    my ($redirects, $sub) = @_;
    my $r;
    foreach $r (keys %$sub) {
        $redirects->{$r} = $sub->{$r};
    }
}

# Determine if a request is redirected
sub is_redirected($, %) {
    my ($uri, %redirects) = @_;
    return(defined($redirects{$uri}));
}

# Get a list of redirects for a URI
sub get_redirects($, %) {
    my ($uri, %redirects) = @_;
    my @history = ($uri);
    my $origin = $uri;
    my %seen;
    while ($redirects{$uri}) {
        $uri = $redirects{$uri};
        push(@history, $uri);
        last if ($uri eq $origin);
    }
    return(@history);
}

#####################
# Print the results #
#####################

sub anchors_summary(\%, \%) {
    my ($anchors, $errors) = @_;
    # Number of anchors found.
    if (! $_quiet) {
        if ($_html) {
            print('<p>');
        }
        my @anchors = keys %{$anchors};
        &hprintf("Found %d anchors.", $#anchors+1);
        if ($_html) {
            print('</p>');
        }
        print("\n");
    }
    # List of the duplicates, if any.
    my @errors = keys %{$errors};
    if ($#errors < 0) {
        if (! $_quiet && $_html) {
            print "<p>Valid anchors!</p>\n";
        }
        return;
    }
    if ($_html) {
        print('<p>');
    }
    print('List of duplicate and empty anchors:');
    if ($_html) {
        print("</p>\n<table border=\"1\">\n<tr><td><b>Anchors</b></td><td><b>Lines</b></td></tr>");
    }
    print("\n");
    my $anchor;
    foreach $anchor (@errors) {
        my $format;
        if ($_html) {
            $format = "<tr><td>%s</td><td>%s</td></tr>\n";
        } else {
            $format = "\t%s\tLines: %s\n";
        }
        printf($format, &encode($anchor eq '' ? 'Empty anchor' : $ anchor), join(', ', sort {$a <=> $b} keys %{$anchors->{$anchor}}));
    }
    if ($_html) {
        print("</table>\n");
    }
}

sub links_summary(\%,\%,\%) {
    # Advices to fix the problems

    my %todo = ( 200 => 'nothing !',
                 300 => 'it usually means that there is a typo in a link that triggers <strong>mod_speling</strong> action - this should be fixed',
                 301 => 'usually nothing, unless the end point of the redirect is broken (in which case, the <B>Code</B> column is RED)',
                 302 => 'usually nothing, unless the end point of the redirect is broken (in which case, the <B>Code</B> column is RED)',
                 400 => 'Usually the sign of a malformed URL that cannot be parsed by the server',
                 401 => 'The link is not public. You had better specify it.',
                 403 => 'The link is forbidden ! This needs fixing. Usual suspect: a missing Overview.html or index.html, or bad access control',
                 404 => 'The link is broken. Fix it <B>NOW</B>',
                 405 => 'The server does not allow HEAD requests. How liberal. Go ask the guys who run this server why.',
                 407 => 'The link is a proxy, but requires Authentication.',
                 408 => 'The request timed out',
                 415 => 'The media type is not supported.',
                 500 => 'The server failed. It is a server side problem.',
                 501 => 'HEAD or GET is not implemented on this server... What kind of server is that?',
                 503 => 'The server cannot service the request, for some unknown reason');

    my ($links, $results, $broken, $redirects) = @_;

    if (! $_quiet) {
        if ($_html) {
            print("\n<hr>\n\n<p>");
        }
        my @links = keys %$links;
        my $n_fragments = 0;
        my $n_total = 0;
        my $u;
        foreach $u (@links) {
            my @fragments = keys %{$links->{$u}};
            $n_fragments += $#fragments + 1;
            my $f;
            foreach $f (@fragments) {
                my @lines = keys %{$links->{$u}{$f}};
                my $l;
                foreach $l (@lines) {
                    $n_total += $links->{$u}{$f}{$l};
                }
            }
        }
        &hprintf("Found %d locations for %d URI's (%d total).",
                 $#links+1, $n_fragments, $n_total);
        if ($_html) {
            print('</p>');
        }
        print("\n");
    }

    if ($_html) {
        # Print a summary
        my %code_summary;
        my $u;
        foreach $u (keys %$links) {
            if (defined($results->{$u}{$u}{orig}))  {
                $code_summary{$results->{$u}{$u}{orig}}++;
            }
        }
        print "<table border=\"1\">\n<tr><td><b>Code</b></td><td><b>Occurences</b></td><td><b>What to do</b></td></tr>\n";
        my $code;
        foreach $code (sort(keys(%code_summary))) {
            printf("<tr%s>", &bgcolor($code));
            printf("<td>%s</td>", $code);
            printf("<td>%s</td>", $code_summary{$code});
            printf("<td>%s</td>", $todo{$code});
            print "</tr>\n";
        }
        print "</table>\n";
    }

    # List of the broken links
    my @urls = keys %{$broken};
    if ($_redirects) {
        # Add the redirected URI's to the report
        my $l;
        for $l (keys %$redirects) {
            next unless (defined($results->{$l})
                         && !defined($broken->{$l}));
            push(@urls, $l);
        }
    }
    if ($#urls < 0) {
        if (! $_quiet && $_html) {
            print "<p>Valid links!</p>\n";
        }
        return;
    }
    if ($_html) {
        print('<p>');
    }
    print("\nList of broken ");
    if ($_redirects) {
        print('and redirected ');
    }
    print('links:');
    if ($_html) {
        print('<br>Broken fragments appear in red</p>');
    }
    if ($_html) {
        print("</p>\n<table border=\"1\">\n<tr><td><b>Location</b></td><td><b>Code</b></td><td><b>Fragment</b></td><td><b>Lines</b></td></tr>");
    }
    print("\n");
    my $u;
    foreach $u (@urls) {
        my @fragments = keys %{$broken->{$u}};
        # Count the rows displayed
        my $n_fragments = $#fragments+1;
        if (!defined($broken->{$u}{$u})) {
            $n_fragments++;
        }
        # Did we get a redirect?
        my $redirected = &is_redirected($u, %$redirects);
        # List of lines
        my @total_lines;
        my $f;
        foreach $f (keys %{$links->{$u}}) {
            if ($f eq $u) {
                next if (defined($links->{$u}{$u}{-1}));
            }
            my $l;
            foreach $l (keys %{$links->{$u}{$f}}) {
                push (@total_lines, $l);
            }
        }
        my $lines_list = join(', ',
                              sort {$a <=> $b} @total_lines);
        if ($_html) {
            # Main info
            my @redirects_urls = &get_redirects($u, %$redirects);
            for (@redirects_urls) {
                $_ = &show_url($_);
            }
            printf("<tr><th rowspan=\"%d\"%s>%s</th><th rowspan=\"%d\"%s>%d%s%s%s%s</th><td>%s</td><td%s>%s</td></tr>\n",
                   # Number of fragments (for rowspan)
                   $n_fragments,
                   # Color
                   &bgcolor($results->{$u}{$u}{display}),
                   # List of redirects
                   $redirected ? join('<br>-&gt; ',
                                      @redirects_urls) : &show_url($u),
                   # Number of fragments (for rowspan)
                   $n_fragments,
                   # Color
                   &bgcolor($results->{$u}{$u}{orig}),
                   # Original HTTP reply
                   $results->{$u}{$u}{orig},
                   # Final HTTP reply
                   ($results->{$u}{$u}{code} != $results->{$u}{$u}{orig})
                   ? '-&gt; '.&encode($results->{$u}{$u}{code})
                   : '',
                   # Realm
                   defined($results->{$u}{$u}{realm})
                   ? '<br>Realm: '.&encode($results->{$u}{$u}{realm})
                   : '',
                   # HTTP original message
                   defined($results->{$u}{$u}{orig_message})
                   ? '<br>'.&encode($results->{$u}{$u}{orig_message}).' -&gt;' 
                   : '',
                   # HTTP final message
                   $results->{$u}{$u}{message}
                   ? '<br>'.&encode($results->{$u}{$u}{message})
                   : '',
                   '',
                   # Color again
                   &bgcolor($results->{$u}{$u}{code}),
                   # List of lines
                   $lines_list);
        } else {
            printf("\n%s\t%s\n  Code: %d%s %s\n",
                   # List of redirects
                   $redirected ? join("\n-> ",
                                      &get_redirects($u, %$redirects)) : $u,
                   # List of lines
                   $lines_list ? 'Lines: '.$lines_list : '' ,
                   # Original HTTP reply
                   $results->{$u}{$u}{orig},
                   # Final HTTP reply
                   ($results->{$u}{$u}{code} != $results->{$u}{$u}{orig})
                   ? ' -> '.$results->{$u}{$u}{code}
                   : '',
                   # HTTP message
                   $results->{$u}{$u}{message} ? $results->{$u}{$u}{message} : '');
        }
        # Fragments
        foreach $f (@fragments) {
            next if ($f eq $u);
            if ($_html) {
                my $color = ($broken->{$u}{$f} > 1) ? &bgcolor(404) : &bgcolor($results->{$u}{$u}{code});
                printf("<tr><td%s>%s</td><td%s>%s</td></tr>\n",
                       # Color
                       $color,
                       # Broken fragment
                       &show_url($u, $f),
                       # Color
                       $color,
                       # List of lines
                       join(', ',
                            sort {$a <=> $b} keys %{$links->{$u}{$f}}));
            } else {
                printf("\t%-30s\tLines: %s\n",
                       # Fragment
                       $f,
                       # List of lines
                       join(', ',
                            sort {$a <=> $b} keys %{$links->{$u}{$f}}));
            }
        }
    }
    if ($_html) {
        print("</table>\n");
    }
}

###############################################################################

##################
# HTML interface #
##################

sub html_header() {
    my $uri = &encode($_[0]);
    # Cache control?
    if (defined($_[1])) {
        print "Cache-Control: no-cache\nPragma: no-cache\n";
    }
    print "Content-type: text/html

<!DOCTYPE HTML PUBLIC \"-//W3C//DTD HTML 4.0 Transitional//EN\">
<html>
<head>
<title>W3C Link Ckecker: $uri</title>
<style type=\"text/css\">

BODY {
  font-family: sans-serif;
  color: black;
  background: white;
}

A:link, A:active {
  color: #00E;
  background: transparent;
}

A:visited {
  color: #529;
  background: transparent;
}

PRE {
  font-family: monospace
}

IMG {
  color: white;
  border: none;
}

</style>
</head>
<body>
<a href=\"http://www.w3.org/\"><img alt=\"W3C\" src=\"http://www.w3.org/Icons/w3c_home\" height=\"48\" width=\"72\"></a>
<h1>W3C<sup>&reg;</sup> Link Checker: $uri</h1>
\n";
}

sub bgcolor() {
    my ($code) = @_;
    my $color;
    my $r = HTTP::Response->new($code);
    if ($r->is_success()) {
        return '';
    }
    if ($code == 300) {
        return ' bgcolor="magenta"';
    }
    if ($code == 401) {
        return ' bgcolor="aqua"';
    }
    if ($r->is_redirect()) {
        return ' bgcolor="yellow"';
    }
    if ($r->is_error()) {
        return ' bgcolor="red"';
    }
    return ' bgcolor="grey"';
}

sub show_url() {
    my ($url, $fragment) = @_;
    if (defined($fragment)) {
        $url .= '#'.$fragment;
    }
    return('<a href="'.$url.'">'.&encode(defined($fragment) ? $fragment : $url).'</a>');
}

sub html_footer() {
    print "
<hr>
<address>
$PROGRAM $VERSION<br>
Report bugs to <a href=\"mailto:hugo\@w3.org\">Hugo Haas</a>.
Check out the <a href=\"http://dev.w3.org/cvsweb/validator/httpd/cgi-bin/LinkChecker.pl\">source code</a>.
</address>
</body>
</html>
";
}

sub file_uri() {
    my $uri = $_[0];
    &html_header($uri);
    print "<h2>Forbidden</h2>
<p>You cannot check such a URI (<code>$uri</code>).</p>
";
    &html_footer();
    exit;
}

sub print_form() {
    my ($q) = @_;
    &html_header($VERSION, 1);
    print "<form action=\"".$q->self_url()."\" method=\"get\">
<p>Enter the URI that you want to check:</p>
<p><input type=\"text\" size=\"50\" name=\"uri\"></p>
<p>Options:</p>
<p>
  <input type=\"checkbox\" name=\"summary\"> Summary only
  &nbsp;
  <input type=\"checkbox\" name=\"redirects\" checked> Show redirects
</p>
<p><input type=\"submit\" name=\"submit\" value=\"Check\"></p>
</form>
";
    &html_footer();
    exit;
}

sub encode() {
    if (! $_html) {
        return @_;
    } else {
        return HTML::Entities::encode(@_);
    }
}

sub hprintf() {
    if (! $_html) {
        printf(@_);
    } else {
        print HTML::Entities::encode(sprintf($_[0], @_[1..@_-1]));
    }
}
