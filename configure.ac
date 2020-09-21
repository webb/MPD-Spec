# Process this file with autoconf to produce a configure script.

AC_PREREQ([2.69])
AC_INIT([NIEM MPD Specification],[0],[wr@gatech.edu],[niem-mpd-spec],[wr@gatech.edu])
AC_CONFIG_SRCDIR([Makefile.in])

dnl WR_check_prog( $command-name )
dnl   e.g., WR_check_prog(bash) will set @bash@
AC_DEFUN([WR_check_prog],[AC_PATH_PROG($1,$1)
  test "x$[]$1" = "x" && AC_MSG_ERROR([$1 not found])])dnl

dnl WR_check_prog_options( $command-short-name, $command-name-options ... )
dnl   e.g., WR_check_prog_options(cat, gcat cat) will set @cat@
AC_DEFUN([WR_check_prog_options],[AC_PATH_PROGS($1,$2)
  test "x$[]$1" = "x" && AC_MSG_ERROR([$1 not found])])dnl

# Checks for programs.
AC_PROG_INSTALL
AC_PROG_MKDIR_P
AC_PROG_SED
# unix stuff
WR_check_prog(aspell)
WR_check_prog_options(base64,gbase64 base64)
WR_check_prog(bash)
WR_check_prog_options(cat,gcat cat)
WR_check_prog_options(fgrep,gfgrep fgrep)
WR_check_prog_options(find,gfind find)
WR_check_prog(identify) # from ImageMagick
WR_check_prog_options(m4,gm4 m4)
WR_check_prog_options(make,gmake make)
WR_check_prog_options(sort,gsort sort)
WR_check_prog(xmllint)

# webb stuff
WR_check_prog_options(process_doc,process-doc)
WR_check_prog_options(xs_validate,xs-validate)

# write files
AC_CONFIG_FILES([Makefile], [chmod 444 Makefile])
AC_CONFIG_FILES([run], [chmod 555 run])
AC_SUBST([config_files],$ac_config_files)
AC_OUTPUT
