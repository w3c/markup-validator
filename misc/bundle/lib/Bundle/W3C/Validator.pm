package Bundle::W3C::Validator;

use 5.6.0;
use strict;

use vars qw($VERSION);
$VERSION = '0.7.0';

1;

__END__

=head1 NAME

Bundle::W3C::Validator - Bundle of modules required by the W3C Markup Validator

=head1 SYNOPSIS

C<perl -MCPAN -e "install Bundle::W3C::Validator">

=head1 CONTENTS

 CGI 2.81
 Config::General
 HTML::Parser 3.25
 LWP::UserAgent 1.90
 Net::IP
 Set::IntSpan
 Text::Iconv
 URI

=head1 DESCRIPTION

This bundle contains the prerequisite CPAN modules for running the
W3C Markup Validator, E<lt>http://validator.w3.org/E<gt>.

=head1 SEE ALSO

E<lt>http://validator.w3.org/E<gt>
perl(1)

=head1 AUTHOR

The W3C Markup Validator Team, E<lt>www-validator@w3.orgE<gt>

=head1 COPYRIGHT AND LICENSE

Copyright (C) 1994-2004 World Wide Web Consortium, (Massachusetts
Institute of Technology, European Research Consortium for Informatics
and Mathematics, Keio University). All Rights Reserved. This work is
distributed under the W3C(R) Software License [1] in the hope that it
will be useful, but WITHOUT ANY WARRANTY; without even the implied
warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.

[1] http://www.w3.org/Consortium/Legal/copyright-software

=cut
