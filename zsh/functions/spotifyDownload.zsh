dwnSp() {
    local musicUrl="$1"

    if [ -z "$musicUrl" ]; then
        echo "No music URL provided"
        return 1
    fi

    cd ~/ArchData/prenivdlapp-cli || return 1
    node index.js -p ~/Music sp "$musicUrl"
}