# RPM Spec file for the W3C Markup Validator
# $Id: w3c-markup-validator.spec,v 1.1.2.10 2003-08-23 19:30:41 ville Exp $

%{!?apxs: %{expand:   %%define apxs %{_sbindir}/apxs}}
%define httpd_confdir %(test -d %{_sysconfdir}/httpd/conf.d && echo %{_sysconfdir}/httpd/conf.d || %{apxs} -q SYSCONFDIR)
%define sgmldir       %{_datadir}/sgml

Name:           w3c-markup-validator
Version:        0.6.2
Release:        5w3c
Epoch:          0
Summary:        W3C Markup Validator

Group:          Applications/Internet
License:        W3C Software License
URL:            http://validator.w3.org/
Source0:        http://validator.w3.org/dist/validator-0_6_2.tar.gz
Source1:        http://validator.w3.org/dist/sgml-lib-0_6_2.tar.gz
BuildRoot:      %{_tmppath}/%{name}-%{version}-%{release}-root-%(%{__id_u} -n)
BuildArch:      noarch

BuildRequires:  perl, %{apxs}
Requires:       httpd, %{name}-libs = %{epoch}:%{version}
Requires:       perl >= 5.6, perl-HTML-Parser >= 3.25, perl-libwww-perl
Requires:       perl-URI, perl-Text-Iconv, perl(CGI) >= 2.81, perl(Time::HiRes)
Requires:       perl(Set::IntSpan), perl(Config::General) >= 2.06
Requires:       perl(Net::IP), openjade >= 0:1.3.2
Obsoletes:      w3c-validator

%description
The W3C Markup Validator checks documents like HTML and XHTML for
conformance to W3C Recommendations and other standards.

%package        libs
Summary:        SGML and XML DTDs for the W3C Markup Validator
Group:          Applications/Text
Obsoletes:      w3c-validator-libs
# No need to require the main package

%description    libs
SGML and XML DTDs for the W3C Markup Validator.


%prep
%setup -q -a 1 -n validator

# Localize config files
perl -pi -e 's|\bwww-validator\@w3\.org\b|root\@localhost| ;
             s|/validator\.w3\.org/|/localhost/%{name}/| ;
             s|/usr/local/validator/htdocs/config/|%{_sysconfdir}/w3c/| ;
             s|/usr/local/validator/htdocs/|%{_datadir}/%{name}/| ;
             s|^(SGML\s+Library\s+).*|${1}%{sgmldir}/%{name}|' \
  htdocs/config/validator.conf
perl -pi -e 's|/usr/share/w3c-markup-validator|%{_datadir}/%{name}|g' \
  httpd/conf/httpd.conf

# Cleanup of unused files
rm -rf \
  httpd/cgi-bin/[Lprt]* \
  htdocs/p3p.html \
  htdocs/source \
  htdocs/config/verbosemsg.rc

# Rename checklink
rename .pl '' httpd/cgi-bin/checklink.pl

# Fixup permissions
find . -type d -exec chmod 0755 {} ';'
find . -type f -exec chmod 0644 {} ';'
chmod 0755 httpd/cgi-bin/check*


%build
# Create the manual pages.
pod2man --center="W3C Link Checker" httpd/cgi-bin/checklink > checklink.1


%install
rm -rf $RPM_BUILD_ROOT
mkdir -p $RPM_BUILD_ROOT{%{_datadir}/%{name},%{httpd_confdir},%{_bindir}}

# Scripts
cp -p httpd/cgi-bin/check* $RPM_BUILD_ROOT%{_datadir}/%{name}
ln -s %{_datadir}/%{name}/checklink $RPM_BUILD_ROOT%{_bindir}

# Config files
mkdir -p $RPM_BUILD_ROOT%{_sysconfdir}/w3c
cp -p htdocs/config/* $RPM_BUILD_ROOT%{_sysconfdir}/w3c
cp -p httpd/conf/httpd.conf $RPM_BUILD_ROOT%{httpd_confdir}/%{name}.conf

# HTML and stuff
rm -rf htdocs/config
cp -a htdocs/* $RPM_BUILD_ROOT%{_datadir}/%{name}

# SGML library
mkdir -p $RPM_BUILD_ROOT{%{sgmldir},%{_sysconfdir}/sgml}
cp -pr sgml-lib $RPM_BUILD_ROOT%{sgmldir}/%{name}
> $RPM_BUILD_ROOT%{_sysconfdir}/sgml/%{name}-%{version}-%{release}.cat

# Man pages
mkdir -p $RPM_BUILD_ROOT%{_mandir}/man1
cp -p checklink.1 $RPM_BUILD_ROOT%{_mandir}/man1


%clean
rm -rf $RPM_BUILD_ROOT


%post libs
# Note that we're using a fully versioned catalog, so this is always ok.
if [ -x %{_bindir}/install-catalog -a -d %{_sysconfdir}/sgml ]; then
  for catalog in "mathml.soc sgml.soc svg.soc xhtml.soc xml.soc"; do
    %{_bindir}/install-catalog --add \
      %{_sysconfdir}/sgml/%{name}-%{version}-%{release}.cat \
      %{sgmldir}/%{name}/$catalog > /dev/null 2>&1 || :
  done
fi

%preun libs
# Note that we're using a fully versioned catalog, so this is always ok.
if [ -x %{_bindir}/install-catalog -a -d %{_sysconfdir}/sgml ]; then
  for catalog in "mathml.soc sgml.soc svg.soc xhtml.soc xml.soc"; do
    %{_bindir}/install-catalog --remove \
      %{_sysconfdir}/sgml/%{name}-%{version}-%{release}.cat \
      %{sgmldir}/%{name}/$catalog > /dev/null 2>&1 || :
  done
fi


%files
%defattr(-,root,root,-)
%config(noreplace) %{httpd_confdir}/%{name}.conf
%config(noreplace) %{_sysconfdir}/w3c
%{_datadir}/%{name}
%{_bindir}/checklink
%{_mandir}/man1/checklink.1*

%files libs
%defattr(0644,root,root,0755)
%ghost %config %{_sysconfdir}/sgml/%{name}-%{version}-%{release}.cat
%{sgmldir}/%{name}


%changelog
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
