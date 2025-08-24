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
        git add --all # or git add -A (to add all changes)
        if [ -e "proxy.conf.json" ]; then
            git reset proxy.conf.json
        fi
        git commit -m "$commitMessage"
        git push origin "$branchName"
        link1=https://bitbucket.org/appveen/$repo/pull-requests/new
        open $link1
    fi
}

gpsm() {
    dir=$(pwd)
    repo=$(basename $dir)
    branchName=$(git branch --show-current)
    commitMessage="$1"
    git add --all # or git add -A (to add all changes)
    if [ -e "proxy.conf.json" ]; then
        git reset proxy.conf.json
    fi
    git commit -m "$commitMessage"
    git push origin "$branchName"
    link1=https://bitbucket.org/appveen/$repo/pull-requests/new
    open $link1
}

gn() {
    branchName=$1
    git checkout -b $branchName
}

gpsd() {
    figlet $1
    commmitMessage="Defect "$1" fixed"
    echo "************* Commiting the code and pushing it *************"
    echo $commmitMessage
    gps $commmitMessage
}

gpdm() {
    figlet $1
    commmitMessage=$1" fixed"
    echo "************* Commiting the code and pushing it *************"
    echo $commmitMessage
    gpsm $commmitMessage
}

syncv() {
    echo "---------Fetching upstream---------"
    # git fetch upstream
    git checkout $CURR_RELEASE
    git merge upstream/$CURR_RELEASE
    echo "---------Sync complete---------"
}

syncfork() {
    echo "---------Fetching upstream---------"
    # git fetch upstream
    git checkout main
    git merge upstream/main
    echo "---------Sync complete---------"
}

syncforkb() {
    branch=$1
    echo "---------Fetching upstream---------"
    # git fetch upstream
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

fixed() {
    defectid=$1
    curl -X POST \
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

rfqa() {
    defectid=$1
    curl -X POST \
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

gch() {
    branchName=$1
    git checkout $branchName
}

cpr() {
    repo=$(basename $(git rev-parse --show-toplevel))
    gh pr -R datanimbus/$repo list
}
