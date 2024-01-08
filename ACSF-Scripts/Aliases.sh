# Check if alias is already in .bashrc before adding
add_if_not_exists() {
    local alias_name="$1"
    local alias_command="$2"
    if ! grep -q "^alias $alias_name=" ~/.bashrc; then
        echo "alias $alias_name=\"$alias_command\"" >> ~/.bashrc
    else
        echo "Alias $alias_name already exists in .bashrc"
    fi
}

add_if_not_exists 'add-url' "bash '$ROOT_FOLDER'/'$ADD_URL_LIST'"
add_if_not_exists 'get-overview' "docker ps --filter 'ancestor=mikenye/youtube-dl'"
add_if_not_exists 'start-download' "bash '$ROOT_FOLDER'/'$AUTOMATED_CHECK'"
add_if_not_exists 'stop-download' "bash '$ROOT_FOLDER'/'$DOCKER_STOP'"
add_if_not_exists 'stop-all' "bash '$ROOT_FOLDER'/'$STOP'"
add_if_not_exists 'start-all' "bash '$ROOT_FOLDER'/'$START'"
add_if_not_exists 'yt-uninstall' "bash '$ROOT_FOLDER'/'$UNINSTALL'"
add_if_not_exists 'yt-update' "bash '$ROOT_FOLDER'/'$UPDATE'"
add_if_not_exists 'remove-all' "bash '$ROOT_FOLDER'/'$STOP_REMOVE'"
add_if_not_exists 'acs-usage' "bash '$ROOT_FOLDER'/'$USAGE'"
add_if_not_exists 'acs-convert' "bash '$ROOT_FOLDER'/'$CONVERT'"
add_if_not_exists 'single-download' "bash '$ROOT_FOLDER'/'$SINGLE_DOWNLOAD'"