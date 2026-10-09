rider(){
    local repoName="$1"
    if [[ -z "$repoName" ]]; then
    echo "path is empty"
    return 1
    fi

    nohup ~/.local/share/JetBrains/Toolbox/apps/rider/bin/rider &
    goToRepo ~/"$repoName" "$repoName" Ar0cka
}