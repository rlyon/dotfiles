PREFIX ?= $(HOME)
MAKE_PATH ?= $(dir $(realpath $(firstword $(MAKEFILE_LIST))))

###############################################################################
### Install targets
###############################################################################
.PHONY: install
install: install-fonts install-prezto install-vim

.PHONY: install-fonts
install-fonts: ## Installs the powerline fonts
	ln -snf $(MAKE_PATH)fonts $(PREFIX)/fonts
	$(MAKE_PATH)fonts/install.sh

.PHONY: install-prezto
install-prezto: # Installs prezto and zsh configs
	ln -snf $(MAKE_PATH)prezto $(PREFIX)/.zprezto
	ln -snf $(MAKE_PATH)prezto/runcoms/zlogout $(PREFIX)/.zlogout
	ln -snf $(MAKE_PATH)prezto/runcoms/zprofile $(PREFIX)/.zprofile
	ln -snf $(MAKE_PATH)prezto/runcoms/zshenv $(PREFIX)/.zshenv
	ln -snf $(MAKE_PATH)prezto/runcoms/zshrc $(PREFIX)/.zshrc
	ln -snf $(MAKE_PATH)zsh/zlogin $(PREFIX)/.zlogin
	ln -snf $(MAKE_PATH)zsh/zpreztorc $(PREFIX)/.zpreztorc

.PHONY: install-vim
install-vim: # install vim and friends
	ln -snf $(MAKE_PATH)vim $(PREFIX)/.vim
	ln -snf $(MAKE_PATH)vim/vimrc $(PREFIX)/.vimrc
	sudo ln -snf $(MAKE_PATH)vim /root/.vim
	sudo ln -snf $(MAKE_PATH)vim/vimrc /root/.vimrc

###############################################################################
### Update targets
###############################################################################
.PHONY: update
update: update-pathogen update-submodules

.PHONY: update-pathogen
update-pathogen: # Updates the pathogen
	curl -LSso $(MAKE_PATH)vim/autoload/pathogen.vim https://tpo.pe/pathogen.vim

.PHONY: update-submodules
update-submodules:
	git submodule update --init --recursive
