export XDG_CONFIG_HOME=$HOME/.config

export GOPATH=~/go
export GOROOT=/usr/local/go
export GOBIN="$GOPATH/bin"

####### Alias & Function #######
godir () { cd "$GOPATH/src/$1" ; }
