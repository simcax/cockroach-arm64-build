#!/bin/bash
docker buildx build -t simcax/cockroach:21.1.5 --platform=linux/arm64 .
