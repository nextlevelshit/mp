#!/bin/bash

# Configuration variables
METHOD="PUT"
BASE_URL="https://localhost:8443"
API_URL="/api/order/a00ad9d9-fa7b-4989-a37c-5ef5051325fe/add-product/11521?count=4"
BEARER_TOKEN="b5739bfdb5267e51533de07dc3726aecfa8063fd5fe3d903bdef7d9f614cd99e5ee8fe227587edb29df6be2a2bf8849cd713d1e8a82b3ff2d27244a10deb849559d573e4662de0ad5844e32afbfed5f82b22d7cbd57a01b5fcc7ca251abf0bf2a5d2a050745d81f0c47a9358d58f0f9b44b66d8649f7e9f5df10b9a2fcce58bd"
NUM_JOBS=50
TOTAL_REQUESTS=100

# Create a temporary file to store results
RESULTS_FILE=$(mktemp)

# Create a function for the curl command
curl_command() {
    local id=$1
    local output=$(curl --request "${METHOD}" \
    --url "${BASE_URL}${API_URL}" \
    --header "Authorization: Bearer ${BEARER_TOKEN}" \
    --header 'content-type: application/json' \
    --header 'cache-control: no-cache' \
    --header 'pragma: no-cache' \
    --compressed \
    --insecure -s -o /dev/null -w "%{http_code} %{time_total}")

    local status_code=$(echo $output | cut -d' ' -f1)
    local time_total=$(echo $output | cut -d' ' -f2)

    # Convert time to milliseconds and round to 3 decimal places using awk
    local time_ms=$(awk -v time="$time_total" 'BEGIN {printf "%.3f", time * 1000}')

    echo "Request $id: Status Code: $status_code, Time: ${time_ms}ms"

    # Append results to the temporary file
    echo "$id $status_code $time_ms" >> "$RESULTS_FILE"
}

# Run the stress test using a bash loop
for i in $(seq 1 $TOTAL_REQUESTS); do
    curl_command $i &

    # Limit the number of background jobs
    if (( i % NUM_JOBS == 0 )); then
        wait
    fi
done

# Wait for any remaining background jobs
wait

echo "Stress test completed."

# Calculate and display statistics
echo "Calculating statistics..."

awk '
    BEGIN {total_requests = 0; total_time = 0; success_count = 0; min_time = 1e10; max_time = 0}
    {
        total_requests++;
        total_time += $3;
        if ($2 >= 200 && $2 < 300) success_count++;
        if ($3 < min_time) min_time = $3;
        if ($3 > max_time) max_time = $3;
    }
    END {
        printf "Overall Statistics:\n";
        printf "Total Requests: %d\n", total_requests;
        printf "Total Time: %.3fms\n", total_time;
        printf "Average Response Time: %.3fms\n", total_time / total_requests;
        printf "Success Rate: %.2f%%\n", (success_count / total_requests) * 100;
        printf "Fastest Response: %.3fms\n", min_time;
        printf "Slowest Response: %.3fms\n", max_time;
    }
' "$RESULTS_FILE"

# Clean up the temporary file
rm "$RESULTS_FILE"
