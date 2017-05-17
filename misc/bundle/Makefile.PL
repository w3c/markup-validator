use 5.008;
use strict;
use warnings;

use ExtUtils::MakeMaker;

WriteMakefile(
    NAME          => 'Bundle::W3C::Validator',
    ABSTRACT_FROM => 'lib/Bundle/W3C/Validator.pm',
    AUTHOR        => 'W3C QA-dev Team <public-qa-dev@w3.org>',
    LICENSE       => 'open_source',
    VERSION_FROM  => 'lib/Bundle/W3C/Validator.pm',
    PREREQ_PM     => {

        # Hard dependencies:
        "CGI"                   => "3.40",
        "CGI::Carp"             => 0,
        "Config"                => 0,
        "Config::General"       => 2.32,
        "Encode"                => 0,
        "Encode::Alias"         => 0,
        "Encode::HanExtra"      => 0,
        "File::Spec::Functions" => 0,
        "HTML::Encoding"        => 0.52,
        "HTML::HeadParser"      => "3.60",
        "HTML::Parser"          => 3.24,
        "HTML::Template"        => 2.6,
        "HTTP::Headers::Auth"   => 0,
        "HTTP::Headers::Util"   => 0,
        "HTTP::Message"         => 1.52,
        "HTTP::Negotiate"       => 0,
        "HTTP::Request"         => 0,
        "JSON"                  => 2.00,
        "LWP::UserAgent"        => 2.032,
        "Net::hostent"          => 0,
        "Net::IP"               => 0,
        "SGML::Parser::OpenSP"  => 0.991,
        "Socket"                => 0,
        "URI"                   => 1.53,
        "URI::Escape"           => 0,
        "URI::file"             => 0,
        "URI::Heuristic"        => 0,
        "XML::LibXML"           => 1.73,

        # Optional:
        "Encode::JIS2K" => 0,
        "HTML::Tidy"    => 0,
    },
    META_MERGE => {
        resources => {
            homepage   => 'https://validator.w3.org/',
            bugtracker => 'http://www.w3.org/Bugs/Public/',
            repository => 'http://dvcs.w3.org/hg/markup-validator/',
            MailingList =>
                'http://lists.w3.org/Archives/Public/www-validator/',
        },

    },
    dist  => {TARFLAGS => '--owner=0 --group=0 -cvf'},
    clean => {FILES    => 'Makefile.PL.bak lib/Bundle/W3C/Validator.pm.bak'},
);
