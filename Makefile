VERSION = $(shell perl -ne '/^version:\s*(\S+)/ && print $$1' misc/bundle/META.yml)

PERL_FILES = httpd/cgi-bin/check httpd/cgi-bin/sendfeedback.pl \
	misc/soc2xml.pl misc/spmpp.pl misc/docs_errors.pl \
	misc/bundle/Makefile.PL misc/bundle/lib/Bundle/W3C/Validator.pm

PERLTIDY = perltidy --profile=misc/perltidyrc --backup-and-modify-in-place
PERLCRITIC = perlcritic --profile misc/perlcriticrc

VALIDATOR_URI = http://localhost/w3c-validator/check

all: htdocs/docs/errors.html htdocs/sgml-lib/catalog.xml

htdocs/docs/errors.html: misc/docs_errors.pl share/templates/en_US/error_messages.cfg share/templates/en_US/docs_errors.tmpl htdocs/config/validator.conf
	env W3C_VALIDATOR_HOME=. W3C_VALIDATOR_CFG=htdocs/config/validator.conf misc/docs_errors.pl > $@

htdocs/sgml-lib/catalog.xml: misc/soc2xml.pl htdocs/sgml-lib/xml.soc
	misc/soc2xml.pl < htdocs/sgml-lib/xml.soc > $@

test:
	misc/testsuite/harness.py --validator_uri=$(VALIDATOR_URI) run

perlcritic:
	$(PERLCRITIC) $(PERL_FILES)

perltidy:
	@for file in $(PERL_FILES) ; do \
		echo "$(PERLTIDY) $$file" ; \
		$(PERLTIDY) $$file ; \
	done

dist: all
	misc/mkrelease.sh $(VERSION)
