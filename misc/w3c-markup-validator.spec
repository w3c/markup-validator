# RPM spec file for the W3C Markup Validator
# $Id: w3c-markup-validator.spec,v 1.4 2004-10-10 16:35:28 ville Exp $

Name:           w3c-markup-validator
Version:        0.7.0
Release:        0.cvs
Epoch:          0
Summary:        W3C Markup Validator

Group:          Applications/Internet
License:        W3C Software License
URL:            http://validator.w3.org/
Source0:        http://validator.w3.org/validator-0_7_0.tar.gz
Source1:        http://validator.w3.org/sgml-lib-0_7_0.tar.gz
BuildRoot:      %{_tmppath}/%{name}-%{version}-%{release}-root-%(%{__id_u} -n)

BuildArch:      noarch
BuildRequires:  perl
Requires:       httpd, openjade >= 0:1.3.2, %{name}-libs = %{epoch}:%{version}
Obsoletes:      w3c-validator

%description
The W3C Markup Validator checks documents like HTML and XHTML for
conformance to W3C Recommendations and other standards.

%package        libs
Summary:        SGML and XML DTDs for the W3C Markup Validator
Group:          Applications/Text
Requires:       sgml-common
Obsoletes:      w3c-validator-libs

%description    libs
SGML and XML DTDs for the W3C Markup Validator.


%prep
%setup -q -a 1 -n validator-%{version}
mv validator-%{version}/htdocs/sgml-lib .

# Localize config files
perl -pi -e \
  's|^(\s*)#Base\s*=.*|${1}Base = %{_datadir}/%{name}| ;
   s|^(\s*Library\s*=\s*).*|${1}%{_datadir}/sgml/%{name}| ;
   s|\bwww-validator\@w3\.org\b|root\@localhost| ;
   s|/validator\.w3\.org/|/localhost/w3c-validator/|' \
  htdocs/config/validator.conf
# TODO: conneg config for images
perl -pi -e \
  's|^(\s*URI\s*=\s*).*validator\.w3\.org/images/(\S+)
    |${1}images/${2}.gif|x ;
   s|^(\s*URI\s*=\s*).*www\.w3\.org/Icons/valid-html(\d+).*
    |${1}images/vh${2}.gif|x ;
   s|^(\s*URI\s*=\s*).*www\.w3\.org/Icons/valid-xhtml(\d+).*
    |${1}images/vxhtml${2}.gif|x' \
  htdocs/config/types.conf
perl -pi -e \
  's|/usr/share/w3c-markup-validator|%{_datadir}/%{name}|g' \
  httpd/conf/httpd.conf

# Move config out of the way
mv htdocs/config __config

# Fixup permissions
find . -type d | xargs chmod 755
find . -type f | xargs chmod 644
chmod 755 httpd/cgi-bin/check


%build
# Not


%install
rm -rf $RPM_BUILD_ROOT
mkdir -pm 755 $RPM_BUILD_ROOT%{_datadir}/%{name}/htdocs

# Script
cp -p httpd/cgi-bin/check $RPM_BUILD_ROOT%{_datadir}/%{name}/htdocs
# HTML and stuff
cp -pR htdocs/* $RPM_BUILD_ROOT%{_datadir}/%{name}/htdocs
# Templates
cp -pR share $RPM_BUILD_ROOT%{_datadir}/%{name}

# Config files
mkdir -pm 755 $RPM_BUILD_ROOT%{_sysconfdir}/w3c
cp -p __config/* $RPM_BUILD_ROOT%{_sysconfdir}/w3c
mkdir -pm 755 $RPM_BUILD_ROOT%{_sysconfdir}/httpd/conf.d
cp -p httpd/conf/httpd.conf \
  $RPM_BUILD_ROOT%{_sysconfdir}/httpd/conf.d/%{name}.conf

# SGML library
mkdir -pm 755 $RPM_BUILD_ROOT%{_datadir}/sgml
cp -pR sgml-lib $RPM_BUILD_ROOT%{_datadir}/sgml/%{name}
mkdir -pm 755 $RPM_BUILD_ROOT%{_sysconfdir}/sgml
touch $RPM_BUILD_ROOT%{_sysconfdir}/sgml/%{name}-%{version}-%{release}.cat


%clean
rm -rf $RPM_BUILD_ROOT


%post
if [ $1 -eq 1 ] ; then
  %{_initrddir}/httpd reload &>/dev/null || :
fi

%postun
%{_initrddir}/httpd reload &>/dev/null || :

%post libs
for catalog in "mathml.soc sgml.soc svg.soc xhtml.soc xml.soc"; do
  install-catalog --add \
    %{_sysconfdir}/sgml/%{name}-%{version}-%{release}.cat \
    %{_datadir}/sgml/%{name}/$catalog >/dev/null 2>&1 || :
done

%preun libs
for catalog in "mathml.soc sgml.soc svg.soc xhtml.soc xml.soc"; do
  install-catalog --remove \
    %{_sysconfdir}/sgml/%{name}-%{version}-%{release}.cat \
    %{_datadir}/sgml/%{name}/$catalog >/dev/null 2>&1 || :
done


%files
%defattr(-,root,root,-)
# Install path has changed in 0.7.0 (htdocs/ added to "base" path) so we don't
# want (noreplace) here.  Add it back in > 0.7.0.
%config %{_sysconfdir}/httpd/conf.d/%{name}.conf
# Config file format changed in 0.7.0 so we don't want (noreplace) here.
# Add it back in > 0.7.0.
%config %{_sysconfdir}/w3c
%{_datadir}/%{name}

%files libs
%defattr(-,root,root,-)
%ghost %config %{_sysconfdir}/sgml/%{name}-%{version}-%{release}.cat
%{_datadir}/sgml/%{name}


%changelog
* Sun Oct 10 2004 Ville Skyttä <ville.skytta at iki.fi> - 0:0.7.0-0
- Update to 0.7.0 (CVS HEAD as of today).

* Wed Jul 21 2004 Terje Bless <link@pobox.com> - 0:0.6.7-1
- Update to 0.6.7.

* Fri Jun  4 2004 Ville Skyttä <ville.skytta at iki.fi> - 0:0.6.6-2
- Fix Home Page and Msg FAQ URI in %%{_sysconfdir}/w3c/validator.conf.

* Thu May 20 2004 Ville Skyttä <ville.skytta at iki.fi> - 0:0.6.6-1
- Update to 0.6.6.
- Include local source/index.html in the package.

* Thu May  6 2004 Ville Skyttä <ville.skytta at iki.fi> - 0:0.6.5-1
- Update to 0.6.5.

* Fri Apr 30 2004 Ville Skyttä <ville.skytta at iki.fi> - 0:0.6.5-0.beta3.1
- Update to 0.6.5 beta 3.

* Sat Apr 24 2004 Ville Skyttä <ville.skytta at iki.fi> - 0:0.6.5-0.beta2.2
- Make httpd reload its config after install, upgrade and erase.
- Fix a couple of paths for beta2.

* Sat Apr 17 2004 Ville Skyttä <ville.skytta at iki.fi> - 0:0.6.5-0.beta2.1
- Update to 0.6.5 beta 2.

* Mon Apr  5 2004 Ville Skyttä <ville.skytta at iki.fi> - 0:0.6.5-0.beta1.3
- The link checker is now available separately from CPAN.

* Mon Dec  1 2003 Ville Skyttä <ville.skytta at iki.fi> - 0:0.6.5-0.beta1.2
- Cleanups.

* Fri Aug 29 2003 Ville Skyttä <ville.skytta at iki.fi> - 0:0.6.5-0.beta1.1
- Update to 0.6.5 beta 1.

* Sat Aug 23 2003 Ville Skyttä <ville.skytta at iki.fi> - 0:0.6.2-5w3c
- Requires openjade >= 0:1.3.2 (Red Hat packages OpenSP 1.5 there).

* Wed Jul 23 2003 Ville Skyttä <ville.skytta at iki.fi> - 0:0.6.2-4w3c
- Include checklink manual page.
- Some spec file cleanups.

* Thu Jul 17 2003 Ville Skyttä <ville.skytta at iki.fi> - 0:0.6.2-3w3c
- Requires perl(Net::IP).

* Fri Jul  4 2003 Ville Skyttä <ville.skytta at iki.fi> - 0:0.6.2-2w3c
- Use aliasing instead of hardcoded docroot in httpd configuration.

* Mon Apr 21 2003 Ville Skyttä <ville.skytta at iki.fi> - 0:0.6.2-1w3c
- Update to 0.6.2.
- Rename to w3c-markup-validator.
- Install our catalogs if %%{_bindir}/install-catalog is available.
- Add Epoch: 0.

* Sun Dec  1 2002 Ville Skyttä <ville.skytta at iki.fi> - 0.6.1-1w3c
- Update to 0.6.1.

* Fri Nov 29 2002 Ville Skyttä <ville.skytta at iki.fi> - 0.6.0-1w3c
- First release.
