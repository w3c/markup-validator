package Bundle::W3C::Validator;

use 5.8.0;
use strict;

use vars qw($VERSION);
$VERSION = '0.8.4';

1;

__END__

=head1 NAME

Bundle::W3C::Validator - Bundle of modules required by the W3C Markup Validator

=head1 SYNOPSIS

C<perl -MCPAN -e "install Bundle::W3C::Validator">

=head1 CONTENTS

 CGI 2.81
 Config::General 2.31
 Encode
 Encode::HanExtra
 Encode::JIS2K
 File::Spec::Functions
 HTML::Encoding 0.52
 HTML::Parser 3.24
 HTML::Template 2.6
 LWP::UserAgent 2.032
 Net::IP
 SGML::Parser::OpenSP
 URI
 XML::LibXML

=head1 DESCRIPTION

This bundle contains the prerequisite CPAN modules for running the
W3C Markup Validator, E<lt>http://validator.w3.org/E<gt>.

=head1 SEE ALSO

E<lt>http://validator.w3.org/E<gt>
perl(1)

=head1 AUTHOR

The W3C Markup Validator Team, E<lt>www-validator@w3.orgE<gt>

=head1 COPYRIGHT AND LICENSE

Copyright (C) 1994-2007 World Wide Web Consortium, (Massachusetts
Institute of Technology, European Research Consortium for Informatics
and Mathematics, Keio University). All Rights Reserved. This work is
distributed under the W3C(R) Software License [1] in the hope that it
will be useful, but WITHOUT ANY WARRANTY; without even the implied
warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.

[1] http://www.w3.org/Consortium/Legal/copyright-software

=cut
