# RPM spec file for the W3C Markup Validator

%{expand: %%define tbver %(echo %{version} | tr . _)}

Name:           w3c-markup-validator
Version:        1.0
Release:        0
Summary:        W3C Markup Validator

Group:          Applications/Internet
License:        W3C Software License
URL:            https://validator.w3.org/
Source0:        https://validator.w3.org/dist/validator-%{tbver}.tar.gz
Source1:        https://validator.w3.org/dist/sgml-lib-%{tbver}.tar.gz
BuildRoot:      %{_tmppath}/%{name}-%{version}-%{release}-root-%(%{__id_u} -n)

BuildArch:      noarch
BuildRequires:  perl
Requires:       httpd
Requires:       %{name}-libs = %{version}

%description
The W3C Markup Validator checks documents like HTML and XHTML for
conformance to W3C Recommendations and other standards.

%package        libs
Summary:        SGML and XML DTDs for the W3C Markup Validator
Group:          Applications/Text
Requires:       sgml-common

%description    libs
SGML and XML DTDs for the W3C Markup Validator.


%prep
%setup -q -a 1 -n validator-%{version}
mv validator-%{version}/htdocs/sgml-lib .

# Localize configs.
%{__perl} -pi -e \
  's|/usr/local/validator\b|%{_datadir}/%{name}|' \
  htdocs/config/validator.conf httpd/conf/httpd.conf httpd/cgi-bin/*
%{__perl} -pi -e \
  's|^(\s*Library\s*=\s*).*|${1}%{_datadir}/sgml/%{name}| ;
   s|^(\s*TidyConf\s*=\s*).*|${1}%{_sysconfdir}/w3c/tidy.conf| ;
   s|\bwww-validator\@w3\.org\b|root\@localhost|' \
  htdocs/config/validator.conf

# Move config out of the way
mv htdocs/config __config


%build


%install
rm -rf $RPM_BUILD_ROOT

# Config files
install -dm 755 $RPM_BUILD_ROOT%{_sysconfdir}/w3c
install -pm 644 __config/* $RPM_BUILD_ROOT%{_sysconfdir}/w3c
install -Dpm 644 httpd/conf/httpd.conf \
  $RPM_BUILD_ROOT%{_sysconfdir}/httpd/conf.d/%{name}.conf

# Scripts, HTML, etc.
install -dm 755 $RPM_BUILD_ROOT%{_datadir}/%{name}
cp -pR httpd/cgi-bin htdocs share $RPM_BUILD_ROOT%{_datadir}/%{name}

# SGML library
install -dm 755 $RPM_BUILD_ROOT%{_datadir}/sgml
cp -pR sgml-lib $RPM_BUILD_ROOT%{_datadir}/sgml/%{name}
install -dm 755 $RPM_BUILD_ROOT%{_sysconfdir}/sgml
touch $RPM_BUILD_ROOT%{_sysconfdir}/sgml/%{name}-%{version}-%{release}.cat


%clean
rm -rf $RPM_BUILD_ROOT


%post
[ $1 -eq 1 ] && %{_initrddir}/httpd reload &>/dev/null || :

%postun
%{_initrddir}/httpd reload &>/dev/null || :

%post libs
for catalog in sgml.soc xml.soc ; do
  install-catalog --add \
    %{_sysconfdir}/sgml/%{name}-%{version}-%{release}.cat \
    %{_datadir}/sgml/%{name}/$catalog >/dev/null 2>&1 || :
done

%preun libs
for catalog in sgml.soc xml.soc ; do
  install-catalog --remove \
    %{_sysconfdir}/sgml/%{name}-%{version}-%{release}.cat \
    %{_datadir}/sgml/%{name}/$catalog >/dev/null 2>&1 || :
done


%files
%defattr(-,root,root,-)
# Configs not "noreplace", they're incompatible to some extent between releases
%config %{_sysconfdir}/httpd/conf.d/%{name}.conf
%config %{_sysconfdir}/w3c/
%{_datadir}/%{name}/

%files libs
%defattr(-,root,root,-)
%ghost %config %{_sysconfdir}/sgml/%{name}-%{version}-%{release}.cat
%{_datadir}/sgml/%{name}/


%changelog
* Thu Feb  9 2006 Ville Skyttä <ville.skytta at iki.fi> - 0.7.2-1
- 0.7.2.

* Sat Oct  8 2005 Ville Skyttä <ville.skytta at iki.fi> - 0.7.1-1
- 0.7.1.

* Fri Sep 23 2005 Ville Skyttä <ville.skytta at iki.fi> - 0.7.0-1
- Update to 0.7.0.

* Thu Oct 14 2004 Ville Skyttä <ville.skytta at iki.fi> - 0:0.7.0-0.1.cvs
- Bring -libs post(un)install scriptlets up to date with sgml-lib/*.soc.

* Sun Oct 10 2004 Ville Skyttä <ville.skytta at iki.fi> - 0:0.7.0-0.cvs
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
