package Bundle::W3C::Validator;

use 5.008;
use strict;
use warnings;

use vars qw($VERSION);
$VERSION = '0.8.6';

1;

__END__

=head1 NAME

Bundle::W3C::Validator - Bundle of modules required by the W3C Markup Validator

=head1 SYNOPSIS

C<perl -MCPAN -e "install Bundle::W3C::Validator">

=head1 CONTENTS

 CGI 2.81
 CGI::Carp
 Config
 Config::General 2.32
 Encode
 Encode::Alias
 Encode::HanExtra
 Encode::JIS2K - (optional)
 File::Spec::Functions
 HTML::Encoding 0.52
 HTML::HeadParser 3.60
 HTML::Parser 3.24
 HTML::Template 2.6
 HTML::Tidy - (optional)
 HTTP::Headers::Auth
 HTTP::Headers::Util
 HTTP::Message 1.52
 HTTP::Negotiate
 HTTP::Request
 JSON 2.00
 LWP::UserAgent 2.032
 Net::IP
 Net::hostent
 SGML::Parser::OpenSP 0.991
 Socket
 URI
 URI::Escape
 URI::file
 XML::LibXML 1.70

=head1 DESCRIPTION

This bundle contains the prerequisite CPAN modules for running the
W3C Markup Validator, L<http://validator.w3.org/>.

=head1 SEE ALSO

L<http://validator.w3.org/>

perl(1)

=head1 AUTHOR

W3C QA-dev Team, E<lt>public-qa-dev@w3.orgE<gt>

=head1 COPYRIGHT AND LICENSE

Copyright (C) 1994-2010 World Wide Web Consortium, (Massachusetts
Institute of Technology, European Research Consortium for Informatics
and Mathematics, Keio University). All Rights Reserved. This work is
distributed under the W3C(R) Software License [1] in the hope that it
will be useful, but WITHOUT ANY WARRANTY; without even the implied
warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.

[1] L<http://www.w3.org/Consortium/Legal/copyright-software>

=cut
