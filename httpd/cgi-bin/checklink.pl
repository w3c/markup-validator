#! /usr/bin/perl -w
#
# W3C Link Checker
# by Hugo Haas
# (c) 1999-2000 World Wide Web Consortium
# based on Renaud Bruyeron's checklink.pl
#
# $Id: checklink.pl,v 2.41 2000-05-04 22:29:01 hugo Exp $
#
# This program is licensed under the W3C(r) License:
#	http://www.w3.org/Consortium/Legal/copyright-software
#
# See the CVSweb interface at:
#	http://dev.w3.org/cvsweb/validator/httpd/cgi-bin/checklink.pl
#
# An online version is available at:
#	http://validator.w3.org/checklink

use strict;

package W3C::UserAgent;
require LWP::UserAgent;
@W3C::UserAgent::ISA = qw(LWP::UserAgent);

package W3C::CheckLink;
require HTML::Parser;
@W3C::CheckLink::ISA = qw(HTML::Parser);

# Autoflush
$| = 1;

# Version info
my $PROGRAM = 'W3C checklink';
my $VERSION = q$Revision: 2.41 $ . '(c) 1999-2000 W3C';
my $REVISION; ($REVISION = $VERSION) =~ s/Revision: (\d+\.\d+) .*/$1/;

# Different options specified by the user
my $_cl;
my $_quiet = 0;
my $_summary = 0;
my $_verbose = 0;
my $_progress = 0;
my $_html = 0;
my $_timeout = 60;
my $_redirects = 1;
my $_dir_redirects = 1;
my $_user;
my $_password;
my $_trusted = '\.w3\.org';
my $_http_proxy;
my $_recursive = 0;
my $_accept_language = 1;
my $_languages = '*';
my $_base_location = '.';
my $_contact_address = 'hugo@w3.org';

# Restrictions for the online version
my $_sleep_time = 3;
my $_max_documents = 50;

# Global variables
# Used for the output
my $first = 2;
# What is our query?
my $query;
# What URI's did we process? (used for $_recursive == 1)
my %processed;
# Result of the HTTP query
my %results;
# List of redirects
my %redirects;
# Count of the number of documents checked
my $doc_count = 0;
# Time stamp
my $timestamp = &get_timestamp;

if ($#ARGV >= 0) {
    $_cl = 1;
# Parse command line
    my @uris = &parse_arguments();
    if ($_user && (! $_password)) {
        &ask_password();
    }
    my $uri;
    foreach $uri (@uris) {
	if (!$_summary) {
            printf("%s %s\n", $PROGRAM ,$VERSION) if (! $_html);
        } else {
            $_verbose = 0;
            $_progress = 0;
        }
        $uri = urize($uri);
        &check_uri($uri);
    }
    if (($doc_count > 0) && !$_summary) {
        printf("\n%s\n", &global_stats());
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
    if ($query->param('hide_redirects')) {
        $_redirects = 0;
    }
    if ($query->param('no_accept_language')) {
        $_accept_language = 0;
    }
    if ($query->param('hide_dir_redirects')) {
        $_dir_redirects = 0;
    }
    if ($query->param('recursive')) {
        $_recursive = 1;
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
    $uri =~ s/^\s+//g;
    if ($uri =~ m/^file:/) {
        &file_uri($uri);
    } elsif (!($uri =~ m/:/)) {
        $uri = 'http://'.$uri;
    }
    &check_uri($uri, 1);
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
        } elsif (m/^-[^-upytdlL]/) {
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
            if (m/e/) {
                $_dir_redirects = 0;
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
            if (m/n/) {
                $_accept_language = 0;
            }
            if (m/r/) {
                $_recursive = 1;
            }
        } elsif (m/^--help$/) {
            &usage();
        } elsif (m/^--quiet$/) {
            $_quiet = 1;
        } elsif (m/^--summary$/) {
            $_summary = 1;
        } elsif (m/^--broken$/) {
            $_redirects = 0;
        } elsif (m/^--dir-redirects$/) {
            $_dir_redirects = 0;
        } elsif (m/^--verbose$/) {
            $_verbose = 1;
        } elsif (m/^--indicator$/) {
            $_progress = 1;
        } elsif (m/^--html$/) {
            $_html = 1;
        } elsif (m/^--noacclanguage$/) {
            $_accept_language = 0;
        } elsif (m/^--recursive$/) {
            $_recursive = 1;
        } elsif (m/^-l|--location$/) {
            $_base_location = shift(@ARGV);
        } elsif (m/^-u|--user$/) {
            $_user = shift(@ARGV);
        } elsif (m/^-p|--password$/) {
            $_password = shift(@ARGV);
        } elsif (m/^-t|--timeout$/) {
            $_timeout = shift(@ARGV);
        } elsif (m/^-L|--languages$/) {
            $_languages = shift(@ARGV);
        } elsif (m/^-d|--domain$/) {
            $_trusted = shift(@ARGV);
        } elsif (m/^-y|--proxy$/) {
            $_http_proxy = shift(@ARGV);
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
	-e/--directory		Hide directory redirects - e.g.
				http://www.w3.org/TR -> http://www.w3.org/TR/
	-r/--recursive		Check the documents linked from the first one.
	-l/--location uri	Scope of the documents checked.
				By default, for
				http://www.w3.org/TR/html4/Overview.html
				for example, it would be:
				http://www.w3.org/TR/html4/
	-n/--noacclanguage	Do not send an Accept-Language header.
	-L/--languages		Languages accepted (default: '$_languages'). 
	-q/--quiet		No output if no errors are found.
	-v/--verbose		Verbose mode.
	-i/--indicator		Show progress while parsing.
	-u/--user username	Specify a username for authentication.
	-p/--password password	Specify a password.
	-t/--timeout value	Timeout for the HTTP requests.
	-d/--domain domain	Regular expression describing the domain to
				which the authetication information will be
				sent (default: '$_trusted').
	-y/--proxy proxy	Specify an HTTP proxy server.
	-h/--html		HTML output.
	--help			Show this message.
";
    exit(0);
}

sub ask_password() {
    print(STDERR 'Enter your password: ');
    # Will only work on Unix...
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
    my ($uri, $html_stuff) = @_;

    # Are we in a recursion cycle?
    my $in_recursion = !$first;

    if ($_html) {
        $first = 1;
    } else {
        $first = 0;
    }

    my $start;
    if (! $_quiet) {
        $start = &get_timestamp();
    }

    # Get the document
    my $response = &get_document('GET', $uri, $in_recursion, \%redirects);

    if (defined($response->{Stop})) {
        return(-1);
    }

    # We are checking a new document
    $doc_count++;

    if ($_html) {
        if ($html_stuff) {
            &html_header($uri);
        }
        print('<h2>');
    }

    my $absolute_uri = $response->{absolute_uri}->as_string();

    printf("\nProcessing\t%s\n\n", $_html ? &show_url($absolute_uri)
           : $absolute_uri);

    if ($_html) {
        printf("</h2>\n<p>Check also: <a href=\"http://validator.w3.org/check?uri=%s\">HTML Validity</a> &amp; <a href=\"http://jigsaw.w3.org/css-validator/validator?uri=%s\">CSS Validity</a></p>\n<p>Back to the <a href=\"checklink\">link checker</a>.</p>\n", map{&encode($absolute_uri)}(1..2));
        if (! $_summary) {
            print "<pre>\n";
        }
    }

    $processed{$absolute_uri} = 1;
    my $p = &parse_document($uri, $absolute_uri,
                            $response->content(), 1);
    my $base = URI->new($p->{base});

    # Check anchors

    if (! $_summary) {
        print("Checking anchors:\n");
    }
    my %errors;
    my $anchor;
    foreach $anchor (keys %{$p->{Anchors}}) {
        my $times;
        my $l;
        foreach $l (keys %{$p->{Anchors}{$anchor}}) {
            $times += $p->{Anchors}{$anchor}{$l};
        }
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
            my $fragment = $canonical->fragment();
            if (! $fragment) {
                $links{$url}{location}{$lines} = 1;
            } else {
                $links{$url}{fragments}{$fragment}{$lines} = 1;
            }
        }
    }

    # Build the list of broken URI's
    my %broken;
    my $u;
    foreach $u (keys %links) {
        # Don't check mailto: URI's
        next if ($u =~ m/^mailto:/);
        if (! $_summary) {
            &hprintf("Checking link %s\n", $u);
        }
        &check_validity($uri, $u, \%links, \%redirects);
        if ($_verbose) {
            &hprintf("\tReturn code: %s\n", $results{$u}{location}{code});
        }
        if ($results{$u}{location}{success}) {
            my $fragment;
            if ($results{$u}{location}{display} >= 400) {
                $broken{$u}{location} = 1;
            }
            foreach $fragment (keys %{$links{$u}{fragments}}) {
                if ($_verbose) {
                    &hprintf("\t\t%s %s - Lines: %s\n",
                             $fragment,
                             ($results{$u}{fragments}{$fragment}
                              ? 'OK' : 'Not found'),
                             join(',',
                                  keys %{$links{$u}{fragments}{$fragment}})
                             );
                }
                # A broken fragment?
                if ($results{$u}{fragments}{$fragment} == 0) {
                    $broken{$u}{fragments}{$fragment} += 2;
                }
            }
        } else {
            # Couldn't find the document
            $broken{$u}{location} = 1;
            my $fragment;
            foreach $fragment (keys %{$links{$u}{fragments}}) {
                $broken{$u}{fragments}{$fragment}++;
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
            print "</pre>\n";
        }
    }
    if (! $_quiet) {
        print "\n";
    }
    &anchors_summary($p->{Anchors}, \%errors);
    &links_summary(\%links, \%results, \%broken, \%redirects);

    # Do we want to process other documents?
    if ($_recursive) {
        if ($_base_location eq '.') {
            # Get the name of the original directory
            # e.g. http://www.w3.org/TR/html4/Overview.html
            #      should return http://www.w3.org/TR/html4/
            $results{$uri}{parsing}{base} =~ m/^(.*\/)[^\/]*/;
            $_base_location = $1;
        }
        foreach $u (keys %links) {
            next if (! (# Check if it's in our scope for recursion
                        ($u =~ m/^$_base_location/) &&
                        # and the link is not broken
                        $results{$u}{location}{success})
                     );
            # Check if we have already processed the URI
            next if (&already_processed($u) != 0);
            # Do the job
            print "\n";
            if (! $_html) {
                my $i = 40;
                while ($i--) {
                    print('-');
                }
            } else {
                # For the online version, wait for a while to avoid abuses
                if (!$_cl) {
                    if ($doc_count == $_max_documents) {
                        print("<hr>\n<p><strong>Maximum number of documents reached!</strong> Please contact <a href=\"mailto:$_contact_address\">$_contact_address</a> if you need to check more than $_max_documents documents at once.</a></p>\n");
                    }
                    if ($doc_count >= $_max_documents) {
                        $doc_count++;
                        print("<p>Not checking <strong>$u</strong></p>\n");
                        $processed{$u} = 1;
                        next;
                    }
                }
                print('<hr>');
                sleep($_sleep_time);
            }
            print "\n";
            &check_uri($u, 0);
        }
    }

    if ($_html && $html_stuff) {
        &html_footer();
    }
}

#############################
# Get a document to process #
#############################

sub get_document() {
    my ($method, $uri, $in_recursion, $redirects) = @_;
    my $error_first;

    # Get the document
    my $response = &get_uri($method, $uri);
    &record_results($uri, $method, $response);
    $first = 0;
    if (! $response->is_success()) {
        if (! $in_recursion) {
            if ($response->code() == 401) {
                &authentication($response);
            } else {
                if ($_html) {
                    &html_header($uri);
                }
                &hprintf("\nError: %d %s\n",
                         $response->code(), $response->message());
                if ($_html) {
                    &html_footer();
                }
            }
        }
        $response->{Stop} = 1;
        return($response);
    }

    &record_redirects($redirects, $response->{Redirects});

    # What URI are we processing by the way?
    my $base_uri = URI->new($response->base());
    my $request_uri = URI->new($response->request->url);
    $response->{absolute_uri} = $base_uri->abs($request_uri);

    # Parse the document
    if (! ($response->header('Content-type') =~ m/text\/html/)) {
        if ($_html) {
            &html_header($uri);
        }
        if (! $in_recursion) {
            &hprintf("Can't check link: Content-type is '%s'.\n",
                     $response->header('Content-type'));
        }
        $response->{Stop} = 1;
    }

    # Ok, return the information
    return($response);
}

##################################################
# Check whether a URI has already been processed #
##################################################

sub already_processed($) {
    my ($uri, %redirects) = @_;
    # Don't be verbose for that part
    my $summary_value = $_summary;
    $_summary = 1;
    # Do a HEAD
    my $response = &get_document('HEAD', $uri, 1);
    $_summary = $summary_value;
    # Have we already processed it?
    return(-1) if (defined($response->{Stop}));
    return(1) if (defined($processed{$response->{absolute_uri}->as_string()}));
    return(0);
}

############################
# Get the content of a URI #
############################

sub W3C::UserAgent::simple_request() {
    my $self = shift;
    my $response = $self->W3C::UserAgent::SUPER::simple_request(@_);
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
    $ua->agent('W3Cchecklink/'.$REVISION.' '.$ua->agent());
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
    if ($_accept_language) {
        $request->header('Accept-Language' => 'en');
    }
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

#########################################
# Record the results of an HTTP request #
#########################################

sub record_results() {
    my ($uri, $method, $response) = @_;
    $results{$uri}{method} = $method;
    $results{$uri}{location}{code} = $response->code();
    $results{$uri}{location}{type} = $response->header('Content-type');
    $results{$uri}{location}{display} = $results{$uri}{location}{code};
    $results{$uri}{location}{orig} = $response->{OriginalCode};
    # Did we get a redirect?
    if ($response->{OriginalCode} != $response->code()) {
        $results{$uri}{location}{orig_message} =  $response->{OriginalMessage};
        $results{$uri}{location}{redirected} = 1;
    }
    $results{$uri}{location}{success} = $response->is_success();
    # Stores the authentication information
    if (defined($response->{Realm})) {
        $results{$uri}{location}{realm} = $response->{Realm};
        $results{$uri}{location}{display} = 401;
    }
    if (($results{$uri}{location}{display} == 401)
        && ($results{$uri}{location}{code} == 404)) {
        $results{$uri}{location}{record} = 404;
    } else {
        $results{$uri}{location}{record} = $results{$uri}{location}{display};
    }
    # Did it fail?
    $results{$uri}{location}{message} = $response->message();
    if (! $results{$uri}{location}{success}) {
        if ($_verbose) {
            &hprintf("Error: %d %s\n",
                     $results{$uri}{location}{code},
                     $results{$uri}{location}{message});
        }
        return;
    }
}

####################
# Parse a document #
####################

sub parse_document() {
    my ($uri, $location, $document, $links) = @_;

    my $p;

    if (defined($results{$uri}{parsing})) {
        # We have already done the job. Woohoo!
        $p->{base} = $results{$uri}{parsing}{base};
        $p->{Anchors} = $results{$uri}{parsing}{Anchors};
        $p->{Links} = $results{$uri}{parsing}{Links};
        return($p);
    }

    my $start;
    $p = W3C::CheckLink->new();
    $p->{base} = $location;
    if (! $_summary) {
        $start = &get_timestamp();
        print("Parsing...\n");
    }
    if (!$_summary || $_progress) {
        $p->{Total} = ($document =~ tr/\n//);
    }
    # We only look for anchors if we are not interested in the links
    # obviously, or if we are running a recursive checking because we
    # might need this information later
    $p->{only_anchors} = !($links || $_recursive);

    # Transform <?xml:stylesheet ...?> into <xml:stylesheet ...> for parsing
    # Processing instructions are not parsed by process, but in this case
    # it should be. It's expensive, it's horrible, but it's the easiest way
    # for right now.
    $document =~ s/\<\?(xml:stylesheet.*?)\?\>/\<$1\>/;

    $p->parse($document);

    if (! $_summary) {
        my $stop = &get_timestamp();
        if ($_progress) {
            print "\r";
        }
        &hprintf(" done (%d lines in %ss).\n",
                 $p->{Total}, &time_diff($start, $stop));
    }

    # Save the results before exiting
    $results{$uri}{parsing}{base} = $p->{base};
    $results{$uri}{parsing}{Anchors} = $p->{Anchors};
    $results{$uri}{parsing}{Links} = $p->{Links};

    return($p);
}

####################################
# Constructor for W3C::CheckLink #
####################################

sub W3C::CheckLink::new() {
    my $p = HTML::Parser::new(@_);

    # Using API version 3
    $p->{api_version} = 3;
    # Start tags
    $p->handler(start => 'start', 'self, tagname, attr, text, event, tokens');
    # Declarations
    $p->handler(declaration =>
                sub {
                    my $self = shift;
                    $self->declaration(substr($_[0], 2, -1));
                }, 'self, text');
    # Other stuff
    $p->handler(default => 'text', 'self, text');
    # Line count
    $p->{Line} = 1;
    # Check <a [..] name="...">?
    $p->{check_name} = 1;
    # Check <[..] id="..">?
    $p->{check_id} = 1;
    # Don't interpret comment loosely
    $p->strict_comment(1);

    return $p;
}

#################################################
# Record or return  the doctype of the document #
#################################################

sub W3C::CheckLink::doctype() {
    my ($self, $dc) = @_;
    if (! $dc) {
        return $self->{doctype};
    }
    $_ = $self->{doctype} = $dc;

    # What to look for depending on the doctype
    if ($_ eq '-//W3C//DTD XHTML Basic 1.0//EN') {
        $self->{check_name} = 0;
    }
    # Check for the id tag
    if (
        # HTML 2.0 & 3.0
        m/^-\/\/IETF\/\/DTD HTML [23]\.0\/\// ||
        # HTML 3.2
        m/^-\/\/W3C\/\/DTD HTML 3\.2\/\//) {
        $self->{check_id} = 0;
    }
    # Enable XML extensions
    if (m/^-\/\/W3C\/\/DTD XHTML /) {
        $self->xml_mode(1);
    }
}

#######################################
# Count the number of lines in a file #
#######################################

sub W3C::CheckLink::new_line() {
    my ($self, $string) = @_;
    my $count = ($string =~ tr/\n//);
    $self->{Line} = $self->{Line} + $count;
    if ($_progress) {
        printf("\r%4d%%", int($self->{Line}/$self->{Total}*100));
    }
}

#############################
# Extraction of the anchors #
#############################

sub W3C::CheckLink::get_anchor() {
    my ($self, $tag, $attr) = @_;
    my $anchor;

    if ($self->{check_id}) {
        $anchor = $attr->{id};
    }
    if ($self->{check_name} && ($tag eq 'a')) {
        # If id is defined, name if defined must have the same value
        if (!$anchor) {
            $anchor = $attr->{name};
        } else {
            # @@@ Issue a warning
        }
    }

    return($anchor);
}

###########################
# W3C::CheckLink handlers #
###########################

sub W3C::CheckLink::add_link() {
    my ($self, $uri) = @_;

    if (defined($uri)) {
        $self->{Links}{$uri}{$self->{Line}}++;
    }
}

sub W3C::CheckLink::start() {
    my ($self, $tag, $attr, $text) = @_;

    # Anchors
    my $anchor = $self->get_anchor($tag, $attr);
    if (defined($anchor)) {
        $self->{Anchors}{$anchor}{$self->{Line}}++;
    }

    # Links
    if (!$self->{only_anchors}) {
        # Here, we are checking too many things
        # The right thing to do is to parse the DTD...
        $self->add_link($attr->{href});
        $self->add_link($attr->{src});
        if ($tag eq 'object') {
            $self->add_link($attr->{data});
        }
    }

    # Line counting
    if ($text =~ m/\n/) {
        $self->new_line($text);
    }
}

sub W3C::CheckLink::text() {
    my ($self, $text) = @_;
    if (!$_progress) {
        # If we are just extracting information about anchors,
        # parsing this part is only cosmetic (progress indicator)
        return unless !$self->{only_anchors};
    }
    if ($text =~ /\n/) {
        $self->new_line($text);
    }
}

sub W3C::CheckLink::declaration() {
    my ($self, $text) = @_;
    # Extract the doctype
    my @declaration = split(/\s+/, $text, 4);
    if (($#declaration >= 3) &&
        ($declaration[0] eq 'DOCTYPE') &&
        (lc($declaration[1]) eq 'html')) {
        # Parse the doctype declaration
        $text =~ m/^DOCTYPE\s+html\s+PUBLIC\s+\"([^\"]*)\"(\s+\"([^\"]*)\")?\s*$/i;
        # Store the doctype
        if ($1) {
            $self->doctype($1);
        }
        # If there is a link to the DTD, record it
        if (!$self->{only_anchors} && $3) {
            $self->{Links}{$3}{$self->{Line}}++;
        }
    }
    return unless !$self->{only_anchors};
    $self->text($text);
}

################################
# Check the validity of a link #
################################

sub check_validity() {
    use HTTP::Status;
    my ($testing, $uri, $links, $redirects) = @_;

    # Checking file: URI's is not allowed with a CGI
    if ($testing ne $uri) {
        if ((! $_cl) && (!($testing =~ m/^file:/)) && ($uri =~ m/^file:/)) {
            # Can't test? Return 400 Bad request.
            $results{$uri}{location}{code} = 400;
            $results{$uri}{location}{success} = 0;
            $results{$uri}{location}{message} = 'Error: \'file:\' URI not allowed';
            if ($_verbose) {
                &hprintf("Error: %d %s\n",
                         $results{$uri}{location}{code},
                         $results{$uri}{location}{message});
            }
            return;
        }
    }

    # Get the document with the appropriate method
    my $method;
    my @fragments = keys %{$links->{$uri}{fragments}};
    if ($#fragments == -1) {
        $method = 'HEAD';
    } else {
        $method = 'GET';
    }

    my $response;
    my $being_processed = 0;
    if ((! defined($results{$uri}))
        || (($method eq 'GET') && ($results{$uri}{method} eq 'HEAD'))) {
        $being_processed = 1;
        $response = &get_uri($method, $uri);
        # Record the redirects
        &record_redirects($redirects, $response->{Redirects});
        # Get the information back from get_uri()
        &record_results($uri, $method, $response);
    }

    if ($#fragments == -1) {
        return;
    }
    # There are fragments. Parse the document.
    my $p;
    if ($being_processed) {
        # Can we really parse the document?
        if (!defined($results{$uri}{location}{type})) {
            return;
        }
        if (! ($results{$uri}{location}{type} =~ m/text\/html/i)) {
            if ($_verbose) {
                &hprintf("Can't check content: Content-type is '%s'.\n",
                         $response->header('Content-type'));
            }
            return;
        }
        # Do it then
        $p = &parse_document($uri, $response->base(),
                             $response->as_string(), 0);
    } else {
        # We already had the information
        $p->{Anchors} = $results{$uri}{parsing}{Anchors};
    }
    # Check that the fragments exist
    my $fragment;
    foreach $fragment (keys %{$links->{$uri}{fragments}}) {
        if (defined($p->{Anchors}{$fragment})
            || &escape_match($fragment, $p->{Anchors})) {
            $results{$uri}{fragments}{$fragment} = 1;
        } else {
            $results{$uri}{fragments}{$fragment} = 0;
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
        printf(STDERR "\nAuthentication is required for %s.\n", $r->request->url);
        printf(STDERR "The realm is %s.\n", $realm);
        print(STDERR "Use the -u and -p options to specify a username and password.\n");
    } else {
        printf("Status: 401 Authorization Required\nWWW-Authenticate: %s\nConnection: close\nContent-Type: text/html\n\n", $r->headers->www_authenticate);
        printf("<!DOCTYPE html PUBLIC \"-//W3C//DTD HTML 4.01 Transitional//EN\">
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
    return(sprintf("%.1f", ($stop[0]+$stop[1])-($start[0]+$start[1])));
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

####################################################
# Tool for sorting the unique elements of an array #
####################################################

sub sort_unique() {
    my %saw;
    @saw{@_} = ();
    return (sort { $a <=> $b } keys %saw);
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
        &hprintf("Found %d anchor(s).", $#anchors+1);
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
            $format = "<tr class=\"broken\"><td>%s</td><td>%s</td></tr>\n";
        } else {
            $format = "\t%s\tLines: %s\n";
        }
        printf($format,
               &encode($anchor eq '' ? 'Empty anchor' : $ anchor),
               join(', ', &sort_unique(keys %{$anchors->{$anchor}})));
    }
    if ($_html) {
        print("</table>\n");
    }
}

sub show_link_report {
    my ($links, $results, $broken, $redirects, $urls, $codes, $todo) = @_;

    if ($_html) {
        print("\n<dl class=\"report\">");
    }
    print("\n");

    # Process each URL
    my $u;
    my ($c, $previous_c);
    foreach $u (@{$urls}) {
        my @fragments = keys %{$broken->{$u}{fragments}};
        # Did we get a redirect?
        my $redirected = &is_redirected($u, %$redirects);
        # List of lines
        my @total_lines;
        my ($f, $l);
        foreach $l (keys %{$links->{$u}{location}}) {
            push (@total_lines, $l);
        }        
        foreach $f (keys %{$links->{$u}{fragments}}) {
            if ($f eq $u) {
                next if (defined($links->{$u}{$u}{-1}));
            }
            my $l;
            foreach $l (keys %{$links->{$u}{fragments}{$f}}) {
                push (@total_lines, $l);
            }
        }
        my $lines_list = join(', ',
                              &sort_unique(@total_lines));
        # Error type
        $c = &code_shown($u, $results);
        # What to do
        my $whattodo;
        if ($todo) {
            $whattodo = $todo->{$c};
        } else {
            # Directory redirects
            $whattodo = 'Add a trailing slash to the URL.';
        }
        if ($_html) {
            # Style stuff
            my $idref = '';
            if ($codes && ($c != $previous_c)) {
                $idref = ' id="code_'.$c.'"';
                $previous_c = $c;
            }
            # Main info
            my @redirects_urls = &get_redirects($u, %$redirects);
            for (@redirects_urls) {
                $_ = &show_url($_);
            }
            printf("
<dt%s%s>%s</dt>
<dd>What to do: <strong%s>%s</strong><br>
<dd%s>HTTP Code returned: %d%s<br>
HTTP Message: %s%s%s</dd>
<dd%s>Lines: %s</dd>\n",
                   # Color
                   &bgcolor($results->{$u}{location}{record}),
                   # Anchor for return codes
                   $idref,
                   # List of redirects
                   $redirected ? join(' redirected to<br>',
                                      @redirects_urls) : &show_url($u),
                   # Color
                   &bgcolor($c),
                   # What to do
                   $whattodo,
                   # Color
                   &bgcolor($results->{$u}{location}{orig}),
                   # Original HTTP reply
                   $results->{$u}{location}{orig},
                   # Final HTTP reply
                   ($results->{$u}{location}{code} !=
                    $results->{$u}{location}{orig})
                   ? ' <span title="redirected to">-&gt;</span> '.
                   &encode($results->{$u}{location}{code})
                   : '',
                   # Realm
                   (defined($results->{$u}{location}{realm})
                   ? 'Realm: '.&encode($results->{$u}{location}{realm}).'<br>'
                   : ''),
                   # HTTP original message
                   defined($results->{$u}{location}{orig_message})
                   ? &encode($results->{$u}{location}{orig_message}).
                   ' <span title="redirected to">-&gt;</span> ' 
                   : '',
                   # HTTP final message
                   $results->{$u}{location}{message}
                   ? &encode($results->{$u}{location}{message})
                   : '',
                   # Color again
                   &bgcolor($results->{$u}{location}{code}),
                   # List of lines
                   $lines_list);
            if ($#fragments >= 0) {
                my $fragment_direction;
                if (!($broken->{$u}{'location'})) {
                    $fragment_direction =
                        ' <strong class="broken">They need to be fixed!</strong>';
                }
                printf("<dd><dl><dt>Broken fragments and their line numbers: %s</dt>\n",
                       $fragment_direction);
            }
        } else {
            printf("\n%s\t%s\n  Code: %d%s %s\nTo do: %s\n",
                   # List of redirects
                   $redirected ? join("\n-> ",
                                      &get_redirects($u, %$redirects)) : $u,
                   # List of lines
                   $lines_list ? 'Lines: '.$lines_list : '' ,
                   # Original HTTP reply
                   $results->{$u}{location}{orig},
                   # Final HTTP reply
                   ($results->{$u}{location}{code} != $results->{$u}{location}{orig})
                   ? ' -> '.$results->{$u}{location}{code}
                   : '',
                   # HTTP message
                   $results->{$u}{location}{message} ?
                   $results->{$u}{location}{message} : '',
                   # What to do
                   $whattodo);
            if ($#fragments >= 0) {
                if (!($broken->{$u}{'location'})) {
                    print("The following fragments need to be fixed:\n");
                } else {
                    print("Fragments:\n");
                }
            }
        }
        # Fragments
        foreach $f (@fragments) {
            if ($_html) {
                printf("<dd%s>%s: %s</dd>\n",
                       ($broken->{$u}{fragments}{$f} > 1) ?
                       &bgcolor(404) :
                       &bgcolor($results->{$u}{location}{code}),
                       # Broken fragment
                       &show_url($u, $f),
                       # List of lines
                       join(', ',
                            &sort_unique(keys %{$links->{$u}{fragments}{$f}})));
            } else {
                printf("\t%-30s\tLines: %s\n",
                       # Fragment
                       $f,
                       # List of lines
                       join(', ',
                            &sort_unique(keys %{$links->{$u}{fragments}{$f}})));
            }
        }
        if ($_html) {
            if ($#fragments >= 0) {
                print("</dl></dd>\n");
            }
        }
    }
    # End of the table 
    if ($_html) {
       print("</dl>\n");
    }
}

sub code_shown() {
    my ($u, $results) = @_;

    if ($results->{$u}{location}{record} == 200) {
        return $results->{$u}{location}{orig};
    } else {
        return $results->{$u}{location}{record};
    }
}

sub links_summary {
    # Advices to fix the problems

    my %todo = ( 200 => 'There are broken fragments which must be fixed.',
                 300 => 'It usually means that there is a typo in a link that triggers mod_speling action - this must be fixed!',
                 301 => 'Usually nothing. You may want to update the link though.',
                 302 => 'Usually nothing.',
                 400 => 'Usually the sign of a malformed URL that cannot be parsed by the server.',
                 401 => 'The link is not public. You had better specify it.',
                 403 => 'The link is forbidden! This needs fixing. Usual suspect: a missing Overview.html or index.html, or bad access control.',
                 404 => 'The link is broken. Fix it NOW!',
                 405 => 'The server does not allow HEAD requests. Go ask the guys who run this server why.',
                 407 => 'The link is a proxy, but requires Authentication.',
                 408 => 'The request timed out',
                 415 => 'The media type is not supported.',
                 500 => 'The server failed. It is a server side problem.',
                 501 => 'HEAD or GET is not implemented on this server... What kind of server is that?',
                 503 => 'The server cannot service the request, for some unknown reason.');
    my %priority = ( 404 => 1,
                     403 => 5,
                     200 => 10,
                     300 => 15,
                     401 => 20
                    );

    my ($links, $results, $broken, $redirects) = @_;

    # List of the broken links
    my @urls = keys %{$broken};
    my @dir_redirect_urls = ();
    if ($_redirects) {
        # Add the redirected URI's to the report
        my $l;
        for $l (keys %$redirects) {
            next unless (defined($results->{$l})
                         && defined($links->{$l})
                         && !defined($broken->{$l}));
            # Check whether we have a "directory redirect"
            # e.g. http://www.w3.org/TR -> http://www.w3.org/TR/
            my @redirects = &get_redirects($l, %$redirects);
            if (($#redirects == 1)
                && (($redirects[0].'/') eq $redirects[1])) {
		push(@dir_redirect_urls, $l);
                next;
            }
            push(@urls, $l);
        }
    }

    # Broken links and redirects
    if ($#urls < 0) {
        if (! $_quiet && $_html) {
            print "<p>Valid links!</p>\n";
        }
    } else {
        if ($_html) {
            print('<h3>');
        }
        print("\nList of broken links");
        if ($_redirects) {
            print(' and redirects');
        }

        # Sort the URI's by HTTP Code
        my %code_summary;
        my $u;
        my @idx;
        foreach $u (@urls) {
            if (defined($results->{$u}{location}{record}))  {
                my $c = &code_shown($u, $results);
                $code_summary{$c}++;
                push(@idx, $c);
            }
        }
        my @sorted = @urls[
                           sort {
                               defined($priority{$idx[$a]}) ?
                                   defined($priority{$idx[$b]}) ?
                                       $priority{$idx[$a]}
                                       <=> $priority{$idx[$b]} :
                                   -1 :
                                defined($priority{$idx[$b]}) ?
                                   1 :
                                $idx[$a] <=> $idx[$b]
                           } 0 .. $#idx
                           ];
        @urls = @sorted;
        undef(@sorted); undef(@idx);

        if ($_html) {
            print('</h3><p><i>Fragments listed are broken. See the table below to know what action to take.</i></p>');

            # Print a summary
            print "<table border=\"1\">\n<tr><td><b>Code</b></td><td><b>Occurences</b></td><td><b>What to do</b></td></tr>\n";
            my $code;
            foreach $code (sort(keys(%code_summary))) {
                printf('<tr%s>', &bgcolor($code));
                printf('<td><a href="#code_%s">%s</a></td>', $code, $code);
                printf('<td>%s</td>', $code_summary{$code});
                printf('<td>%s</td>', $todo{$code});
                print "</tr>\n";
            }
            print "</table>\n";
        } else {
            print(':');
        }
        &show_link_report($links, $results, $broken, $redirects,
                          \@urls, 1, \%todo);
    }

    # Show directory redirects
    if ($_redirects && $_dir_redirects && ($#dir_redirect_urls > -1)) {
        if ($_html) {
            print('<h3>');
        }
        print("\nList of directory redirects:");
        if ($_html) {
            print("</h3>\n");
        }
        &show_link_report($links, $results, $broken, $redirects,
                          \@dir_redirect_urls);
    }
}

###############################################################################

################
# Global stats #
################

sub global_stats() {
    my $stop = &get_timestamp();
    return sprintf("Checked %d document(s) in %ss.",
                   ($doc_count<=$_max_documents? $doc_count : $_max_documents),
                   &time_diff($timestamp, $stop)); 
}

##################
# HTML interface #
##################

sub html_header() {
    my $uri = &encode($_[0]);
    # Cache control?
    if (defined($_[1])) {
        print "Cache-Control: no-cache\nPragma: no-cache\n";
    }
    if (! $_cl) {
        print 'Content-type: text/html';
    }
    print "

<!DOCTYPE html PUBLIC \"-//W3C//DTD HTML 4.01 Transitional//EN\">
<html>
<head>
<title>W3C Link Ckecker: $uri</title>
<style type=\"text/css\">

body {
  font-family: sans-serif;
  color: black;
  background: white;
}

pre {
  font-family: monospace
}

img {
  color: white;
  border: none;
}

.report {
  width: 100%;
}

dt.report {
  font-weight: bold;
}

.unauthorized {
  background-color: aqua;
}

.redirect {
  background-color: yellow;
}

.broken {
  background-color: red;
}

.multiple {
  background-color: fuchsia;
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
    my $class;
    my $r = HTTP::Response->new($code);
    if ($r->is_success()) {
        return '';
    } elsif ($code == 300) {
        $class = 'multiple';
    } elsif ($code == 401) {
        $class = 'unauthorized';
    } elsif ($r->is_redirect()) {
        $class = 'redirect';
    } elsif ($r->is_error()) {
        $class = 'broken';
    } else {
        $class = 'broken';
    }
    return(' class="'.$class.'"');
}

sub show_url() {
    my ($url, $fragment) = @_;
    if (defined($fragment)) {
        $url .= '#'.$fragment;
    }
    return('<a href="'.$url.'">'.&encode(defined($fragment) ? $fragment : $url).'</a>');
}

sub html_footer() {

    if (($doc_count > 0) && !$_quiet) {
        printf("<p>%s</p>\n", &global_stats());
    }

    print "
<hr>
<address>
$PROGRAM $VERSION<br>
Report bugs to <a href=\"mailto:hugo\@w3.org\">Hugo Haas</a>.
Check out the <a href=\"http://dev.w3.org/cvsweb/validator/httpd/cgi-bin/checklink.pl\">source code</a>.
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
  <br>
  <input type=\"checkbox\" name=\"hide_redirects\"> Hide redirects
  <br>
  <input type=\"checkbox\" name=\"no_accept_language\"> Don't send <tt>Accept-Language</tt> headers.
  <br>
  <input type=\"checkbox\" name=\"hide_dir_redirects\"> Hide directory redirects
  <br>
  <input type=\"checkbox\" name=\"recursive\"> Check linked documents recursively <small>(maximum: $_max_documents documents; sleeping $_sleep_time\s between each document)</small>
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
