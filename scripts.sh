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

rsh() {
    exec zsh
}

nats() {
    docker rm -f nats
    # docker run --restart unless-stopped -d --name nats -p 6222:6222 -p 4222:4222 -p 8222:8222 nats
    docker run --restart unless-stopped --name stan -v ~/Workspace/nats_store/store:/store -d -p 4222:4222 -p 8222:8222 nats-streaming:0.11.2 -cid datastack-cluster -m 8222 --store FILE --dir /store -D
}

edis() {
    docker rm -f redis
    docker run --restart unless-stopped -d --name redis -p 6379:6379 redis:alpine
}

runmongo() {
    docker container rm mongo
    docker run -itd -p 27017:27017 -v ~/mongo/db/:/data/db --restart unless-stopped --name mongo mongo mongod
}

runbe8() {
    pm2 stop all
    pm2 delete all
    cd /Users/utkarsh/work/data-nimbus/v28/dnio-dev-utils/scripts
    /Users/utkarsh/work/data-nimbus/v28/dnio-dev-utils/scripts/./pm2-local.sh
}
runbe9() {
    pm2 stop all
    pm2 delete all
    cd /Users/utkarsh/work/data-nimbus/v29/dnio-dev-utils/scripts
    /Users/utkarsh/work/data-nimbus/v29/dnio-dev-utils/scripts/./pm2-local.sh
}

runbe() {
    pm2 stop all
    pm2 delete all
    cd /Users/utkarsh/work/data-nimbus/main/dnio-dev-utils/scripts
    /Users/utkarsh/work/data-nimbus/main/dnio-dev-utils/scripts/./pm2-local.sh
}

gti() {
    REPO_NAME="datanimbus.io.$1"
    if [ -z $1]; then
        echo "What repo ? Pass it as an argument no. Jesus, you created this method and even you're making this error."
    else
        IMAGE_DETAILS=$(aws ecr describe-images --repository-name "$REPO_NAME" --query "reverse(sort_by(imageDetails, &imagePushedAt))[:3].{ImageTag:imageTags, PushedAt:imagePushedAt}" --output json)
        echo "$IMAGE_DETAILS"
    fi
}

auths() {
    node /Users/utkarsh/cli-auth-2fa/app.js
}


#!/usr/bin/env bash

#!/usr/bin/env bash

#!/usr/bin/env bash

#!/usr/bin/env bash

ROOT_DIR="/Users/utkarsh/work/data-nimbus"

dev() {
  local file branch project_dir

  # Only search inside main, v28, v29 → prune unwanted dirs
  file=$(find "$ROOT_DIR"/{main,v28,v29} \
    -type d \( -name node_modules -o -name .git -o -name dist -o -name coverage -o -name .cache \) -prune -false -o \
    -type f \
    2>/dev/null | fzf \
      --preview 'cat {}' \
      --preview-window=down:40%:wrap \
      --prompt='dev > ')

  [[ -z "$file" ]] && return

  # Extract branch (main/v28/v29)
  branch=$(echo "$file" | awk -F'/' -v root="$ROOT_DIR" '{print $(NF-2)}')

  # Extract project directory (dnio-…)
  project_dir=$(echo "$file" | awk -F'/' -v root="$ROOT_DIR" '{print $(NF-1)}')

  if [[ -n "$branch" && -n "$project_dir" ]]; then
    cd "$ROOT_DIR/$branch/$project_dir" || return
    zoxide add "$ROOT_DIR/$branch/$project_dir"
    echo "➡ Entered $ROOT_DIR/$branch/$project_dir"
  fi
}
