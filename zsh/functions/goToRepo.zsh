goToRepo() {
  local pathToRepo="$1"
  local repoName="$2"
  local userGitName="$3"

  if [[ -z "$pathToRepo" ]]; then
    echo "path is empty"
    return 1
  fi

  if [[ ! -d "$pathToRepo" ]]; then
    echo "directory not found: $pathToRepo"
    return 1
  fi

  cd "$pathToRepo" || return 1

  # start ssh agent (if not running)
  if [[ -z "$SSH_AUTH_SOCK" ]]; then
    eval "$(ssh-agent -s)" >/dev/null
  fi

  # add default key (можно заменить на параметр)
  ssh-add ~/.ssh/id_ed25519 2>/dev/null

  # git remote setup (если задан repoName)
  if [[ -n "$repoName" ]]; then
    git remote remove origin 2>/dev/null
    git remote add origin "git@github.com:${userGitName}/${repoName}.git"
  fi
}