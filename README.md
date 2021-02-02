# W3C Markup Validator

The Markup Validator is a free service by W3C that helps check the validity of Web documents.
Most Web documents are written using markup languages, such as HTML or XHTML. 
These languages are defined by technical specifications, which usually include a machine-readable formal grammar (and vocabulary). 
The act of checking a document against these constraints is called validation, and this is what the Markup Validator does.

The tool consists of a perl-based CGI script that uses DTD to verify the validity of HTML3, HTML4 and XHTML documents; it also incorporates by reference the [NU Validator](https://github.com/validator/validator/) used to validate HTML5 / HTML LS documents.

## Copyright

[W3C Software License and Notice](http://www.w3.org/Consortium/Legal/2002/copyright-software-20021231).
