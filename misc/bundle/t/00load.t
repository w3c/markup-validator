use strict;                                                      # -*- perl -*-
use Test;

BEGIN { plan tests => 1 }

eval {
  require Bundle::W3C::Validator;
};
ok(!$@);
