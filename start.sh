#!/bin/bash
sed -e "s/##MAIL_SMTP_SERVER/${MAIL_SMTP_SERVER}/" \
    -e "s/##MAIL_SMTPS_PORT/${MAIL_SMTPS_PORT}/" \
    -e "s/##MAIL_SMTP_USERNAME/${MAIL_SMTP_USERNAME}/" \
    -e "s/##MAIL_SMTP_PASSWORD/${MAIL_SMTP_PASSWORD}/" \
    -e "s/##MAIL_FROM/${MAIL_FROM}/" \
    /app/code/config/default.template.json > /app/code/config/default.json

cat /app/code/config/default.json

chown -R cloudron:cloudron /app/data
node spacedeck.js
