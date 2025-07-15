#!/bin/bash

# Bash Log Parsing Commands
# Two optimized shell commands for parsing logfile.log

echo "=== Command 1: Find request with longest time ==="
echo "Command: grep -A1 Started logfile.log|grep -E 'in [0-9]+ms'|sort -t' ' -k5nr|head -2"
echo "Character count: $(echo 'grep -A1 Started logfile.log|grep -E '"'"'in [0-9]+ms'"'"'|sort -t'"'"' '"'"' -k5nr|head -2' | wc -c)"
echo ""
echo "Output:"
grep -A1 Started logfile.log|grep -E 'in [0-9]+ms'|sort -t' ' -k5nr|head -2
echo ""

echo "=== Command 2: Find unique endpoints and count ==="
echo "Command: grep Started logfile.log|cut -d'\"' -f2|cut -d'?' -f1|sort|uniq -c|sort -nr"
echo "Character count: $(echo 'grep Started logfile.log|cut -d'"'"'\"'"'"' -f2|cut -d'"'"'?'"'"' -f1|sort|uniq -c|sort -nr' | wc -c)"
echo ""
echo "Output:"
grep Started logfile.log|cut -d'"' -f2|cut -d'?' -f1|sort|uniq -c|sort -nr
