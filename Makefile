INSTALL_PATH ?= /usr/local/bin

.PHONY: build
build:
	swift build -c release

.PHONY: build-universal
build-universal:
	swift build -c release --arch arm64 --arch x86_64

.PHONY: build-homebrew
build-homebrew:
	swift build -c release --disable-sandbox

.PHONY: install
install:
	mkdir -p $(INSTALL_PATH)
	cp .build/release/apns $(INSTALL_PATH)/

.PHONY: uninstall
uninstall:
	rm $(INSTALL_PATH)/apns

.PHONY: clean
clean:
	swift package clean
