use 5.8.0;
use ExtUtils::MakeMaker;

WriteMakefile(
    NAME          => 'Bundle::W3C::Validator',
    ABSTRACT_FROM => 'lib/Bundle/W3C/Validator.pm',
    AUTHOR        => 'The W3C Markup Validator Team <www-validator@w3.org>',
    VERSION_FROM  => 'lib/Bundle/W3C/Validator.pm',
    PREREQ_PM     => {
                      CGI                   => 2.81,
                      Config::General       => 2.31,
                      Encode                => 0,
                      Encode::HanExtra      => 0,
                      File::Spec::Functions => 0,
                      HTML::Encoding        => 0.52,
                      HTML::Parser          => 3.24,
                      HTML::Template        => 2.6,
                      LWP::UserAgent        => 2.032,
                      Net::IP               => 0,
                      SGML::Parser::OpenSP  => 0,
                      URI                   => 0,
                      XML::LibXML           => 0,
                     },
  dist            => { TARFLAGS => '--owner=0 --group=0 -cvf' },
  clean           => { FILES => 'ChangeLog.bak' },
);

sub MY::postamble {
  return <<'MAKE_FRAG';
ChangeLog: README lib/Bundle/W3C/Validator.pm t/00load.t
	cvs2cl --FSF --utc --prune \
	  --ignore ChangeLog --ignore cvsignore --ignore SIGNATURE \
	  --ignore Makefile.PL --ignore META.yml --ignore MANIFEST
MAKE_FRAG
}
