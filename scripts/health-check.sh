#!/bin/bash

echo "Checking React App..."
curl -s -o /dev/null -w "%{http_code}\n" http://localhost

echo "Checking Prometheus..."
curl -s http://localhost:9090/-/healthy

echo "Checking Grafana..."
curl -s -o /dev/null -w "%{http_code}\n" http://localhost:3000

echo "Checking Nginx metrics..."
curl http://localhost/stub_status

echo "Checking Blackbox probe..."
curl -s "http://localhost:9115/probe?target=http://react-app:80&module=http_2xx" | grep probe_success
