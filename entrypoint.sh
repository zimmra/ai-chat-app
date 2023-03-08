#!/bin/sh
cp -r /prisma /app
cp -r /public /app
cp -r /src /app
cp /next.config.mjs /app
cp /package.json /app
cp /shell.nix /app
cp /tsconfig.json /app
cp /yarn.lock /app
cd /app
yarn start