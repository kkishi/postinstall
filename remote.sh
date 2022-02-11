#!/bin/bash

set -ex

pip3 install --user online-judge-tools

git_clone() {
  git_cloned="no"
  if ! [[ -d $(basename "$1" .git) ]]; then
    GIT_SSH_COMMAND="ssh -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no" git clone --recurse-submodules $1
    git_cloned="yes"
  fi
}

git_clone git@github.com:kkishi/dotfiles.git
./dotfiles/link.sh

! [[ -f .dircolors ]] && wget https://raw.githubusercontent.com/seebi/dircolors-solarized/master/dircolors.256dark -O .dircolors

mkdir -p projects
cd projects

for name in atcoder codeforces yukicoder aoj; do
  git_clone git@github.com:kkishi/$name.git
  if [[ $git_cloned = "yes" ]]; then
    cd $name
    direnv allow
    /usr/local/go/bin/go install github.com/kkishi/$name/cmd/...
    cd ../
  fi
done

git_clone git@github.com:kkishi/pcstd.git
if [[ $git_cloned = "yes" ]]; then
  cd pcstd
  ./init.sh
  cd ../
fi

git_clone  git@github.com:atcoder/ac-library.git

cd ../

/usr/local/go/bin/go install golang.org/x/tools/gopls@latest
