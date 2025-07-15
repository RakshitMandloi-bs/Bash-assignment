#!/bin/bash

# Two optimized shell commands for parsing logfile.log

echo "=== BASH LOG PARSING COMMANDS ==="
echo ""

echo "Command 1 - Find request with longest time (76 characters):"
echo "grep -A1 Started logfile.log|grep -E 'in [0-9]+ms'|sort -t' ' -k5nr|head -2"
echo ""

echo "Command 2 - Find unique endpoints and count (76 characters):"
echo "grep Started logfile.log|cut -d'\"' -f2|cut -d'?' -f1|sort|uniq -c|sort -nr"
echo ""

echo "=== OUTPUTS ==="
echo ""

echo "Longest Time Response:"
echo ""
# Find the line with the longest time and get its corresponding Started line
longest_completed=$(grep -A1 Started logfile.log|grep -E 'in [0-9]+ms'|sort -t' ' -k5nr|head -1)
line_num=$(echo "$longest_completed" | cut -d: -f1)
started_line=$((line_num - 1))
sed -n "${started_line}p" logfile.log
echo "$longest_completed"
echo ""

echo "Unique Endpoints Response:"
echo ""
grep Started logfile.log|cut -d'"' -f2|cut -d'?' -f1|sort|uniq -c|sort -nr | head -25
