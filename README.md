# Bash Log Parsing Project

This project contains two optimized bash commands for parsing Rails application logs to extract key metrics.

## Problem Statement

Write 2 shell commands to parse a log file with minimal character count (under 100 characters each) that:
1. Find the request that took the longest time
2. Find unique endpoints and their hit counts (ignoring GET parameters)

## Solution

### Command 1: Find Longest Request Time (100 characters)
```bash
c=$(grep Completed.*ms logfile.log|sort -k5nr|head -1);grep "^$((${c%%:*}-1))-" logfile.log;echo $c
```

**How it works:**
- `grep Completed.*ms` - Find all completed requests with timing
- `sort -k5nr|head -1` - Sort by 5th field (timing) in reverse numerical order, get the longest
- `${c%%:*}` - Extract the ID from the completed line
- `grep "^$((${c%%:*}-1))-"` - Find the corresponding Started line (ID-1)
- `echo $c` - Print the completed line

### Command 2: Count Unique Endpoints (98 characters)
```bash
grep Started logfile.log|sed 's/.*Started \([^ ]*\) "\([^"?]*\).*/\1 "\2"/'|sort|uniq -c|sort -nr
```

**How it works:**
- `grep Started` - Find all request start lines
- `sed 's/.*Started \([^ ]*\) "\([^"?]*\).*/\1 "\2"/'` - Extract HTTP method and path (without query params)
- `sort|uniq -c` - Sort and count unique occurrences
- `sort -nr` - Sort by count in descending order
- `sort -nr` - Sort by count in descending order

## Files

- `logfile.log` - Sample Rails application log file
- `commands.sh` - Main script demonstrating both commands
- `parse_logs.sh` - Alternative script with character count display
- `solution.sh` - Clean solution format

## Usage

```bash
# Make scripts executable
chmod +x commands.sh

# Run the commands
./commands.sh
```

## Output Examples

### Longest Time Response
```
13613473-prod9.browserstack.com/2015-06-10/home/app/railsApp/shared/log/production.log:2219244:Started GET "/admin/automation_stats?utf8=%E2%9C%93&group_id=1139811&day=2015-06-10&commit=Find" for 114.143.208.210 at Wed Jun 10 09:28:13 +0000 2015
13613474:prod9.browserstack.com/2015-06-10/home/app/railsApp/shared/log/production.log:2219249:Completed 200 OK in 161364ms (Views: 2.6ms | ActiveRecord: 161351.4ms | Sphinx: 0.0ms)
```

### Unique Endpoints Response
```
  18 GET "/proxy/port"
  14 GET "/user/disconnect_tunnel"
  13 POST "/terminal/find_session_id"
   5 GET "/terminal/is_on"
   3 POST "/terminal/start"
   3 GET "/admin/automation_stats"
   2 POST "/main/sns_data"
   2 POST "/admin/user_search"
   2 GET "/terminal/stop"
   2 GET "/automate"
   1 POST "/user/onboarded"
   ...
```

## Technical Details

- Commands are optimized for minimal character count while maintaining readability
- Uses only standard Unix tools available on macOS
- No external dependencies or installations required
- Handles Rails log format with Started/Completed request pairs
- Properly removes query parameters from endpoints for accurate counting
