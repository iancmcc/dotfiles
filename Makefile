GO_VERSION=1.8.1
GVM=$(HOME)/.gvm/bin/gvm
GO=$(HOME)/.gvm/gos/go$(GO_VERSION)/bin/go

default: dotfiles $(HOME)/bin/hub $(HOME)/.vim/autoload/plug.vim $(HOME)/bin/jig

$(GVM):
	@echo "Installing gvm"
	@curl -s -S -L https://raw.githubusercontent.com/moovweb/gvm/master/binscripts/gvm-installer | bash

$(GO): $(GVM)
	@echo "Installing Go $(GO_VERSION)"
	@bash -c "source $(HOME)/.gvm/scripts/gvm && gvm install go$(GO_VERSION) --binary && gvm use go$(GO_VERSION) --default"

$(HOME)/bin/hub: $(GO)
	@echo "Installing hub"
	@GOPATH=$(HOME) $(GO) get github.com/github/hub

$(HOME)/bin/jig: $(GO)
	@echo "Installing jig"
	@GOPATH=$(HOME) $(GO) get github.com/iancmcc/jig

$(HOME)/.vim/autoload/plug.vim:
	@curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

dotfiles:
	@echo "Installing dotfiles"
	@for file in $(shell find $(CURDIR) -name ".*" -not -name ".gitignore" -not -name ".git"); do \
	   f=$$(basename $$file); \
           ln -sfn $$file $(HOME)/$$f; \
	 done
