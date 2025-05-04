#!/bin/bash

urls=(
    "https://httpbin.org/status/100"
    "https://httpbin.org/status/200"
    "https://httpbin.org/status/300"
    "https://httpbin.org/status/400"
    "https://httpbin.org/status/500"
)

send_request() {
    url=$1
    echo "Sending request to: $url"

    response=$(curl -s -w "HTTPSTATUS:%{http_code}" "$url")
    body=$(echo "$response" | sed -e 's/HTTPSTATUS\:.*//g')
    status_code=$(echo "$response" | tr -d '\n' | sed -e 's/.*HTTPSTATUS://')

    echo "Status code: $status_code"
    echo "Body: $body"

    if [ "$status_code" -lt 400 ]; then
        echo "URL: $url, Status: $status_code, Body: $body"
    else
        echo "ERROR: Request fail, status code $status_code for $url"
    fi
}

for url in "${urls[@]}"; do
    send_request "$url"
done
