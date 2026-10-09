pintestBoard(){
    clear
    cd ArchData/prenivdlapp-cli
    git pull origin main
    npm install

    local pintrestPath="$1"

    if ([ -z "$pintrestPath" ]); then
        echo "path is empty"
        return 1
    fi

    node index.js -p /home/arocka/ArchData/PintrestSource pinterest $pintrestPath
}