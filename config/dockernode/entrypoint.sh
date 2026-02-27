#!/bin/bash
echo "Start Application ..."
npm install -g pm2@2.10.3 --registry=https://registry.npmmirror.com
# node-koa-rain
cd /web/node-koa-rain
npm ci
npm run start
# server
cd /web/server
npm ci
npm run start
# node-feperf-monitor-server
cd /web/node-feperf-monitor-server
npm ci
npm run start-prod
