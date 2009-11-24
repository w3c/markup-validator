PERL_FILES = httpd/cgi-bin/check httpd/cgi-bin/sendfeedback.pl \
	misc/spmpp.pl misc/docs_errors.pl misc/bundle/Makefile.PL \
	misc/bundle/lib/Bundle/W3C/Validator.pm

PERLTIDY = perltidy --profile=misc/perltidyrc --backup-and-modify-in-place
PERLCRITIC = perlcritic --profile misc/perlcriticrc

all:

perlcritic:
	$(PERLCRITIC) $(PERL_FILES)

perltidy:
	@for file in $(PERL_FILES) ; do \
		echo "$(PERLTIDY) $$file" ; \
		$(PERLTIDY) $$file ; \
	done
