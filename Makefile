run: clean bkweb
	./bkweb -hostOverride=www.brianketelsen.com
 
include $(GOROOT)/src/Make.inc

TARG=bkweb
GOFILES=\
    bkweb.go\


include $(GOROOT)/src/Make.cmd
