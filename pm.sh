alias pmls="pm2 list"
alias pmsa="pm2 stop all"
alias pmm="pm2 monit"
alias pmda="pm2 delete all"
alias pmra="pm2 restart all"

pml() {
    if [ -n "$2"]; then
        pm2 logs $1
    else
        echo "Lines "$2
        pm2 logs $1 --lines $2
    fi
}

pmr() {
    for process in "$@"; do
        pm2 restart "$process" >/dev/null
    done
    pmls
}

pms() {
    for process in "$@"; do
        pm2 stop "$process" >/dev/null
    done
    pmls
}

pmsc() {
    dir=$(pwd)
    repo=$(basename $dir)
    id=$(pm2 list | grep $repo | awk '{print $2}')
    count=$(echo "$id" | wc -l)
    if [ "$count" -eq 1 ]; then
        pm2 stop $id
    else
        echo "Check current branch and retry"
    fi
}

pmrc() {
    dir=$(pwd)
    repo=$(basename $dir)
    id=$(pm2 list | grep $repo | awk '{print $2}')
    count=$(echo "$id" | wc -l)
    if [ "$count" -eq 1 ]; then
        pm2 restart $id
    else
        echo "Check current branch and retry"
    fi
}
