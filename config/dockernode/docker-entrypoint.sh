#!/bin/bash
echo "Start Application ..."
npm install -g pm2@2.10.3 --registry=https://registry.npmmirror.com
# Rain
cd /web/node-koa-rain
npm ci
# npm install one-time@0.0.4 gtts@0.2.1 exceljs@4.3.0 --registry=https://registry.npmmirror.com
npm run start
# Server
cd /web/server
npm ci
npm run start
# Feperf
cd /web/node-feperf-monitor-server
npm ci
npm run start-prod
