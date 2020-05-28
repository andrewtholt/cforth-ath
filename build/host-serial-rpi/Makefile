# Builds a Linux host Forth application with serial port tools

TOPDIR=../..

CONFIG += -DBITS32 -DT16

ifneq "$(findstring 86,$(shell uname -m))" ""
CONFIG += -m32
endif

FTDI = n
ifeq ($(FTDI),y)
INCS += $(shell pkg-config --cflags libusb-1.0)
LIBS += $(shell pkg-config --libs libusb-1.0) 
endif
LIBS += -lm -ldl

include $(TOPDIR)/src/app/host-serial-rpi/targets.mk
