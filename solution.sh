
echo "Longest Time Response"
echo
# Command 1: Find the longest request time and show both Started and Completed lines (100 chars)
c=$(grep Completed.*ms logfile.log|sort -k5nr|head -1);grep "^$((${c%%:*}-1))-" logfile.log;echo $c

echo
echo "Unique Endpoints Response"
echo
# Command 2: Show unique endpoints and their counts (98 chars)
grep Started logfile.log|sed 's/.*Started \([^ ]*\) "\([^"?]*\).*/\1 "\2"/'|sort|uniq -c|sort -nr
