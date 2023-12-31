pg() {
    git fetch && git pull
}

gc11() {
    git checkout release/1.1
}

gps() {
    dir=$(pwd)
    repo=$(basename $dir)
    branchName=$(git branch --show-current)
    commitMessage="$1"
    if [ "$branchName" = "$CURR_RELEASE" ]; then
        echo "Change branch and proceed"
    else
        git add --all            # or git add -A (to add all changes)
        if [ -e "proxy.conf.json" ]; then
         git reset proxy.conf.json
        fi
        git commit -m "$commitMessage"
        git push origin "$branchName"
        link1=https://github.com/datanimbus/$repo/compare/$CURR_RELEASE...Utcrash:$repo:$branchName?expand=1
        open $link1
    fi
}

gcn() {
    branchName=$1
    git checkout -b $branchName
}

gpsd() {
    figlet $1
    dir=$(pwd)
    defectid=$1
    echo "************* Creating new branch *************"
    gcn "def/$defectid"
    commmitMessage="Defect "$1" fixed"
    echo "************* Commiting the code and pushing it *************"
    echo $commmitMessage
    gps $commmitMessage
    # echo "************* Changing status to Fixed *************"
    # df Fixed $1
    cd $dir
    figlet "Raise PR"
    fixed $defectid
    result=$(pwd | grep -i "author")
    link2=https://appveen.atlassian.net/browse/$defectid
    open $link2
}

syncv() {
    echo "---------Fetching upstream---------"
    git fetch upstream
    git checkout $CURR_RELEASE
    git merge upstream/$CURR_RELEASE
    echo "---------Sync complete---------"
}

syncfork() {
    echo "---------Fetching upstream---------"
    git fetch upstream
    git checkout main
    git merge upstream/main
    echo "---------Sync complete---------"
}

syncforkb() {
    branch=$1
    echo "---------Fetching upstream---------"
    git fetch upstream
    git checkout $branch
    git merge upstream/$branch
    echo "---------Sycn complete---------"
}

gcmain() {
    git checkout main
}

gcv() {
    git checkout $CURR_RELEASE
}

fixed(){
    defectid=$1
    curl  -X POST \
  'https://appveen.atlassian.net/rest/api/3/issue/'$defectid'/transitions' \
  --header 'Accept: */*' \
  --header 'Authorization: Basic dXRrYXJzaEBkYXRhbmltYnVzLmNvbTpBVEFUVDN4RmZHRjBzaklERTJ2YjJmUjZLVGZFYko2THNmVjBscXpyU0JibHR3UzRjak1rWE1BY0x4VEtRWGNKdWg5MVBnWlhsTmNvSHkyNUdKWXN5SEtNc24ySFBsaG05RXk0MEhFSU8tVVgxVXEwbTFnZ1BuWWJDTFBLazhoSVE3THRwMjR5Uk40WGtHaXBKVGNSWmpWX2QwRVprckNmdDZZUU04WGZsUmNtVWw5bjBVelZGOG89QkEyNTlCOTk=' \
  --header 'Content-Type: application/json' \
  --data-raw '{
  "transition": {
    "id": "31"
  }
}'
}

rfqa(){
    defectid=$1
    curl  -X POST \
  'https://appveen.atlassian.net/rest/api/3/issue/'$defectid'/transitions' \
  --header 'Accept: */*' \
  --header 'Authorization: Basic dXRrYXJzaEBkYXRhbmltYnVzLmNvbTpBVEFUVDN4RmZHRjBzaklERTJ2YjJmUjZLVGZFYko2THNmVjBscXpyU0JibHR3UzRjak1rWE1BY0x4VEtRWGNKdWg5MVBnWlhsTmNvSHkyNUdKWXN5SEtNc24ySFBsaG05RXk0MEhFSU8tVVgxVXEwbTFnZ1BuWWJDTFBLazhoSVE3THRwMjR5Uk40WGtHaXBKVGNSWmpWX2QwRVprckNmdDZZUU04WGZsUmNtVWw5bjBVelZGOG89QkEyNTlCOTk=' \
  --header 'Content-Type: application/json' \
  --data-raw '{
  "transition": {
    "id": "3"
  }
}'
}

function gc() {
    branchName=$1
    git checkout origin/$branchName
}

