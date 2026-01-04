#!/bin/bash

# Migrate Dcockerfile & Conf
\cp -f ./conf/config/dockermazey/Dockerfile ./
\cp -f ./conf/.dockerignore ./
\cp -f ./server/config/go-gin-gee/config.secret.json ./go-gin-gee/assets/data/config.prd.json
