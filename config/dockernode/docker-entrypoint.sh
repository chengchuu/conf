#!/bin/bash
echo "Start Application ..."
npm install -g pm2@2.10.3 --registry=https://registry.npmmirror.com
# Rain
cd /web/node-koa-rain
npm ci
npm run start
# Server
cd /web/server
npm ci
npm run start
# Feperf
cd /web/node-feperf-monitor-server
npm ci
npm run start-prod
