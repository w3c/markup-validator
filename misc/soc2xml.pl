#!/usr/bin/perl

use strict;
use warnings;

# Crude script for converting SGML Open Catalogs to XML catalogs.
# Usage: soc2xml.pl < catalog.soc > catalog.xml

sub esc
{
    (my $esc = shift) =~ s/&/&auml;/g;
    $esc =~ s/"/&quot;/g;
    $esc =~ s/'/&apos;/g;
    $esc =~ s/</&lt;/g;
    $esc =~ s/>/&gt;/g;
    $esc;
}

local $/ = undef;
my $soc = <>;

print <<'EOF';
<?xml version="1.0"?>
<!-- Automatically generated from SGML Open Catalog - don't edit, regenerate -->
<!DOCTYPE catalog PUBLIC "-//OASIS//DTD Entity Resolution XML Catalog V1.0//EN" "http://www.oasis-open.org/committees/entity/release/1.0/catalog.dtd">
<catalog xmlns="urn:oasis:names:tc:entity:xmlns:xml:catalog">
EOF

while ($soc =~ /(PUBLIC|SYSTEM)\s+"([^"]+)"\s+"([^"]+)"/g) {
    my $pubsys = lc($1);
    printf <<'EOF', $pubsys, $pubsys, esc($2), esc($3);
  <%s %sId="%s" uri="%s" />
EOF
}

print <<'EOF';
</catalog>
EOF
