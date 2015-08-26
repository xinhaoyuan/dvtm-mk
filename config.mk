# dvtm version
VERSION = 0.14

# Customize below to fit your system

PREFIX ?= /usr/local
MANPREFIX = ${PREFIX}/share/man
# specify your systems terminfo directory
# leave empty to install into your home folder
TERMINFO := ${DESTDIR}${PREFIX}/share/terminfo

ifeq ($(shell uname),Darwin)
NCURSES_NAME    := ncurses
else
NCURSES_NAME    := ncursesw
endif
NCURSES_LDFLAGS := $(shell if command -v pkg-config 1>/dev/null 2>&1; then pkg-config --libs ${NCURSES_NAME}; else echo -l${NCURSES_NAME}; fi)
NCURSES_CFLAGS  := $(shell if command -v pkg-config 1>/dev/null 2>&1; then pkg-config --cflags ${NCURSES_NAME}; else echo; fi)

TERMKEY_LDFLAGS := $(shell if command -v pkg-config 1>/dev/null 2>&1; then pkg-config --libs termkey; else echo -ltermkey; fi)

INCS = -I.
LIBS = -lc -lutil ${TERMKEY_LDFLAGS} ${NCURSES_LDFLAGS} 
CPPFLAGS = -D_POSIX_C_SOURCE=200809L -D_XOPEN_SOURCE=700 -D_XOPEN_SOURCE_EXTENDED
CFLAGS += -std=c99 ${INCS} -DVERSION=\"${VERSION}\" -DNDEBUG ${CPPFLAGS} ${NCURSES_CFLAGS}
LDFLAGS += ${LIBS}

ifeq ($(shell uname),Darwin)
CPPFLAGS += -D_DARWIN_C_SOURCE
endif

DEBUG_CFLAGS = ${CFLAGS} -UNDEBUG -O0 -g -ggdb -Wall -Wextra -Wno-unused-parameter

CC ?= cc
STRIP ?= strip
