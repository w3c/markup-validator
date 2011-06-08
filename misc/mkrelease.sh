#!/bin/bash

# Typical usage:
#   hg clone -b validator-1_0-release https://dvcs.w3.org/hg/markup-validator
#   cd markup-validator
#   misc/mkrelease.sh 1.0

version="$1"
if [ -z "$version" ] ; then
  echo "Usage: $0 <version>"
  exit 1
fi


set -e

tbversion=${version//./_}
topdir=$(cd $(dirname $0)/.. ; pwd)
tmpdir=
trap cleanup EXIT

cleanup()
{
    set +e
    [ -z "$tmpdir" -o ! -d "$tmpdir" ] || rm -rf "$tmpdir"
}

tmpdir=$(mktemp -d /tmp/validator.XXXXXX)
mkdir -p $tmpdir/validator-$version
cp -pR $topdir/{htdocs,httpd,misc,share,Makefile,README.cvs} \
    $tmpdir/validator-$version

cd $tmpdir

rm -rf validator-$version/.hg*
find validator-$version -name "*~"        | xargs -r rm -rf
find validator-$version -name ".#*"       | xargs -r rm -rf
find validator-$version -name "*.py[co]"  | xargs -r rm -rf
find validator-$version -name "*.bak"     | xargs -r rm -rf
rm -f validator-$version/misc/mkrelease.sh
rm -f validator-$version/htdocs/no_referer.asis
rm -rf validator-$version/misc/bundle

cp validator-$version/htdocs/images/no_w3c.png \
  validator-$version/htdocs/images/w3c.png

find . -type d | xargs -r chmod 755
find . -type f | xargs -r chmod 644
chmod 755 validator-$version/httpd/cgi-bin/check
chmod 755 validator-$version/httpd/cgi-bin/sendfeedback.pl

# Try to cheat HTML::Template into refreshing its possible caches (it doesn't
# take options for new() into account when determining freshness as of 2.9).
touch validator-$version/share/templates/*/*.tmpl

# sgml-lib tarball
tar zc --owner=0 --group=0 -f $topdir/sgml-lib-$tbversion.tar.gz \
  validator-$version/htdocs/sgml-lib

# Validator tarball
rm -rf validator-$version/htdocs/sgml-lib
tar zc --owner=0 --group=0 -f $topdir/validator-$tbversion.tar.gz \
  validator-$version

ls -l $topdir/validator-$tbversion.tar.gz $topdir/sgml-lib-$tbversion.tar.gz
