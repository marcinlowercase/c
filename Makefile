WLR_PKG ?= wlroots-0.20

CFLAGS ?= -g -O2 -Wall -Wextra
CFLAGS += -DWLR_USE_UNSTABLE
CFLAGS += $(shell pkg-config --cflags $(WLR_PKG) wayland-server xkbcommon)
LIBS = $(shell pkg-config --libs $(WLR_PKG) wayland-server xkbcommon)

c: c.c
	$(CC) $(CFLAGS) -o $@ $< $(LIBS)

clean:
	rm -f c

.PHONY: clean
