# --------------------------------------------------------
# REPO RIPPER COMMAND CENTER (v5.0 Lean)
# --------------------------------------------------------
alias riplist="python3 ~/repo_ripper.py . --list"
alias ripapply="python3 ~/repo_ripper.py . --apply"

ripc() {
    python3 ~/repo_ripper.py . --copy
    (pbpaste; echo -e "\n\n========================================================\nSTRICT RESPONSE CONSTRAINTS FOR THE AI ASSISTANT:\nIf the user asks for code modifications, bug fixes, or file rewrites, you MUST structure your recommendations explicitly using the Text-Anchor SEARCH/REPLACE paradigm template outlined below.\nDo not use unified git diff line coordinates. Output your patch blocks exactly inside standard markdown blocks using this format:\n\n#FILE: path/to/file.ext\n<<<<<<< SEARCH\nExact existing lines of code to match in target file\n=======\nNew replacement lines of code to inject\n>>>>>>> REPLACE\n========================================================") | pbcopy
    echo "Success: Context map + AI Execution instructions loaded to clipboard."
}

ripcheck() {
    if [ -z "$1" ]; then
        echo "Error: Please specify a PR/MR ID number. (e.g., ripcheck 161)"
        return 1
    fi

    echo "Fetching remote tracking layout for ID $1..."
    git fetch origin refs/merge-requests/"$1"/head 2>/dev/null || git fetch origin refs/pull/"$1"/head 2>/dev/null

    # 1. Silently load the actual line-by-line diff straight to the AI clipboard
    git diff main...FETCH_HEAD | pbcopy
    echo "Success: Full line-by-line code changes loaded to clipboard."

    # 2. Force a raw terminal text dump by piping straight through cat
    echo -e "\n--- LINE-BY-LINE PATCH CHANGES FOR PR !$1 ---"
    git diff main...FETCH_HEAD | cat
}

ripshow() {
    if [ -z "$1" ]; then
        echo "Error: Please specify a file path. (e.g., ripshow modules/gcs/main.tf)"
        return 1
    fi

    if [ ! -f "$1" ]; then
        echo "Error: File not found on disk: $1"
        return 1
    fi

    (echo -e "# FILE CONTEXT SOURCE: $1\n\`\`\`text"; cat "$1"; echo -e "\`\`\`") | pbcopy
    echo "Success: Encapsulated contents of $1 loaded to clipboard."
}

ripsnap() {
    if [ -z "$1" ]; then
        echo "Error: Please specify a target directory. (e.g., ripsnap modules/kms)"
        return 1
    fi

    if [ ! -d "$1" ]; then
        echo "Error: Directory not found on disk: $1"
        return 1
    fi

    echo "Snapping clean source assets inside directory frame: $1..."
    {
        echo -e "# BULK WORKSPACE SNAPSHOT TARGET: $1\n"
        
        # Target explicitly safe development text extensions
        find "$1" -type f \( -name "*.tf" -o -name "*.tfvars" -o -name "*.sh" -o -name "*.py" -o -name "*.md" -o -name "*.yml" -o -name "*.yaml" -o -name "*.json" -o -name "*.txt" -o -name "*.env" \) \
            ! -path '*/.*' \
            ! -path '*node_modules*' \
            ! -path '*venv*' \
            ! -path '*.terraform*' \
            ! -path '*.tofu*' | while read -r file; do
                echo -e "#FILE: $file"
                echo "\`\`\`text"
                cat "$file"
                echo -e "\`\`\`\n"
        done
    } | pbcopy
    echo "Success: Safe workspace directory snapshot loaded to clipboard."
}

ripscreen() {
    local engine_cmd=""
    
    # Auto-detect the host terminal emulator environment
    if [ "$TERM_PROGRAM" = "iTerm.app" ]; then
        engine_cmd="tell application \"iTerm\" to tell current session of current window to get text"
    else
        engine_cmd="tell application \"Terminal\" to get contents of selected tab of front window"
    fi

    # Extract canvas contents and cleanly strip leading/trailing ghost padding
    osascript -e "$engine_cmd" 2>/dev/null \
        | awk '/[^[:space:]]/{if(p) for(i=1;i<=b;i++) print ""; print; p=1; b=0; next} {if(p) b++}' \
        | pbcopy
}

# Git Navigation Essentials
alias gd='git diff'
alias gs='git status'
alias gr='git restore .'
