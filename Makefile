# Installation directory - can be overridden via environment or command line
DESTDIR ?=
PREFIX ?= /usr
INSTALL_DIR = $(DESTDIR)$(PREFIX)/bin

# Scripts source directory
SCRIPTS_DIR = scripts

# Installation command with proper permissions
INSTALL = install
INSTALL_PROGRAM = $(INSTALL) -m 0755
INSTALL_DIR_CMD = $(INSTALL) -d -m 0755

# Find all scripts in the scripts directory
SCRIPTS = $(wildcard $(SCRIPTS_DIR)/*)

.PHONY: all install clean

all: install

install:
	$(INSTALL_DIR_CMD) $(INSTALL_DIR)
	@for script in $(SCRIPTS); do \
		if [ -f "$$script" ]; then \
			echo "Installing $$script to $(INSTALL_DIR)"; \
			$(INSTALL_PROGRAM) "$$script" $(INSTALL_DIR)/; \
		fi \
	done

clean:
	@echo "Nothing to clean."

# Help target
help:
	@echo "Usage:"
	@echo "  make install              - Install scripts to $(INSTALL_DIR)"
	@echo "  make install DESTDIR=/tmp - Install to /tmp$(PREFIX)/bin"
	@echo "  make install PREFIX=/opt  - Install to /opt/bin"
	@echo ""
	@echo "Yocto usage:"
	@echo "  oe_runmake install        - Uses DESTDIR and other Yocto variables"
