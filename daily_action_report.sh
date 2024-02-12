#!/bin/bash

config_filename="config"
description_filename="descriptions.txt"

get_input() {
    read -p "$1: " input
    echo "$input"
}

generate_config() {
    echo "Generating config file..."

    echo "project_token=$project_token" >"$config_filename"
    echo "project_id=$project_id" >>"$config_filename"
    echo "gitlab_url=$gitlab_url" >>"$config_filename"
    echo "to=$to" >>"$config_filename"
    echo "cc=$cc" >>"$config_filename"
    echo "introductory_statement=$introductory_statement" >>"$config_filename"

    echo "Config file generated successfully! ($config_filename)"
}

if [ -f "$config_filename" ]; then
    source "$config_filename"
else
    project_token=$(get_input "Enter Project Token")
    project_id=$(get_input "Enter Project ID")
    gitlab_url=$(get_input "Enter GitLab URL")
    to=$(get_input "Enter 'To' email address")
    cc=$(get_input "Enter 'CC' email address")
    intro_statement=$(get_input "Enter Introductory Statement")
    introductory_statement="\"$intro_statement\""
    generate_config
fi

clear_file() {
    >"$description_filename"
}

add_initial_greeting() {
    echo "Hi, $to " >>"$description_filename"
    echo "" >>"$description_filename"
    introductory_statement=${introductory_statement//\"/}
    echo "$introductory_statement" >>"$description_filename"
    echo "" >>"$description_filename"
}
send_report() {
    config_filename="config"
    description_filename="descriptions.txt"

    gitlab_api_url="$gitlab_url/api/v4/projects/$project_id/issues"

    issue_data=$(cat "$description_filename")

    curl -s -X POST --header "PRIVATE-TOKEN: $project_token" \
        --data-urlencode "title=Daily Development Report - $title_date" \
        --data-urlencode "description=$issue_data" \
        "$gitlab_api_url"

    echo "Issue created successfully!"

}

add_description() {

    config_file="config"

    read -p "Enter the report date in MM/DD/YYYY (press Enter for today's date): " input_date

    if [ -z "$input_date" ]; then
        input_date=$(date +'%m/%d/%Y')
    fi

    if grep -q '^title_date=' "$config_file"; then
        sed -i "s|^title_date=.*|title_date=$input_date|" "$config_file"
    else
        echo "title_date=$input_date" >>"$config_file"
    fi

    echo "Daily Development Report: $input_date"
    echo "" >>"$description_filename"

    echo "Enter your description (press Enter to save and create a new line, type 'exit' to finish):"
    while read -r input; do
        if [ "$input" = "exit" ]; then
            break
        elif [ "$input" = "send" ]; then
         echo "" >>"$description_filename"
         echo "cc: $cc" >>"$description_filename"
            send_report
            break
        else
            echo "* [x] $input" >>"$description_filename"
        fi
    done
   
}

clear_file

add_initial_greeting

add_description

echo "Descriptions have been saved to $description_filename."
