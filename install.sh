#!/usr/bin/env bash

USERNAME=$(find /home/* -maxdepth 0 -printf "%f" -type d)
export DEBIAN_FRONTEND=noninteractive

packages() {
sudo bash <<EOF
    apt-get update
    apt-get -y upgrade
    apt-get -y install  \
        bash-completion \
        bridge-utils    \
        bc              \
        coreutils       \
        curl            \
        build-essential \
        file            \
        lsof            \
        ssh             \
        unzip           \
        python-dev      \
        vim             \
        htop            \
        git             \
        tree            \
        jq              \
        i3              \
        stow            \
        ccrypt          \
        feh             \
        i3lock          \
        i3status        \
        scrot           \
        slim            \
        ack-grep        \
        --no-install-recommends

    curl -sSL https://raw.githubusercontent.com/jfrazelle/dotfiles/master/etc/fonts/local.conf > /etc/fonts/local.conf
EOF
}

setup_sudo() {
sudo bash <<EOF
    adduser "$USERNAME" sudo
    gpasswd -a  "$USERNAME" systemd-journal
    gpasswd -a  "$USERNAME" systemd-network
    { \
        echo -e 'Defaults   secure_path="/usr/local/go/bin:/home/ian/.go/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin"'; \
        echo -e 'Defaults   env_keep += "ftp_proxy http_proxy https_proxy no_proxy GOPATH EDITOR"'; \
        echo -e "${USERNAME} ALL=(ALL) NOPASSWD:ALL"; \
        echo -e "${USERNAME} ALL=NOPASSWD: /bin/mount, /sbin/mount.nfs, /bin/umount, /sbin/umount.nfs /sbin/ifconfig, /sbin/ifup, /sbin/ifdown, /sbin/ifquery" ; \
    } >> /etc/sudoers
EOF
}

install_golang() {
    export GO_VERSION=1.4.2 export GO_SRC=/usr/local/go

    # if we are passing the version
    if [[ ! -z "$1" ]]; then
        export GO_VERSION=$1
    fi

    # purge old src
    if [[ -d "$GO_SRC" ]]; then
        sudo rm -rf "$GO_SRC"
    fi

    (
    curl -sSL "https://storage.googleapis.com/golang/go${GO_VERSION}.linux-amd64.tar.gz" | sudo tar -v -C /usr/local -xz
    )
}

install_dotfiles() {
    for file in $(find ${PWD} -name ".*" -not -name ".gitignore" -not -name ".git" -not -name ".*.swp"); do \
        f=$(basename $file); \
	echo $f; \
        ln -sf ${PWD}/$f ${HOME}/$f; \
    done
}

#packages
#setup_sudo
install_dotfiles
#install_golang
