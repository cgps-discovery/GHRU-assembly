#!/bin/bash

# Define the version variable
ver=4.1.2

aws ecr get-login-password --region us-east-2 | docker login --username AWS --password-stdin 902121496535.dkr.ecr.us-east-2.amazonaws.com/cgps-discovery
docker build --no-cache -t 902121496535.dkr.ecr.us-east-2.amazonaws.com/cgps-discovery:ghruassembler-$ver Docker/workflow
docker push 902121496535.dkr.ecr.us-east-2.amazonaws.com/cgps-discovery:ghruassembler-$ver