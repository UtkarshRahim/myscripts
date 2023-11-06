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

pmsc(){
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

pmrc(){
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
