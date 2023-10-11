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
    pm2 restart $1
}

pms() {
    pm2 stop $1
}
