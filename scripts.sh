npmIAll() {
  for file in *; do
    echo "$file"
    cd "./$file"
    npm i
    cd ..
  done
}

df() {
  cd ~/work/cloud
  node index.js $1 $2
}

startfe() {
  cd ~/work/data-nimbus/deploy
  ./runfe.sh
}

startbe() {
  cd ~/work/data-nimbus/deploy
  ./runbe.sh
}

yo() {
  yai "$@"
}

rsh(){
  exec zsh
}
