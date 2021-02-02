VERSION = $(shell perl -ne '/^\$$VERSION\b.*?([\d.]+)/ && print $$1' httpd/cgi-bin/check)

CSS_FILES = htdocs/style/base.css htdocs/style/results.css
JS_SOURCES = htdocs/scripts/mootools-1.2.5-core-nc.js \
	htdocs/scripts/mootools-1.2.5.1-more.js	htdocs/scripts/w3c-validator.js
PERL_FILES = httpd/cgi-bin/check httpd/cgi-bin/sendfeedback.pl \
	httpd/mod_perl/startup.pl misc/soc2xml.pl misc/spmpp.pl \
	misc/docs_errors.pl misc/bundle/Makefile.PL \
	misc/bundle/lib/Bundle/W3C/Validator.pm
GZIP_FILES = $(addsuffix .gz,$(CSS_FILES)) htdocs/scripts/combined.js.gz

PERLTIDY = perltidy --profile=misc/perltidyrc --backup-and-modify-in-place \
	--backup-file-extension=/
PERLCRITIC = perlcritic --profile misc/perlcriticrc

YUICOMPRESSOR = java -jar /usr/share/yui-compressor/yui-compressor.jar
GZIP = gzip -9n

VALIDATOR_URI = http://localhost/w3c-validator/check

# Override the above variables in config.mk if needed.
-include config.mk

all: htdocs/docs/errors.html htdocs/sgml-lib/catalog.xml $(GZIP_FILES)

htdocs/docs/errors.html: misc/docs_errors.pl share/templates/en_US/error_messages.cfg share/templates/en_US/docs_errors.tmpl htdocs/config/validator.conf
	env W3C_VALIDATOR_HOME=. W3C_VALIDATOR_CFG=htdocs/config/validator.conf misc/docs_errors.pl > $@

htdocs/sgml-lib/catalog.xml: misc/soc2xml.pl htdocs/sgml-lib/xml.soc
	misc/soc2xml.pl < htdocs/sgml-lib/xml.soc > $@

htdocs/scripts/combined.js: $(JS_SOURCES)
	rm -f $@
	@for src in $(JS_SOURCES) ; do \
		echo "$(YUICOMPRESSOR) $$src >> $@" ; \
		$(YUICOMPRESSOR) $$src >> $@ ; \
	done

.css.css.gz .js.js.gz:
	$(GZIP) -c $< > $@ && touch -r $< $@

test:
	misc/testsuite/harness.py --validator_uri=$(VALIDATOR_URI) run

perlcritic:
	$(PERLCRITIC) $(PERL_FILES)

perltidy:
	@for file in $(PERL_FILES) ; do \
		echo "$(PERLTIDY) $$file" ; \
		$(PERLTIDY) $$file ; \
	done

clean:
	rm -f $(GZIP_FILES)

dist: all
	@for file in htdocs/footer.html htdocs/whatsnew.html \
		httpd/cgi-bin/check share/templates/*/footer.tmpl ; do \
		grep -qF "$(VERSION)" $$file || { \
		echo "Validator version in $$file seems out of date." ; \
		exit 1 ; } ; \
	done
	misc/mkrelease.sh $(VERSION)

w3c:
	perl -pi -e 'undef $$/; s/\n\n<p id="test_warning".+//s' htdocs/intro.html
	perl -pi -e 's/no_w3c.png/w3c.png/' htdocs/header.html
	perl -pi -e 's/no_w3c.png/w3c.png/' share/templates/en_US/header.tmpl

.SUFFIXES: .css .css.gz .js .js.gz
