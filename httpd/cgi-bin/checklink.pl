#! /usr/bin/perl -w
#
# W3C Link Checker
# by Hugo Haas
# (c) 1999 World Wide Web Consortium
# based on Renaud Bruyeron's checklin.pl
#
# $Id: checklink.pl,v 2.6 1999-12-01 21:52:54 hugo Exp $
#
# This program is licensed under the W3C License.

package W3C::CheckLink;
require HTML::Parser;
@W3C::CheckLink::ISA = qw(HTML::Parser);
package W3C::UserAgent;
require LWP::UserAgent;
@W3C::UserAgent::ISA = qw(LWP::UserAgent);

# Autoflush
$| = 1;

# Version info
my $PROGRAM = 'W3C checklink';
my $VERSION = '$Revision: 2.6 $ (c) 1999 W3C';
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
my $query;

if ($#ARGV >= 0) {
    $_cl = 1;
# Parse command line
    my @uris = &parse_arguments();
    if ($_user && (! $_password)) {
        &ask_password();
    }
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
        } elsif (m/^-[^-uptc]/) {
            if (m/q/) {
                $_quiet = 1;
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
    $_ = $_[0];
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
    $u = URI->new($res);
    $result = $u->abs($base);
    return($result->as_string());
}

#######################
# Do the job on a URI #
#######################

sub check_uri() {
    my $uri = $_[0];
    if ($_html) {
        &html_header($uri);
        if (! $_summary) {
            print "<pre>\n";
        }
    }
    my $start;
    if (! $_summary) {
        $start = &get_timestamp();
        printf("\nProcessing\t%s\n", $uri);
    }
    # Get the document
    my $response = &get_uri('GET', $uri, 1);
    if (! $response->is_success()) {
        printf("Error: %d %s\n", $response->code(), $response->message());
        if ($response->code() == 401) {
            &authentication($response);
        }
        if ($_html) {
            &html_footer();
        }
        exit(-1);
    }
    my %redirects;
    &record_redirects(\%redirects, $response->{Redirects});
    # Parse the document
    if (! ($response->header('Content-type') =~ m/text\/html/)) {
        printf("Can't check link: Content-type is '%s'.\n",
               $response->header('Content-type'));
        return(-1);
    }
    my $base_uri = URI->new($response->base());
    my $uri_uri = URI->new($uri);
    my $absolute_base = $base_uri->abs($uri_uri);
    my $p = &parse_document($absolute_base->as_string(), $response->content(), 1);
    my $base = URI->new($p->{base});
    # Check anchors
    if (! $_summary) {
        print("Checking anchors:\n");
    }
    my %errors;
    foreach $anchor (keys %{$p->{Anchors}}) {
        my @lines = keys %{$p->{Anchors}{$anchor}};
        my $times = $#lines + 1;
        if ($times > 1) {
            $errors{$anchor} = 1;
        }
    }
    if (! $_summary) {
        print(" done.\n");
    }
    # Check links
    my %links;
    foreach $link (keys %{$p->{Links}}) {
        my $link_uri = URI->new($link);
        my $abs_link_uri = URI->new_abs($link_uri, $base);
        foreach $lines (keys %{$p->{Links}{$link}}) {
            my $canonical = URI->new($abs_link_uri->canonical());
            my $url = $canonical->scheme().':'.$canonical->opaque();
            my $fragment = $canonical->fragment()
                ? $canonical->fragment() : $url;
            $links{$url}{$fragment}{$lines} = 1;
        }
    }
    for $url (keys %links) {
        if (!defined($links{$url}{$url})) {
            $links{$url}{$url}{-1} = 1;
        }
    }
    my %results;
    my %broken;
    foreach $u (keys %links) {
        # Don't check mailto: URI's
        next if ($u =~ m/^mailto:/);
        if (! $_summary) {
            printf("Checking link %s\n", $u);
        }
        &check_validity($uri, $u, \%links, \%results, \%redirects, $p->{Anchors}, $response->code());
        if ($_verbose) {
            printf("\tReturn code: %s\n", $results{$u}{$u}{code});
        }
        if ($results{$u}{$u}{success}) {
            foreach $fragment (keys %{$links{$u}}) {
                next if ($fragment eq $u);
                if ($_versbose) {
                    printf("\t\t%s %s - Lines: %s\n",
                           $fragment,
                           ($results{$u}{$fragment}?'OK':'Not found'),
                           join(',', keys %{$links{$u}{$fragment}}));
                }
                if ($results{$u}{$fragment} == 0) {
                    $broken{$u}{$fragment} = 1;
                }
            }
        } else {
            $broken{$u}{$u} = 1;
            foreach $fragment (keys %{$links{$u}}) {
                $broken{$u}{$fragment} = 1;
            }
        }
    }
    if (! $_summary) {
        my $stop = &get_timestamp();
        printf("Processed in %ss.\n", &time_diff($start, $stop));
    }
    # Display results
    if ($_html) {
        if (! $_summary) {
            print '</pre><hr>';
        }
    }
    print "\n";
    &anchors_summary($p->{Anchors}, \%errors);
    &links_summary(\%links, \%results, \%broken, \%redirects);
    if ($_html) {
        &html_footer();
    }
}

############################
# Get the content of a URI #
############################

sub W3C::UserAgent::redirect_ok {
    my ($self, $request) = @_;
    
    if (! $_summary) {
        printf("\n%s %s ", $request->method(), $request->uri());
    }

    $self->{Redirects}{$self->{fetching}} = $request->uri();
    $self->{fetching} = $request->uri();

    return 0 if $request->method() eq "POST";
    return 1;
}

sub get_uri() {
    my ($method, $uri, $authentication) = @_;
    my $start = &get_timestamp();
    my $ua = new W3C::UserAgent;
    $ua->timeout($_timeout);
    $ua->agent('W3Cchecklink/'.$REVISION.' '.$ua->agent());
    $ua->{uri} = $uri;
    $ua->{fetching} = $uri;
    my $count = 0;
    my $response;
    if (! $_summary) {
        printf("%s %s ", $method, $uri);
    }
    my $request = new HTTP::Request($method, $uri);
    $response = $ua->request($request);
    if (($response->code() == 401) && $authentication) {
        # Deal with authentication
        # Either with LWP::UserAgent or HTTP::Request
    }
    $response->{Redirects} = $ua->{Redirects};
    my $stop = &get_timestamp();
    if (! $_summary) {
        printf(" fetched in %ss\n", &time_diff($start,$stop));
    }
    return $response;
}

####################
# Parse a document #
####################

sub parse_document() {
    my ($uri, $document, $links) = @_;

    my $start;
    my $p = W3C::CheckLink->new();
    # Loose interpretation of the HTML comments since browsers will do the same
    $p->strict_comment(FALSE);
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
    @chunks = unpack("A$_chunksize"x(length($document)/$_chunksize).'A*',
                     $document);
    for (@chunks) {
        $p->parse($_);
    }
    if (! $_summary) {
        my $stop = &get_timestamp();
        if ($_progress) {
            print "\r";
        }
        printf(" done (%d lines in %ss).\n",
               $p->{Total},
               &time_diff($start, $stop));
    }
    return $p;
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

#######################################
# start function used by HTML::Parser #
#######################################

sub W3C::CheckLink::start() {
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

sub W3C::CheckLink::text() {
    my ($self, $text) = @_;
    if (!$_progress) {
        return unless $self->{extract_links};
    }
    if ($text =~ /\n/) {
        $self->new_line($text);
    }
}

sub W3C::CheckLink::end() {
    my $self = shift;
    return unless $self->{extract_links};
    shift;
    my $text = shift;
    $self->text($self, $text);
}

sub W3C::CheckLink::declaration() {
    my $self = shift;
    return unless $self->{extract_links};
    my $text = shift;
    $self->text($text);
}

sub W3C::CheckLink::comment() {
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
            $results->{$uri}{$uri}{code} = $RC_BAD_REQUEST;
            $results->{$uri}{$uri}{success} = 0;
            $results->{$uri}{$uri}{message} = 'Error: \'file:\' URI not allowed';
            if ($_verbose) {
                printf("Error: %d %s\n",
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
        # Mimic an HTTP::Response object
        $results->{$uri}{$uri}{code} = $testing_code;
        $results->{$uri}{$uri}{success} = 1;
    } else {
        $response = &get_uri($method, $uri);
        # Record the redirects
        &record_redirects($redirects, $response->{Redirects});
        # Parse the document if necessary and possible
        $results->{$uri}{$uri}{code} = $response->code();
        $results->{$uri}{$uri}{success} = $response->is_success();
        if (! $results->{$uri}{$uri}{success}) {
            $results->{$uri}{$uri}{message} = $response->message();
            if ($_verbose) {
                printf("Error: %d %s\n",
                       $results->{$uri}{$uri}{code},
                       $results->{$uri}{$uri}{message});
            }
            return;
        }
    }
    if ($#fragments == 0) {
        return;
    }
    my $p;
    if ($testing ne $uri) {
        if (!(($results->{$uri}{$uri}{type} = $response->header('Content-type')) =~ m/text\/html/i)) {
            if ($_verbose) {
                printf("Can't check content: Content-type is '%s'.\n",
                       $response->header('Content-type'));
            }
            return;
        }
        $p = &parse_document($response->base(), $response->as_string(), 0);
    } else {
        $p->{Anchors} = $anchors;
    }
    # Check that the fragments exist
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
    if ($_cl) {
        printf(STDERR "Authentication is required for %s.\n", $r->request->url);
        printf(STDERR "The realm is %s.\n", $realm);
        print(STDERR "Use the -u and -p options to specify a username and password.\n");
    } else {
        &html_header();
        &html_footer();
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

sub record_redirects(\%, \%) {
    my ($redirects, $sub) = @_;
    foreach $r (keys %$sub) {
        $redirects->{$r} = $sub->{$r};
    }
}

sub is_redirected($, %) {
    my ($uri, %redirects) = @_;
    return(defined($redirects{$uri}));
}

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
        printf("Found %d anchors.", $#anchors+1);
        if ($_html) {
            print('</p>');
        }
        print("\n");
    }
    # List of the duplicates, if any.
    @errors = keys %{$errors};
    if ($#errors < 0) {
        if (! $_quiet) {
            print "<p>Valid anchors!</p>";
        }
        return;
    }
    if ($_html) {
        print('<p>');
    }
    print('List of duplicate anchors:');
    if ($_html) {
        print("</p>\n<table border=\"1\">\n<tr><td><b>Anchors</b></td><td><b>Lines</b></td></tr>");
    }
    print("\n");
    foreach $anchor (@errors) {
        my $format;
        if ($_html) {
            $format = "<tr><td>%s</td><td>%s</td></tr>\n";
        } else {
            $format = "\t%s\tLines: %s\n";
        }
        printf($format, $anchor, join(', ', keys %{$anchors->{$anchor}}));
    }
    if ($_html) {
        print("</table>\n");
    }
}

sub links_summary(\%,\%,\%) {
    my ($links, $results, $broken, $redirects) = @_;
    if (! $_quiet) {
        if ($_html) {
            print("\n<hr>\n\n<p>");
        }
        my @links = keys %$links;
        my $n_fragments = 0;
        my $n_total = 0;
        foreach $u (@links) {
            my @fragments = keys %{$links->{$u}};
            $n_fragments += $#fragments + 1;
            foreach $f (@fragments) {
                my @lines = keys %{$links->{$u}{$f}};
                foreach $l (@lines) {
                    $n_total += $links->{$u}{$f}{$l};
                }
            }
        }
        printf("Found %d locations for %d URI's (%d total).",
               $#links+1,
               $n_fragments,
               $n_total);
        if ($_html) {
            print('</p>');
        }
        print("\n");
    }
    # List of the broken links
    @urls = keys %{$broken};
    if ($#urls < 0) {
        if (! $_quiet) {
            print "<p>Valid links!</p>";
        }
        return;
    }
    if ($_html) {
        print('<p>');
    }
    printf('List of broken %slinks:', $_redirects ? 'and redirected ' : '');
    if ($_html) {
        print("</p>\n<table border=\"1\">\n<tr><td><b>Location</b></td><td><b>Code</b></td><td><b>Fragment</b></td><td><b>Lines</b></td></tr>");
    }
    print("\n");
    if ($_redirects) {
        for $l (keys %$redirects) {
            next unless (defined($results->{$l})
                         && !defined($broken->{$l}));
            push(@urls, $l);
        }
    }
    foreach $u (@urls) {
        my @fragments = keys %{$links->{$u}};
        my $n_fragments = $#fragments+1;
        my $redirected = &is_redirected($u, %$redirects);
        my $lines_list;
        if (defined($links->{$u}{$u}{-1})) {
            $lines_list = '-';
        } else {
            $lines_list = join(', ',
                               sort {$a <=> $b} keys %{$links->{$u}{$u}});
        }
        if ($_html) {
            printf("<tr><th rowspan=\"%d\">%s</th><th rowspan=\"%d\"%s>%d%s</th><td>%s</td><td>%s</td></tr>\n",
                   $n_fragments,
                   $redirected ? join('<br>-&gt; ',
                                      &get_redirects($u, %$redirects)) : $u,
                   $n_fragments,
                   &bgcolor($results->{$u}{$u}{code}),
                   $results->{$u}{$u}{code},
                   $results->{$u}{$u}{message}
                   ? '<br>'.$results->{$u}{$u}{message}
                   : '',
                   '',
                   $lines_list);
        } else {
            printf("\n%s\t%s\n  Code: %d%s\n",
                   $redirected ? join("\n-> ",
                                      &get_redirects($u, %$redirects)) : $u,
                   $lines_list ? 'Lines: '.$lines_list : '' ,
                   $results->{$u}{$u}{code},
                   $results->{$u}{$u}{message});
        }
        foreach $f (@fragments) {
            next if ($f eq $u);
            my $format;
            if ($_html) {
                $format = "<tr><td>%s</td><td>%s</td></tr>\n";
            } else {
                $format = "\t%s\tLines: %s\n";
            }
            printf($format,
                   $f,
                   join(', ',
                        sort {$a <=> $b} keys %{$links->{$u}{$f}}));
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
    my $uri = HTML::Entities::encode($_[0]);
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

</style>
</head>
<body>
<h1>W3C Link Checker: $uri</h1>
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
    if ($r->is_redirect()) {
        return ' bgcolor="yellow"';
    }
    if ($r->is_error()) {
        return ' bgcolor="red"';
    }
    return ' bgcolor="grey"';
}

sub html_footer() {
    print "
<hr>
<address>
$PROGRAM $VERSION<br>
Report bugs to <a href=\"mailto:hugo\@w3.org\">Hugo Haas</a>
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
    &html_header($VERSION);
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
