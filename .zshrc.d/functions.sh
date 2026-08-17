# yazi wrapper
y() {
	local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
	yazi "$@" --cwd-file="$tmp"
	IFS= read -r -d '' cwd < "$tmp"
	[ -n "$cwd" ] && [ "$cwd" != "$PWD" ] && builtin cd -- "$cwd"
	rm -f -- "$tmp"
}

run(){
    if [ "$1" = "--help" ] || [ "$1" = "-h" ] || [ -z "$1" ]; then
        echo "USAGE: run app1 app2 app3 <...>"
        return 0
    fi
    local appname
    for appname in "$@"; do
        nohup "$appname" &> /dev/null &
    done
}

publicip(){
    curl -s ifconfig.me
}

localip(){
    ip -o addr show wlo1 | grep -Po --color=never 'inet \K[\d.]+'
}

localnet(){
    localip=$(localip)
    echo "${localip%.*}"
}

dg(){
    ip route | grep --color=never -Po 'default via \K[\d.]+'
}

bak(){
    local item
    for item in "$@"; do
        mv "$item" "$item".bak
    done
}

unbak(){
    local item
    for item in "$@"; do
        mv "$item" "${item%.bak}"
    done
}
