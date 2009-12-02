VERSION = $(shell perl -ne '/^version:\s*(\S+)/ && print $$1' misc/bundle/META.yml)

PERL_FILES = httpd/cgi-bin/check httpd/cgi-bin/sendfeedback.pl \
	misc/spmpp.pl misc/docs_errors.pl misc/bundle/Makefile.PL \
	misc/bundle/lib/Bundle/W3C/Validator.pm

PERLTIDY = perltidy --profile=misc/perltidyrc --backup-and-modify-in-place
PERLCRITIC = perlcritic --profile misc/perlcriticrc

VALIDATOR_URI = http://localhost/w3c-validator/check

all:

test:
	misc/testsuite/harness.py --validator_uri=$(VALIDATOR_URI) run

perlcritic:
	$(PERLCRITIC) $(PERL_FILES)

perltidy:
	@for file in $(PERL_FILES) ; do \
		echo "$(PERLTIDY) $$file" ; \
		$(PERLTIDY) $$file ; \
	done

dist:
	misc/mkrelease.sh $(VERSION)
