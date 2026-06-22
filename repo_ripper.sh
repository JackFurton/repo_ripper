#!/bin/bash

# Repo Ripper v3.6 - Ultimate LLM Local Software Tool
# Integrated Active Agentic Write Engine Layer (--apply)

show_help() {
    echo "========================================================"
    echo "         REPO RIPPER - LLM CONTEXT COMPANION"
    echo "========================================================"
    echo "Usage: ./repo_ripper.sh <target_directory> [options]"
    echo ""
    echo "Macro Options (Phase 1):"
    echo "  --diff              Include active unstaged git working changes"
    echo "  --sig               Include code signatures (functions, variables, modules)"
    echo "  --pr                Include full code contents of ONLY local branch changes"
    echo "  --stitch <path2>    Cross-reference a second repository path into the context"
    echo ""
    echo "Remote Discovery & Governance (Phase 2):"
    echo "  --list              Tokenless discovery: List all live remote MR/PR IDs on the server"
    echo "  --rules             Extract repository naming conventions, lint rules, and tool checks"
    echo "  --mr <id>           Automatically fetch, diff, and dump a remote GitLab MR,"
    echo "                      GitHub PR, or Bitbucket PR without checking out branches"
    echo ""
    echo "Micro Options (Phase 3 Deep Dive):"
    echo "  --focus <file1 ...> Dump the FULL content of specific files or folders"
    echo "  --trace <log/text>  Parse an error log/stack trace, isolate failing files and"
    echo "                      line numbers, and dump exact code context windows (+/-10 lines)"
    echo "  --apply             Safely parse a unified git diff patch directly off your macOS"
    echo "                      clipboard and merge code updates cleanly into local files"
    echo ""
    echo "Power Tool Modifiers:"
    echo "  --copy              Pipe the entire generated markdown block straight to the"
    echo "                      macOS clipboard silently (skips terminal screen output)"
    echo "========================================================"
    exit 0
}

# 1. Safety Guardrail: Check basic invocation parameters
if [[ -z "$1" || "$1" == "-h" || "$1" == "--help" ]]; then
    show_help
fi

if [[ ! -d "$1" ]]; then
    echo "Error: '$1' is not a valid directory."
    echo ""
    show_help
fi

TARGET_DIR="$1"
shift

REAL_TARGET=$(cd "$TARGET_DIR" && pwd)

# Extract clip modifiers before pipeline execution
COPY_TO_CLIPBOARD=false
CLEANED_ARGS=()
for arg in "$@"; do
    if [[ "$arg" == "--copy" ]]; then
        COPY_TO_CLIPBOARD=true
    else
        CLEANED_ARGS+=("$arg")
    fi
done

is_sensitive_file() {
    local filename
    filename=$(basename "$1")
    if [[ "$filename" =~ ^\.env || "$filename" == "config.env" || "$filename" =~ \.tfstate || "$filename" =~ \.tfvars || "$filename" =~ \.pem$ || "$filename" =~ \.key$ || "$filename" =~ key\.json$ ]]; then
        return 0
    fi
    return 1
}

generate_payload() {
    cd "$REAL_TARGET" || exit

    # Smart Isolation Engine: Determine if directory hierarchy output should be suppressed
    local SUPPRESS_MACRO=false
    for arg in "${CLEANED_ARGS[@]}"; do
        if [[ "$arg" == "--list" || "$arg" == "--focus" || "$arg" == "--mr" || "$arg" == "--trace" || "$arg" == "--apply" ]]; then
            SUPPRESS_MACRO=true
        fi
    done

    # Exclusive Micro Mode Intercept: Focus
    if [[ "${CLEANED_ARGS[0]}" == "--focus" ]]; then
        echo '```markdown'
        echo "# REPO RIPPER TARGETED FOCUS PAYLOAD"
        echo "Target Directory Base: $REAL_TARGET"
        echo "------------------------------------------------"
        shift
        while [[ "$#" -gt 0 ]]; do
            if [ -f "$1" ]; then
                if is_sensitive_file "$1"; then
                    echo -e "\n### FILE DUMP DEFENSE TRIGGERED"
                    echo "[SECURITY BLOCKED]: Refusing to extract contents of sensitive configuration asset: $1"
                else
                    local ext="${1##*.}"
                    local syntax="text"
                    if [[ "$ext" == "tf" || "$ext" == "tofu" ]]; then syntax="hcl"; fi
                    if [[ "$ext" == "yml" || "$ext" == "yaml" ]]; then syntax="yaml"; fi
                    if [[ "$ext" == "sh" ]]; then syntax="bash"; fi
                    if [[ "$ext" == "py" ]]; then syntax="python"; fi
                    if [[ "$ext" == "md" ]]; then syntax="markdown"; fi

                    echo -e "\n### FILE DUMP: $1"
                    echo "\`\`\`$syntax"
                    cat "$1"
                    echo "\`\`\`"
                fi
            elif [ -d "$1" ]; then
                echo -e "\n### DIRECTORY ANALYSIS: $1"
                echo '```text'
                find "$1" -maxdepth 2 -not -path '*/.*'
                echo '```'
            else
                echo "Warning: File or folder not found: $1"
            fi
            shift
        done
        echo '```'
        return
    fi

    # Standard Output Document Base
    echo '```markdown'
    echo "# REPO RIPPER CONTEXT COMPANION"
    echo "Primary Target: $REAL_TARGET"
    echo "Current Branch: $(git rev-parse --abbrev-ref HEAD 2>/dev/null || echo 'Not a git repo')"
    echo ""
    echo "CRITICAL INSTRUCTIONS FOR THE AI ASSISTANT:"
    echo "This context map was generated by the user using a local CLI utility tool called Repo Ripper."
    echo "Do not ask the user to manually open or copy-paste code files piece-by-piece."
    echo "If you need to inspect the full contents of any configuration, folder, or file listed in the"
    echo "directory structure below to answer their questions, explicitly instruct the user to run:"
    echo "  ./repo_ripper.sh <target_dir> --focus <path_to_file_1> <path_to_file_2>"
    echo "------------------------------------------------"

    if [[ "$SUPPRESS_MACRO" == "false" ]]; then
        echo -e "\n## DIRECTORY STRUCTURE"
        if command -v tree &> /dev/null; then
            tree -L 3 -I '.*|node_modules|venv|target'
        else
            find . -maxdepth 3 -not -path '*/.*' | sort | sed 's/[^ -][^\/]*\//    /g' | sed 's/..//'
        fi

        echo -e "\n## TOP-LEVEL CONFIGURATION FILES"
        local config_files=("project-config.yml" "tenants.yml" "project-config.yaml" "tenants.yaml" "default-versions.tf" "package.json" "go.mod")
        for file in "${config_files[@]}"; do
            if [ -f "$file" ]; then
                echo "### File: $file"
                echo '```yaml'
                cat "$file" | head -n 50
                echo '```'
            fi
        done
    fi

    set -- "${CLEANED_ARGS[@]}"
    while [[ "$#" -gt 0 ]]; do
        case "$1" in
            --list)
                echo -e "\n## REMOTE LIVE MERGE/PULL REQUEST REFERENCES"
                echo "Querying remote tracking endpoints without API tokens..."
                echo '```text'
                local remote_refs
                remote_refs=$(git ls-remote origin 'refs/merge-requests/*/head' 'refs/pull/*/head' 'refs/pull-requests/*/from' 2>/dev/null)
                if [[ -z "$remote_refs" ]]; then
                    echo "No remote open request tracking references detected or remote origin unreachable."
                else
                    echo "$remote_refs" | awk '{print "ID: " $2}' | sed -E 's/refs\/(merge-requests|pull|pull-requests)\///g' | sed -E 's/\/(head|from)//g' | sort -n -k 2
                fi
                echo '```'
                shift
                ;;
            --rules)
                echo -e "\n## REPOSITORY GOVERNANCE AND NAMING CONVENTIONS"
                local rule_files
                rule_files=$(find . -maxdepth 3 -name "*naming*" -o -name "*convention*" -o -name "CONTRIBUTING.md" -o -name "cspell.json")
                for rf in $rule_files; do
                    echo "### Governance Asset: $rf"
                    echo '```text'
                    cat "$rf" | head -n 60
                    echo '```'
                done
                if [ -f "tools/check_names.py" ]; then
                    echo "### Automated Validation Hook: tools/check_names.py"
                    echo '```python'
                    cat "tools/check_names.py" | grep -E "regex|pattern|convention|validate|def " | head -n 40
                    echo '```'
                fi
                shift
                ;;
            --diff)
                echo -e "\n## UNSTAGED WORKING DIRECTORY CHANGES"
                echo '```diff'
                git diff | head -n 100
                echo '```'
                shift
                ;;
            --sig)
                echo -e "\n## CODE INTERFACE SIGNATURES"
                echo '```text'
                find . -maxdepth 3 -name "*.tf" -o -name "*.py" -o -name "*.sh" | while read -r f; do
                    echo "=== File: $f ==="
                    grep -E "^output |^module |^variable |^def |^function " "$f" | head -n 15
                done
                echo '```'
                shift
                ;;
            --pr)
                echo -e "\n## ACTIVE BRANCH / PR MODIFICATIONS"
                local base_branch="main"
                git rev-parse --verify master &> /dev/null && base_branch="master"
                echo "### Modified Files Map (vs $base_branch):"
                echo '```text'
                git diff "$base_branch...HEAD" --stat
                echo '```'
                echo -e "\n### Full Contents of Modified Files:"
                git diff "$base_branch...HEAD" --name-only | while read -r mod_file; do
                    if [ -f "$mod_file" ]; then
                        if is_sensitive_file "$mod_file"; then
                            echo "#### Unsafe File Blocked: $mod_file"
                            echo "[SECURITY GUARDRAIL]: Redacted plaintext secret profile from context tracking mapping."
                        else
                            echo "#### Modified File Content: $mod_file"
                            echo '```'
                            cat "$mod_file" | head -n 200
                            echo '```'
                        fi
                    fi
                done
                shift
                ;;
            --mr)
                local MR_ID="$2"
                if [[ -z "$MR_ID" || "$MR_ID" == --* ]]; then
                    echo "Error: --mr option requires a valid Pull/Merge Request ID number."
                    exit 1
                fi
                local base_branch="main"
                git rev-parse --verify master &> /dev/null && base_branch="master"
                git fetch origin "$base_branch":"$base_branch" &>/dev/null
                git fetch origin refs/merge-requests/"$MR_ID"/head:mr-"$MR_ID"-delta &>/dev/null
                local fetch_status=$?
                if [[ $fetch_status -ne 0 ]]; then
                    git fetch origin refs/pull/"$MR_ID"/head:mr-"$MR_ID"-delta &>/dev/null
                    fetch_status=$?
                fi
                if [[ $fetch_status -ne 0 ]]; then
                    git fetch origin refs/pull-requests/"$MR_ID"/from:mr-"$MR_ID"-delta &>/dev/null
                    fetch_status=$?
                fi
                if [[ $fetch_status -eq 0 ]]; then
                    echo -e "\n## REMOTE PULL/MERGE REQUEST !$MR_ID CONTEXT"
                    echo "### Summary of Changes (vs $base_branch):"
                    echo '```text'
                    git diff "$base_branch...mr-${MR_ID}-delta" --stat
                    echo '```'
                    echo -e "\n### LINE-BY-LINE PATCH CHANGES (+/-):"
                    echo '```diff'
                    git diff "$base_branch...mr-${MR_ID}-delta" | head -n 300
                    echo '```'
                    echo -e "\n### Full Code Content of Modified Files (Surrounding Context):"
                    git diff "$base_branch...mr-${MR_ID}-delta" --name-only | while read -r mod_file; do
                        if [ -f "$mod_file" ]; then
                            if is_sensitive_file "$mod_file"; then
                                echo "#### File Body Redacted: $mod_file"
                                echo "[SECURITY GUARDRAIL]: Suppressed remote tracking payload due to signature classification breach."
                            else
                                echo "#### File Body: $mod_file"
                                echo "\`\`\`text"
                                git show mr-"$MR_ID"-delta:"$mod_file" | head -n 150
                                echo "\`\`\`"
                            fi
                        fi
                    done
                    git branch -D mr-"$MR_ID"-delta &>/dev/null
                else
                    echo -e "\n## REMOTE PULL/MERGE REQUEST CONTEXT"
                    echo "Error: Could not locate remote references on GitLab, GitHub, or Bitbucket for ID $MR_ID."
                fi
                shift 2
                ;;
            --trace)
                local TRACE_INPUT="$2"
                if [[ -z "$TRACE_INPUT" || "$TRACE_INPUT" == --* ]]; then
                    echo "Error: --trace option requires a log file path or a raw text string error token."
                    exit 1
                fi
                echo -e "\n## DIAGNOSTIC ERROR TRACE ENGINE PAYLOAD"
                local raw_error=""
                if [ -f "$TRACE_INPUT" ]; then raw_error=$(cat "$TRACE_INPUT"); else raw_error="$TRACE_INPUT"; fi
                echo "### RAW LOG ANALYSIS FRAGMENT:"
                echo '```text'
                echo "$raw_error" | head -n 15
                echo '```'
                echo -e "\n### ISOLATED WORKSPACE SOURCE BREAKS:"
                echo "$raw_error" | grep -oE '[a-zA-Z0-9_\/-]+\.(tf|tofu|py|sh|yml|yaml|json|md)(, line [0-9]+| line [0-9]+|:[0-9]+)?' | sort -u | while read -r target_hit; do
                    local file_hit
                    file_hit=$(echo "$target_hit" | grep -oE '^[a-zA-Z0-9_\/-]+\.(tf|tofu|py|sh|yml|yaml|json|md)')
                    local line_hit
                    line_hit=$(echo "$target_hit" | grep -oE '[0-9]+$')
                    if [ -f "$file_hit" ]; then
                        if is_sensitive_file "$file_hit"; then
                            echo "#### Redacted Sensitive Breaking File: $file_hit"
                        else
                            local ext="${file_hit##*.}"
                            local syntax="text"
                            if [[ "$ext" == "tf" || "$ext" == "tofu" ]]; then syntax="hcl"; fi
                            if [[ "$ext" == "sh" ]]; then syntax="bash"; fi
                            if [[ "$ext" == "py" ]]; then syntax="python"; fi

                            echo "#### Code Context Window: $file_hit (Failing Line Target: ${line_hit:-1})"
                            echo "\`\`\`$syntax"
                            if [ -n "$line_hit" ]; then
                                local start_w=$((line_hit - 10))
                                if [ $start_w -lt 1 ]; then start_w=1; fi
                                local end_w=$((line_hit + 10))
                                sed -n "${start_w},${end_w}p" "$file_hit" | awk -v sw="$start_w" '{print (sw+NR-1) ": " $0}'
                            else
                                head -n 40 "$file_hit" | awk '{print NR ": " $0}'
                            fi
                            echo "\`\`\`"
                        fi
                    fi
                done
                shift 2
                ;;
            --apply)
                echo -e "\n## ACTIVE REPO WORKSPACE WRITE EXECUTION INITIALIZED"
                # Extract unified diff components cleanly out of the pasteboard string buffer
                if command -v pbpaste &> /dev/null; then
                    pbpaste | sed -n '/^diff --git/,/^\(diff --git\|```\|$\)/p' | grep -v '^```' > workspace.patch
                    if [ ! -s workspace.patch ] || ! grep -q "^diff --git" workspace.patch; then
                        # Try loose capture if markdown wrapping blocks were omitted by the AI
                        pbpaste > workspace.patch
                    fi
                    
                    if grep -q "^diff --git" workspace.patch; then
                        if git apply --check workspace.patch &>/dev/null; then
                            git apply workspace.patch
                            echo "Success: AI code modifications applied cleanly to local workspace files!"
                        else
                            echo "Error: Git tracking rejected patch application dry-run. Merge conflicts detected."
                            echo "Raw Clipboard head context tracking sample:"
                            head -n 5 workspace.patch
                        fi
                    else
                        echo "Error: No valid unified git diff patch headers found inside clipboard memory block."
                    fi
                    rm -f workspace.patch
                else
                    echo "Error: pbpaste integration utility is unavailable on this hardware configuration."
                fi
                shift
                ;;
            --stitch)
                local STITCH_DIR="$2"
                if [[ -d "$STITCH_DIR" ]]; then
                    local REAL_STITCH
                    REAL_STITCH=$(cd "$STITCH_DIR" && pwd)
                    echo -e "\n================================================"
                    echo "## STITCHED REPOSITORY DEPENDENCY: $REAL_STITCH"
                    echo "================================================"
                    echo "### Dependent Directory Layout:"
                    cd "$REAL_STITCH" || exit
                    find . -maxdepth 2 -not -path '--stitch' | sort | sed 's/[^ -][^\/]*\//    /g' | sed 's/..//'
                    cd "$REAL_TARGET" || exit
                else
                    echo "Error: Stitched path '$STITCH_DIR' is not a valid directory."
                fi
                shift 2
                ;;
            *)
                show_help
                ;;
        esac
    done

    echo '```'
}

# Output Route Interceptor Execution
if [ "$COPY_TO_CLIPBOARD" = true ]; then
    if command -v pbcopy &> /dev/null; then
        generate_payload "${CLEANED_ARGS[@]}" | pbcopy
        echo "Success: Entire markdown context payload injected directly into the macOS clipboard."
    else
        generate_payload "${CLEANED_ARGS[@]}"
    fi
else
    generate_payload "${CLEANED_ARGS[@]}"
fi
