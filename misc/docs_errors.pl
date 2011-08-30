#!/usr/bin/perl -T
##
## Generates HTML documentation of error messages and explanations
## for W3C Markup Validation Service

## Pragmas.
use strict;
use warnings;

## Modules.  See also the BEGIN block further down below.

use File::Spec::Functions qw(catfile);
use HTML::Template qw();          # Need 2.6 but can't say, rt.cpan.org#70190
use Config::General 2.32 qw();    # Need 2.32 for <msg 0>, rt.cpan.org#17852

use vars qw($DEBUG $CFG $VERSION);

# Define global constants
use constant TRUE  => 1;
use constant FALSE => 0;

BEGIN {

    my $base = $ENV{W3C_VALIDATOR_HOME} || '/usr/local/validator';

    # Launder data for -T; -AutoLaunder doesn't catch this one.
    if ($base =~ /^(.*)$/) {
        $base = $1;
    }

    #
    # Read Config Files.
    eval {
        my %config_opts = (
            -ConfigFile =>
                ($ENV{W3C_VALIDATOR_CFG} || '/etc/w3c/validator.conf'),
            -MergeDuplicateOptions => TRUE,
            -MergeDuplicateBlocks  => TRUE,
            -SplitPolicy           => 'equalsign',
            -UseApacheInclude      => TRUE,
            -IncludeRelative       => TRUE,
            -InterPolateVars       => TRUE,
            -AutoLaunder           => TRUE,
            -AutoTrue              => TRUE,
            -DefaultConfig         => {Paths => {Base => $base,},},
        );
        my %cfg = Config::General->new(%config_opts)->getall();
        $CFG = \%cfg;
    };
    if ($@) {
        die <<"EOF";
Could not read configuration.  Set the W3C_VALIDATOR_CFG environment variable
or copy conf/* to /etc/w3c/. Make sure that the configuration file and all
included files are readable by the web server user. The error was:\n'$@'
EOF
    }
}    # end of BEGIN block.

#
# Get rid of (possibly insecure) $PATH.
delete $ENV{PATH};

our $lang = 'en_US';    # @@@ TODO: conneg

# Read error message + explanations file
our $error_messages_file =
    catfile($CFG->{Paths}->{Templates}, $lang, 'error_messages.cfg');
our %config_errs = (
    -MergeDuplicateBlocks => 1,
    -ConfigFile           => $error_messages_file
);
our %rsrc = Config::General->new(%config_errs)->getall();

our $T = HTML::Template->new(
    filename => catfile($CFG->{Paths}->{Templates}, $lang, 'docs_errors.tmpl'),
    die_on_bad_params => FALSE,
);

$T->param(list_errors_hasverbose => &list_errors_hasverbose(\%rsrc));
$T->param(list_errors_noverbose  => &list_errors_noverbose(\%rsrc));
print $T->output;

sub list_errors_hasverbose
{
    my $rsrc   = shift;
    my $errors = [];
    my $error_id;
    my $max_error_id = 500;    # where to stop
    for ($error_id = 0; $error_id < $max_error_id; $error_id++) {
        my %single_error;
        if ($rsrc->{msg}->{$error_id}) {
            my $verbose = $rsrc->{msg}->{$error_id}->{verbose};
            if ($verbose) {
                my $original = $rsrc->{msg}->{$error_id}->{original};
                $original               = &de_template_explanation($original);
                $single_error{original} = $original;
                $single_error{id}       = $error_id;
                $single_error{verbose}  = $rsrc->{msg}->{$error_id}->{verbose};

                push @{$errors}, \%single_error;

                # Fix up relative paths (/check vs /docs/errors.html)
                s/href="docs\//href="/
                    for $single_error{original}, $single_error{verbose};
            }

        }
    }
    return $errors;
}

sub list_errors_noverbose
{
    my $rsrc   = shift;
    my $errors = [];
    my $error_id;
    my $max_error_id = 500;    # where to stop
    for ($error_id = 0; $error_id < $max_error_id; $error_id++) {
        my %single_error;
        if ($rsrc->{msg}->{$error_id}) {
            my $verbose = $rsrc->{msg}->{$error_id}->{verbose};
            if (!$verbose) {
                my $original = $rsrc->{msg}->{$error_id}->{original};
                $original               = &de_template_explanation($original);
                $single_error{original} = $original;
                $single_error{id}       = $error_id;
                $single_error{verbose}  = $rsrc->{msg}->{$error_id}->{verbose};
                push @{$errors}, \%single_error;
            }

        }
    }
    return $errors;
}

sub de_template_explanation
{

    # takes the error message template, and replace "template keywords" with real life keywords
    my $explanation = shift;
    if ($explanation) {
        $explanation =~ s/\%1/X/;
        $explanation =~ s/\%2/Y/;
        $explanation =~ s/\%3/Z/;
        $explanation =~ s/\%4/a/;
        $explanation =~ s/\%5/b/;
        $explanation =~ s/\%6/c/;
    }
    return $explanation;
}

# Local Variables:
# mode: perl
# indent-tabs-mode: nil
# cperl-indent-level: 4
# cperl-continued-statement-offset: 4
# cperl-brace-offset: -4
# perl-indent-level: 4
# End:
# ex: ts=4 sw=4 et
