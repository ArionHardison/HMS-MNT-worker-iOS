#!/bin/bash

# ========================================
# iOS Build Error Tracker & Task Generator
# ========================================

set -e

PROJECT_ROOT="/Users/arionhardison/Desktop/mobile/HMS-MNT-worker-iOS"
LOG_DIR="$PROJECT_ROOT/build_logs"
TASK_DIR="$PROJECT_ROOT/build_tasks"
ERROR_LOG="$LOG_DIR/build_errors.log"
ITERATION_LOG="$LOG_DIR/iteration.log"
CURRENT_ITERATION_FILE="$LOG_DIR/current_iteration.txt"

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Initialize directories
mkdir -p "$LOG_DIR" "$TASK_DIR"

# Initialize iteration counter
if [ ! -f "$CURRENT_ITERATION_FILE" ]; then
    echo "1" > "$CURRENT_ITERATION_FILE"
fi

ITERATION=$(cat "$CURRENT_ITERATION_FILE")

echo -e "${BLUE}========================================${NC}"
echo -e "${BLUE}    iOS Build Error Tracker - Iteration $ITERATION${NC}"
echo -e "${BLUE}========================================${NC}"

# Function to log with timestamp
log_with_timestamp() {
    echo "[$(date '+%Y-%m-%d %H:%M:%S')] $1" | tee -a "$ITERATION_LOG"
}

# Function to extract and categorize build errors
extract_build_errors() {
    local build_log="$1"
    local errors_file="$2"
    
    echo -e "${YELLOW}Extracting build errors...${NC}"
    
    # Clear previous errors
    > "$errors_file"
    
    # Extract different types of errors
    echo "=== COMPILATION ERRORS ===" >> "$errors_file"
    grep -n "error:" "$build_log" | head -20 >> "$errors_file" 2>/dev/null || true
    
    echo -e "\n=== SWIFT COMPILATION ERRORS ===" >> "$errors_file"
    grep -A 5 -B 5 "SwiftCompile.*failed" "$build_log" | head -50 >> "$errors_file" 2>/dev/null || true
    
    echo -e "\n=== LINKER ERRORS ===" >> "$errors_file"
    grep -A 5 -B 5 "Ld.*failed\|ld.*error" "$build_log" | head -30 >> "$errors_file" 2>/dev/null || true
    
    echo -e "\n=== MISSING FILES ===" >> "$errors_file"
    grep -A 2 -B 2 "No such file\|file not found" "$build_log" | head -20 >> "$errors_file" 2>/dev/null || true
    
    echo -e "\n=== DEPENDENCY ERRORS ===" >> "$errors_file"
    grep -A 3 -B 3 "framework not found\|library not found\|module.*not found" "$build_log" | head -30 >> "$errors_file" 2>/dev/null || true
    
    echo -e "\n=== CODE SIGNING ERRORS ===" >> "$errors_file"
    grep -A 5 -B 5 "Code Sign\|Provisioning\|Certificate" "$build_log" | head -20 >> "$errors_file" 2>/dev/null || true
    
    echo -e "\n=== DEPRECATED API WARNINGS (Errors) ===" >> "$errors_file"
    grep -A 2 -B 2 "deprecated\|Werror.*deprecated" "$build_log" | head -20 >> "$errors_file" 2>/dev/null || true
    
    echo -e "\n=== FULL ERROR SUMMARY ===" >> "$errors_file"
    grep "BUILD FAILED\|failed\|error\|Error" "$build_log" | tail -10 >> "$errors_file" 2>/dev/null || true
}

# Function to generate task files from errors
generate_task_files() {
    local errors_file="$1"
    local task_prefix="iteration_${ITERATION}"
    
    echo -e "${YELLOW}Generating task files...${NC}"
    
    # Clear previous task files for this iteration
    rm -f "$TASK_DIR"/${task_prefix}_*.md
    
    local task_count=1
    
    # Process compilation errors
    if grep -q "error:" "$errors_file"; then
        local compilation_errors=$(grep "error:" "$errors_file" | head -5)
        if [ ! -z "$compilation_errors" ]; then
            create_task_file "compilation_errors" "$task_count" "$compilation_errors" "$task_prefix"
            ((task_count++))
        fi
    fi
    
    # Process Swift compilation errors
    if grep -q "SwiftCompile.*failed" "$errors_file"; then
        local swift_errors=$(grep -A 10 "SwiftCompile.*failed" "$errors_file" | head -20)
        if [ ! -z "$swift_errors" ]; then
            create_task_file "swift_compilation" "$task_count" "$swift_errors" "$task_prefix"
            ((task_count++))
        fi
    fi
    
    # Process dependency errors
    if grep -q "framework not found\|library not found\|module.*not found" "$errors_file"; then
        local dep_errors=$(grep -A 3 -B 3 "framework not found\|library not found\|module.*not found" "$errors_file")
        if [ ! -z "$dep_errors" ]; then
            create_task_file "dependency_errors" "$task_count" "$dep_errors" "$task_prefix"
            ((task_count++))
        fi
    fi
    
    # Process code signing errors
    if grep -q "Code Sign\|Provisioning\|Certificate" "$errors_file"; then
        local signing_errors=$(grep -A 5 -B 5 "Code Sign\|Provisioning\|Certificate" "$errors_file")
        if [ ! -z "$signing_errors" ]; then
            create_task_file "code_signing" "$task_count" "$signing_errors" "$task_prefix"
            ((task_count++))
        fi
    fi
    
    echo -e "${GREEN}Generated $((task_count-1)) task files.${NC}"
}

# Function to create individual task file
create_task_file() {
    local error_type="$1"
    local task_num="$2"
    local error_content="$3"
    local task_prefix="$4"
    
    local task_file="$TASK_DIR/${task_prefix}_task_${task_num}_${error_type}.md"
    
    cat > "$task_file" << EOF
# Build Error Task ${task_num}: ${error_type}

## Iteration: $ITERATION
## Generated: $(date)
## Priority: HIGH

## Error Details:
\`\`\`
$error_content
\`\`\`

## Context:
- Project: HMS-MNT-worker-iOS (Diet Manager Chef App)
- Build Target: iOS Simulator/Device
- Architecture: VIPER
- Current Dependencies: See Podfile.lock

## Analysis Required:
1. Identify root cause of error
2. Determine if it's a dependency, configuration, or code issue
3. Research modern iOS/Swift best practices for resolution
4. Implement fix with minimal impact on existing code

## Solution Strategy:
- [ ] Analyze error in context of current Xcode/Swift version
- [ ] Check for deprecated APIs or syntax
- [ ] Update dependencies if needed
- [ ] Implement code fixes
- [ ] Test fix in isolation
- [ ] Verify no regression in other areas

## Files Potentially Affected:
- Podfile (if dependency issue)
- Project settings (if configuration issue)
- Source code files (if code issue)
- Build phases (if build process issue)

## Expected Outcome:
Error resolved, build progresses further or completes successfully.

## Verification:
Run build command and confirm this specific error no longer appears.

---
**Auto-generated by build_error_tracker.sh**
EOF

    echo -e "${BLUE}Created task file: $task_file${NC}"
}

# Function to run build and capture output
run_build() {
    local build_log="$LOG_DIR/build_iteration_${ITERATION}.log"
    
    echo -e "${YELLOW}Running build (Iteration $ITERATION)...${NC}"
    log_with_timestamp "Starting build iteration $ITERATION"
    
    cd "$PROJECT_ROOT"
    
    # Try building for simulator first (less signing issues)
    echo -e "${BLUE}Building for iOS Simulator...${NC}"
    
    set +e # Don't exit on build failure
    
    timeout 600 xcodebuild \
        -workspace DietManagerChef.xcworkspace \
        -scheme DietManagerChef \
        -configuration Debug \
        -destination 'platform=iOS Simulator,id=E9266BDE-AED3-440D-9C5C-B024A0FD3179' \
        clean build \
        > "$build_log" 2>&1
    
    local build_result=$?
    set -e
    
    echo -e "${BLUE}Build completed with exit code: $build_result${NC}"
    log_with_timestamp "Build completed with exit code: $build_result"
    
    if [ $build_result -eq 0 ]; then
        echo -e "${GREEN}🎉 BUILD SUCCESSFUL! 🎉${NC}"
        log_with_timestamp "BUILD SUCCESSFUL"
        return 0
    else
        echo -e "${RED}❌ Build failed. Analyzing errors...${NC}"
        log_with_timestamp "Build failed, analyzing errors"
        return 1
    fi
}

# Function to execute task files (simulate - would normally be done by developer)
simulate_task_execution() {
    echo -e "${YELLOW}Simulating task execution...${NC}"
    
    local task_files=($(ls "$TASK_DIR"/iteration_${ITERATION}_*.md 2>/dev/null || true))
    
    if [ ${#task_files[@]} -eq 0 ]; then
        echo -e "${GREEN}No task files to execute.${NC}"
        return 0
    fi
    
    echo -e "${BLUE}Found ${#task_files[@]} task files to process:${NC}"
    for task_file in "${task_files[@]}"; do
        echo "  - $(basename "$task_file")"
    done
    
    # In a real scenario, each task would be executed by a developer or automated system
    echo -e "${YELLOW}NOTE: Task files generated. Manual execution required.${NC}"
    
    return 1 # Return failure to continue iteration
}

# Main execution loop
main() {
    log_with_timestamp "=== Starting Build Error Tracker - Iteration $ITERATION ==="
    
    # Run build
    if run_build; then
        echo -e "${GREEN}✅ BUILD SUCCESSFUL! No more errors to track.${NC}"
        log_with_timestamp "All errors resolved. Build successful."
        
        # Try release build
        echo -e "${BLUE}Testing Release build...${NC}"
        cd "$PROJECT_ROOT"
        set +e
        timeout 600 xcodebuild \
            -workspace DietManagerChef.xcworkspace \
            -scheme DietManagerChef \
            -configuration Release \
            -destination 'platform=iOS Simulator,id=E9266BDE-AED3-440D-9C5C-B024A0FD3179' \
            clean build \
            > "$LOG_DIR/release_build.log" 2>&1
        
        local release_result=$?
        set -e
        
        if [ $release_result -eq 0 ]; then
            echo -e "${GREEN}🚀 RELEASE BUILD SUCCESSFUL! Ready for App Store! 🚀${NC}"
            log_with_timestamp "RELEASE BUILD SUCCESSFUL"
        else
            echo -e "${YELLOW}⚠️  Release build has issues. Check release_build.log${NC}"
            log_with_timestamp "Release build failed, but Debug build works"
        fi
        
        exit 0
    fi
    
    # Extract errors
    local current_build_log="$LOG_DIR/build_iteration_${ITERATION}.log"
    extract_build_errors "$current_build_log" "$ERROR_LOG"
    
    # Generate task files
    generate_task_files "$ERROR_LOG"
    
    # Show summary
    echo -e "${BLUE}========================================${NC}"
    echo -e "${BLUE}           ITERATION $ITERATION SUMMARY${NC}"
    echo -e "${BLUE}========================================${NC}"
    echo -e "${YELLOW}Task files generated in: $TASK_DIR${NC}"
    echo -e "${YELLOW}Build log saved to: $current_build_log${NC}"
    echo -e "${YELLOW}Errors extracted to: $ERROR_LOG${NC}"
    
    echo -e "\n${RED}Next Steps:${NC}"
    echo "1. Review task files in $TASK_DIR"
    echo "2. Execute fixes for each task"
    echo "3. Run this script again to continue iteration"
    
    # Increment iteration for next run
    echo $((ITERATION + 1)) > "$CURRENT_ITERATION_FILE"
    
    log_with_timestamp "=== Iteration $ITERATION completed ==="
}

# Execute main function
main "$@"