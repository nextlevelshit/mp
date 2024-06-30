#!/bin/bash

# Function to run a single curl command
run_curl() {
    curl --request PUT \
        --url http://localhost:5555/api/order/a00ad9d9-fa7b-4989-a37c-5ef5051325fe/generate-delivery-note \
        --header 'Authorization: Bearer b5739bfdb5267e51533de07dc3726aecfa8063fd5fe3d903bdef7d9f614cd99e5ee8fe227587edb29df6be2a2bf8849cd713d1e8a82b3ff2d27244a10deb849559d573e4662de0ad5844e32afbfed5f82b22d7cbd57a01b5fcc7ca251abf0bf2a5d2a050745d81f0c47a9358d58f0f9b44b66d8649f7e9f5df10b9a2fcce58bd' \
        --header 'content-type: application/json' \
        --header 'cache-control: no-cache' \
        --header 'pragma: no-cache' \
        --compressed \
        --output /dev/null \
        --insecure -s -o /dev/null -w '%{time_total}s\n'
}

# Number of parallel jobs to run
NUM_JOBS=5

# Number of requests per job
NUM_REQUESTS=100

# Function to run a batch of requests
run_batch() {
    for i in $(seq 1 $NUM_REQUESTS); do
        run_curl
    done
}

# Run the stress test using background jobs
for i in $(seq 1 $NUM_JOBS); do
    run_batch &
done

# Wait for all background jobs to finish
wait

echo "Stress test completed."
