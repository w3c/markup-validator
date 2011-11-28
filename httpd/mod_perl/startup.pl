# mod_perl startup file for the W3C Markup Validator
# http://perl.apache.org/docs/2.0/user/handlers/server.html#mod_perl_Startup

use warnings;
use strict;

# If the validator is not installed in its default dir layout in
# /usr/local/validator, be sure to modify this file so that the path to
# catalog.xml below is correct for validator's sgml-lib/catalog.xml

my $home = $ENV{W3C_VALIDATOR_HOME} || "/usr/local/validator";
$ENV{XML_CATALOG_FILES} = "$home/htdocs/sgml-lib/catalog.xml";

1;
