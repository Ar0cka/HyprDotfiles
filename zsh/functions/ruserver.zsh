scp_server_to_ru(){
    local targetObject="$1"
    local targetServerPath="$2"

    if [[ -z "$targetObject" ]]; then
        echo "Empty target object"
        return 1
    fi

    if [[ -z "$targetServerPath" ]]; then
        echo "Empty target server folder path"
        return 1
    fi

    scp -i ~/.ssh/ru_server_key "$targetObject" root@80.93.62.153:"$targetServerPath"
}