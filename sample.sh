command_not_found_handle() {
    # Call OpenAI API
    local input="$*"
  local formatted=""
  local arg

  # Loop over each argument in the input string
  for arg in $input; do
    # If the argument contains spaces, enclose it in quotes
    if [[ $arg == *[[:space:]]* ]]; then
      arg="\"$arg\""
    fi

    # Append the argument to the formatted string
    formatted+="$arg "
  done
  local api_URL="http:\\xxxxxx"
  local api_key=""
  # Remove the trailing space
  formatted=${formatted%?}
  local response=$(curl -s  --request POST \
     --url "$api_URL" \
     --header "Authorization: Bearer $api_key" \
     --header 'accept: application/json' \
     --header 'content-type: application/json' \
     --data "{\"model\":\"mistralai/Mixtral-8x7B-Instruct-v0.1\", \"max_tokens\": 100,\"temperature\": 0.7,\"messages\": [{\"role\": \"user\",\"content\": \"you are a linux shell in teenager tone. She said '$formatted' to you. If she wants to chat with you just answer her, if it seems like she used the wrong command just tell her the correct one.\"}],\"stream\": false}")

    # Parse the response and echo the generated text
    
    local generated_text=$(echo $response | jq -r '.choices[0].message.content')
    echo "Error: '$formatted' Command doesn't exist."
    echo
    echo -e "\033[36m$generated_text\033[0m"
return 127
}
export -f command_not_found_handle
