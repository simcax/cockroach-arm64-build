#!/bin/bash
docker buildx build -t simcax/cockroach:20.2.10 --platform=linux/arm64 .
