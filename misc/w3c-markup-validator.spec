# RPM Spec file for the W3C Markup Validator
# $Id: w3c-markup-validator.spec,v 1.3 2003-03-01 09:26:13 ville Exp $

%define httpd_confdir %{_sysconfdir}/httpd/conf.d
%define htmldir       %{_var}/www/html
%define sgmldir       %{_datadir}/sgml

# -----------------------------------------------------------------------------

Summary:        W3C Markup Validator
Name:           w3c-markup-validator
Version:        0.6.2
Release:        1w3c
URL:            http://validator.w3.org/
License:        http://www.w3.org/Consortium/Legal/copyright-software
Source0:        http://validator.w3.org/dist/validator-0_6_2.tar.gz
Source1:        http://validator.w3.org/dist/sgml-lib-0_6_2.tar.gz
Group:          Applications/Internet
BuildRoot:      %{_tmppath}/%{name}-%{version}-%{release}-root
BuildRequires:  perl
Requires:       httpd, %{name}-libs = 0.6.2
Requires:       perl >= 5.6, perl-HTML-Parser >= 3.25, perl-libwww-perl
Requires:       perl-URI, perl-Text-Iconv, perl(CGI) >= 2.81, perl(Time::HiRes)
Requires:       perl(Set::IntSpan), perl(Config::General) >= 2.06
Requires:       opensp >= 1.5
Obsoletes:      w3c-validator
BuildArch:      noarch

%description
The W3C Markup Validator checks documents like HTML and XHTML for
conformance to W3C Recommendations and other standards.

# -----------------------------------------------------------------------------

%package libs
Summary:        SGML and XML DTDs for the W3C Markup Validator
Group:          Applications/Text
Obsoletes:      w3c-validator-libs
# No need to require the main package

%description libs
SGML and XML DTDs for the W3C Markup Validator.

# -----------------------------------------------------------------------------

%prep
%setup -q -a 1 -n validator

# Localize config files
perl -pi -e 's|\bwww-validator\@w3\.org\b|root\@localhost| ;
             s|/validator\.w3\.org/|/localhost/%{name}/| ;
             s|/usr/local/validator/htdocs/config/|%{_sysconfdir}/w3c/| ;
             s|/usr/local/validator/htdocs/|%{htmldir}/%{name}/| ;
             s|^(SGML\s+Library\s+).*|${1}%{sgmldir}/%{name}|' \
  htdocs/config/validator.conf
perl -pi -e 's|/var/www/html/|%{htmldir}/|' httpd/conf/httpd.conf

# Cleanup of unused files
rm -f httpd/cgi-bin/[Lprt]*
rename .pl '' httpd/cgi-bin/checklink.pl
rm -rf htdocs/p3p.html htdocs/source

# Fixup permissions
find . -type d -exec chmod 0755 {} ';'
find . -type f -exec chmod 0644 {} ';'
chmod 0755 httpd/cgi-bin/*

# -----------------------------------------------------------------------------

%build
# Nothing here.

# -----------------------------------------------------------------------------

%install
rm -rf $RPM_BUILD_ROOT
mkdir -p $RPM_BUILD_ROOT{%{htmldir}/%{name},%{httpd_confdir},%{_bindir}}

# Scripts
cp -p httpd/cgi-bin/* $RPM_BUILD_ROOT%{htmldir}/%{name}
ln -s %{htmldir}/%{name}/checklink $RPM_BUILD_ROOT/%{_bindir}

# Config files
mkdir -p $RPM_BUILD_ROOT%{_sysconfdir}/w3c
cp -p htdocs/config/* $RPM_BUILD_ROOT%{_sysconfdir}/w3c
cp -p httpd/conf/httpd.conf $RPM_BUILD_ROOT%{httpd_confdir}/%{name}.conf

# HTML and stuff
rm -rf htdocs/config
cp -a htdocs/* $RPM_BUILD_ROOT%{htmldir}/%{name}

# SGML library
mkdir -p $RPM_BUILD_ROOT%{sgmldir}
cp -pr sgml-lib $RPM_BUILD_ROOT%{sgmldir}/%{name}

# -----------------------------------------------------------------------------

%clean
rm -rf $RPM_BUILD_ROOT

# -----------------------------------------------------------------------------

%files
%defattr(-,root,root,-)
%config(noreplace) %{httpd_confdir}/*
%config(noreplace) %{_sysconfdir}/w3c/*
%{htmldir}/%{name}
%{_bindir}/*

# -----------------------------------------------------------------------------

%files libs
%defattr(-,root,root,-)
%{sgmldir}/%{name}

# -----------------------------------------------------------------------------

%changelog
* Sat Feb 22 2003 Ville Skyttä <ville.skytta at iki.fi> - 0.6.2-1w3c
- Update to 0.6.2.
- Rename to w3c-markup-validator.

* Sun Dec  1 2002 Ville Skyttä <ville.skytta at iki.fi> - 0.6.1-1w3c
- Update to 0.6.1.

* Fri Nov 29 2002 Ville Skyttä <ville.skytta at iki.fi> - 0.6.0-1w3c
- First release.
