#!/bin/bash

GREEN="\033[32m"
DARK_GREEN="\033[1;32m"
RESET="\033[0m"

REPO_DIR="$(pwd)"
echo "Processing: $REPO_DIR"

json_file="${1:-$(pwd)/helper-scripts/repos.json}"

if [[ ! -f "$json_file" ]]; then
  echo "Error: JSON file ($json_file) not found!"
  exit 1
fi

declare -A repos

# JSON to associative array
while IFS="=" read -r key value; do
  repos["$key"]="$value"
done < <(jq -r '.repos | to_entries[] | "\(.key)=\(.value)"' "$json_file")

clone() {
    repo_name=$1
    git_file=$2
    echo -e "${GREEN}------------------------------------------${RESET}"
    echo -e "${DARK_GREEN}Cloning: $repo_name${RESET}"
    git clone --bare $repo_name $git_file
    echo -e "${GREEN}------------------------------------------${RESET}"
}
removeExistRepo() {
    REPO_PATH=$1
    if [ -d "$REPO_PATH" ]; then
      rm -rf "$REPO_PATH"
      echo "'$REPO_PATH' removed."
    fi
}

push() {
    MIRROR_URL=$1
    echo "Pushing mirror to $MIRROR_URL"
    git push --mirror "$MIRROR_URL"
    echo -e "${DARK_GREEN}Completed for ${MIRROR_URL}${RESET}"
    echo -e "${GREEN}------------------------------------------${RESET}"
}

# Mirroring
for repo_name in "${!repos[@]}"; do
    GIT_FILE="${repo_name##*/}"
    REPO_PATH="$REPO_DIR/$GIT_FILE"
    MIRROR_URL="${repos[$repo_name]}"

    removeExistRepo $REPO_PATH
    clone $repo_name $GIT_FILE
    cd "$GIT_FILE" || continue
    push $MIRROR_URL
    cd ..
done

echo "All repositories processed."
