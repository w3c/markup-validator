PERL_FILES = httpd/cgi-bin/check httpd/cgi-bin/sendfeedback.pl \
	misc/spmpp.pl misc/docs_errors.pl misc/bundle/Makefile.PL \
	misc/bundle/lib/Bundle/W3C/Validator.pm

all:

tidy:
	for file in $(PERL_FILES) ; do \
		echo "Tidying $$file..." ; \
		perltidy --profile=misc/perltidyrc $$file ; \
	done
