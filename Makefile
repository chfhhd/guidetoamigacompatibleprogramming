SOURCES     = CAP_0.md CAP_1.md CAP_2.md CAP_3.md CAP_4.md CAP_5.md CAP_6.md X_APP_B.md
BUILDNAME   = guidetoamigacompatibleprogramming
MDPROCESSOR = pandoc
MDFLAGS     = --highlight-style tango -s
PREFIX      = ./build/

all: html

html: $(SOURCES)
	$(MDPROCESSOR) $(MDFLAGS) $(SOURCES) > $(PREFIX)$(BUILDNAME).$@

clean:
	rm -f $(PREFIX)$(BUILDNAME)*