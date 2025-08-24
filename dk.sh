# Docker and K8s
alias d='docker'
alias dims='docker image ls'
alias dim='docker image'
alias dcons='docker container ls -a'
alias dcon='docker container'
alias dip='docker inspect -f "{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}"'
alias dclean='docker container rm $(docker container ls -a -q -f status=exited) ; docker image rm $(docker images -f dangling=true -q)'
alias k='kubectl'
alias kp='kubectl get pods'
alias kdp='kubectl delete pod'
alias ks='kubectl get services'
alias kds='kubectl delete service'

function kk(){
  NS="--all-namespaces"
  if ! [ -z $1 ]
  then
    NS="-n $1"
    echo "NAMESPACE : "$1
  else
    NS="--all-namespaces"
    echo "-------- NAMESPACES --------"
    kubectl get namespaces
  fi
  echo "-------- SERVICES ----------"
  kubectl get services $NS
  echo "-------- DEPLOYMENT --------"
  kubectl get deployments $NS
  echo "-------- PODS --------------"
  kubectl get pods $NS
  if ! [ -z $1 ]
  then
    echo "-------- SECRET --------------"
    kubectl get secret $NS
    echo "-------- CONFIG --------------"
    kubectl get cm $NS
  fi
}

kr() {
  kubectl scale deploy --replicas=0 $1 -n $2
  sleep 0.5
  kubectl scale deploy --replicas=1 $1 -n $2
}

function kl(){
  if ! [ -z $3 ]
  then
    kubectl logs -f -n $2 $(kubectl get pods -n $2 | grep $(kubectl describe deploy $1 -n $2 | grep NewReplicaSet: | awk '{print $2}') | awk '{if ($3 == "Running") {print $1}}') --tail=$3
  else
    kubectl logs -f -n $2 $(kubectl get pods -n $2 | grep $(kubectl describe deploy $1 -n $2 | grep NewReplicaSet: | awk '{print $2}') | awk '{if ($3 == "Running") {print $1}}')
  fi
}

function kx(){
  kubectl exec -ti -n $2 $(kubectl get pods -n $2 | grep $(kubectl describe deploy $1 -n $2 | grep NewReplicaSet: | awk '{print $2}') | awk '{if ($3 == "Running") {print $1}}') -- sh
}

function kes(){
  kubectl edit service $1 -n $2
}

function ked(){
  kubectl edit deploy $1 -n $2
}

function ksd(){
  kubectl scale deploy $1 -n $2 --replicas=$3
}
