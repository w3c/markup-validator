use 5.6.0;
use ExtUtils::MakeMaker;

WriteMakefile(
    NAME          => 'Bundle::W3C::Validator',
    ABSTRACT_FROM => 'lib/Bundle/W3C/Validator.pm',
    AUTHOR        => 'The W3C Markup Validator Team <www-validator@w3.org>',
    VERSION_FROM  => 'lib/Bundle/W3C/Validator.pm',
    PREREQ_PM     => {
                      CGI             => 2.81,
                      Config::General => 2.19,
                      HTML::Parser    => 3.25,
                      HTML::Template  => 2.6,
                      LWP::UserAgent  => 1.90,
                      Net::IP         => 0,
                      Set::IntSpan    => 0,
                      Text::Iconv     => 0,
                      URI             => 0,
                     },
  dist            => { TARFLAGS => '--owner=0 --group=0 -cvf' },
  clean           => { FILES => 'ChangeLog.bak' },
);

sub MY::postamble {
  return <<'MAKE_FRAG';
changelog:
	cvs2cl --FSF --utc --prune \
	  --ignore ChangeLog --ignore cvsignore --ignore SIGNATURE \
	  --ignore Makefile.PL --ignore META.yml --ignore MANIFEST
MAKE_FRAG
}
