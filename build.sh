#!/bin/bash
docker buildx build -t simcax/cockroach:v20.2.8 --platform=linux/arm64 .
