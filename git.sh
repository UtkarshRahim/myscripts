pg() {
    git fetch && git pull
}

gc11() {
    git checkout release/1.1
}

gps() {
    branchName=$(git branch --show-current)
    commitMessage="$1"
    git add --all            # or git add -A (to add all changes)
    if [ -e "proxy.conf.json" ]; then
      git reset proxy.conf.json
    fi
    git commit -m "$commitMessage"
    git push origin "$branchName"

}

gcn() {
    branchName=$1
    git checkout -b $branchName
}

gpsd() {
    figlet $1
    dir=$(pwd)
    repo=$(basename $dir)
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
    result=$(pwd | grep -i "author")
    link=https://github.com/datanimbus/$repo/compare/version/2.7.7...Utcrash:$repo:def/$defectid?expand=1
    open $link
}

syncv() {
    echo "---------Fetching upstream---------"
    git fetch upstream
    git checkout version/2.7.7
    git merge upstream/version/2.7.7
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
    git checkout version/2.7.7
}

function gc() {
    branchName=$1
    git checkout origin/$branchName
}

