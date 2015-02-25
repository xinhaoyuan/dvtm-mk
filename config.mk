# dvtm version
VERSION = 0.14

# Customize below to fit your system

PREFIX ?= /usr/local
MANPREFIX = ${PREFIX}/share/man
# specify your systems terminfo directory
# leave empty to install into your home folder
TERMINFO := ${DESTDIR}${PREFIX}/share/terminfo

INCS = -I.
LIBS = -lc -lutil -lncursesw -ltermkey
CPPFLAGS = -D_POSIX_C_SOURCE=200809L -D_XOPEN_SOURCE=700 -D_XOPEN_SOURCE_EXTENDED
CFLAGS += -std=c99 ${INCS} -DVERSION=\"${VERSION}\" -DNDEBUG ${CPPFLAGS}
LDFLAGS += ${LIBS}

ifeq ($(shell uname),Darwin)
LIBS = -lc -lutil -lncurses -ltermkey
CPPFLAGS += -D_DARWIN_C_SOURCE
else
LIBS = -lc -lutil -lncursesw -ltermkey
endif

DEBUG_CFLAGS = ${CFLAGS} -UNDEBUG -O0 -g -ggdb -Wall -Wextra -Wno-unused-parameter

CC ?= cc
STRIP ?= strip
