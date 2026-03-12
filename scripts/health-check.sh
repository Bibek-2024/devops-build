#!/bin/bash

# Colors for easy reading
GREEN='\033[0;32m'
RED='\033[0;31m'
NC='\033[0m' 

echo "--- 🛡️ DevOps Infrastructure Health Check ---"

# 1. React App
CODE=$(curl -s -o /dev/null -w "%{http_code}" http://localhost:80)
[[ "$CODE" == "200" ]] && echo -e "React App: ${GREEN}UP ($CODE)${NC}" || echo -e "React App: ${RED}DOWN ($CODE)${NC}"

# 2. Prometheus
if curl -s http://localhost:9090/-/healthy | grep -q "Healthy"; then
    echo -e "Prometheus: ${GREEN}UP${NC}"
else
    echo -e "Prometheus: ${RED}DOWN${NC}"
fi

# 3. Grafana
G_CODE=$(curl -s -o /dev/null -w "%{http_code}" http://localhost:3000)
[[ "$G_CODE" == "200" || "$G_CODE" == "302" ]] && echo -e "Grafana: ${GREEN}UP${NC}" || echo -e "Grafana: ${RED}DOWN${NC}"

# 4. Nginx Stub Status (The metrics source)
if curl -s http://localhost/stub_status | grep -q "Active"; then
    echo -e "Nginx Metrics: ${GREEN}AVAILABLE${NC}"
else
    echo -e "Nginx Metrics: ${RED}UNAVAILABLE (Check nginx.conf)${NC}"
fi

# 5. Blackbox Exporter (Testing the Prober itself)
PROBE=$(curl -s "http://localhost:9115/probe?target=https://www.google.com&module=http_2xx" | grep "probe_success" | awk '{print $2}')
if [ "$PROBE" == "1" ]; then
    echo -e "Blackbox Prober: ${GREEN}WORKING${NC}"
else
    echo -e "Blackbox Prober: ${RED}FAILED${NC}"
fi

# 6. cAdvisor (Your custom port 8082)
C_CODE=$(curl -s -o /dev/null -w "%{http_code}" http://localhost:8082/metrics)
[[ "$C_CODE" == "200" ]] && echo -e "cAdvisor: ${GREEN}UP (Port 8082)${NC}" || echo -e "cAdvisor: ${RED}DOWN${NC}"

echo "---------------------------------------"
