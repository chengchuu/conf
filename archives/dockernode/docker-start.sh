#!/bin/bash
echo "Start Application ..."
# node-feperf-monitor-server
cd ./node-feperf-monitor-server
npm ci;
npm run start-prod;
