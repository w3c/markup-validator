PERL_FILES = httpd/cgi-bin/check httpd/cgi-bin/sendfeedback.pl \
	misc/spmpp.pl misc/docs_errors.pl misc/bundle/Makefile.PL \
	misc/bundle/lib/Bundle/W3C/Validator.pm

PERLTIDY = perltidy --profile=misc/perltidyrc --backup-and-modify-in-place

all:

perltidy:
	for file in $(PERL_FILES) ; do \
		echo "Perltidying $$file..." ; \
		$(PERLTIDY) $$file ; \
	done
