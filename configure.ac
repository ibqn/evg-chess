#                                               -*- Autoconf -*-
# Process this file with autoconf to produce a configure script.

AC_PREREQ([2.69])
AC_INIT([evg-chess], [0.1], [evgen.ibqn@gmail.com])
AM_INIT_AUTOMAKE([1.13 foreign no-dist-gzip dist-xz])

AC_CONFIG_MACRO_DIR([m4])
AC_CONFIG_SRCDIR([src/move.vala])
AC_CONFIG_HEADERS([config.h])

# API versioning
EVG_API_VERSION=1.0
EVG_API_MAJOR_VERSION=1

AC_SUBST([EVG_API_VERSION])
AC_SUBST([EVG_API_MAJOR_VERSION])
AC_SUBST([EVG_API_VERSION_U],[AS_TR_SH([$EVG_API_VERSION])])

# Gettext integration
IT_PROG_INTLTOOL(0.50)
AM_GNU_GETTEXT([external])
AM_GNU_GETTEXT_VERSION([0.18])
GETTEXT_PACKAGE=AC_PACKAGE_NAME
AC_SUBST([GETTEXT_PACKAGE])
AC_DEFINE_UNQUOTED(GETTEXT_PACKAGE, "$GETTEXT_PACKAGE", [The name of the gettext domain])

# Checks for programs.
AC_PROG_CC
AC_PROG_CC_STDC
AC_PROG_INSTALL
AM_PROG_VALAC([0.22])

# Checks for libraries.
PKG_PROG_PKG_CONFIG([0.22])

AC_PATH_PROG(GLIB_COMPILE_RESOURCES, glib-compile-resources)
# GLIB_GSETTINGS

LT_INIT([disable-static])

# Checks for modules.
pkg_modules="glib-2.0 >= 2.38 \
             gio-2.0 >= 2.38 \
             librsvg-2.0 \
             gtk+-3.0 >= 3.10"

PKG_CHECK_MODULES(EVG, [$pkg_modules])
# This variables are defined by pkg-config modules
# AC_SUBST(EVG_CFLAGS)
# AC_SUBST(EVG_LIBS)
# Checks for header files.

LIBEVG_LT_VERSION="1:0:0"
AC_SUBST(LIBEVG_LT_VERSION)

# Checks for modules.
pkg_modules="glib-2.0 >= 2.38 \
             gobject-2.0 >= 2.38"

PKG_CHECK_MODULES(LIBEVG, [$pkg_modules])

# Checks for typedefs, structures, and compiler characteristics.

# Checks for library functions.

AC_CONFIG_FILES([Makefile
                 po/Makefile.in
                 data/Makefile
                 src/Makefile
                 tests/Makefile])

AC_OUTPUT

echo "
 
configuration summary:
 
for package: ${PACKAGE}, Ver.: ${VERSION}

source code location:......... ${srcdir} 
compiler:..................... ${CC}
valac:........................ ${VALAC}
vapigen:...................... ${VAPIGEN}
prefix:....................... ${prefix}
compiler flags:............... ${CFLAGS}
compiler pre-processor flags:. ${CPPFLAGS}
"
