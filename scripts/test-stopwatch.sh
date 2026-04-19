#!/bin/bash
# Test script for the stopwatch utility
# This script demonstrates the stopwatch functionality with multiple named watches

# Enable stopwatch functionality
export RIBYNS_STOPWATCH_ENABLED=true

# Source the stopwatch script
source "$(dirname "$0")/stopwatch.sh"

echo "🧪 Stopwatch Test Suite"
echo "======================="
echo "____"

# Test 1: Basic stopwatch with simulated work
echo "Test 1: compile"
start "compile"
sleep 1
stamp "compile"
sleep 0.5
stop "compile"
echo "____"

# Test 2: Multiple simultaneous stopwatches
echo "Test 2: Multiple Concurrent Timers"
start "task-a"
start "task-b"

sleep 1
stamp "task-a"

sleep 2
stamp "task-b"

echo "____"
echo "  Final times:"
stop "task-a"
stop "task-b"
echo "____"

# Test 3: Very quick operation (sub-second)
echo "Test 3: Sub-Second Operation"
start "quick-op"
sleep 0.1
stop "quick-op"
echo "____"

# Test 4: Testing disabled mode
echo "Test 4: Testing Disabled Mode"
echo "-----------------------------"
echo "  Disabling stopwatch..."
unset RIBYNS_STOPWATCH_ENABLED

start "disabled-timer"
stamp "disabled-timer"
stop "disabled-timer"

echo "  (No output above means disabled mode works correctly)"
echo "____"

echo "Test 4: bypass enabled flag"
_start "bypass"
sleep 0.2
_stamp "bypass"
sleep 0.2
_stop "bypass"
echo "____"

# Re-enable for final summary
export RIBYNS_STOPWATCH_ENABLED=true

# Test 5: Error handling
echo "Test 5: Error Handling"
echo "  Attempting to stamp non-existent timer:"
_stamp "nonexistent" 2>&1 || true
echo "____"

echo "  Attempting to stop non-existent timer:"
_stop "nonexistent" 2>&1 || true
echo "____"

echo "  Attempting to stop already-stopped timer:"
start "stop-test"
stop "stop-test"
stop "stop-test" 2>&1 || true
echo "____"

echo "✅ Test Suite Complete!"
