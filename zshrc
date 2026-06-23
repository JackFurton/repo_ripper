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
    # Pull the remote PR tip silently into FETCH_HEAD
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

    # Wrap the file content cleanly in markdown and pipe it straight to the clipboard
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

    echo "Snapping all local text assets inside directory frame: $1..."
    {
        echo -e "# BULK WORKSPACE SNAPSHOT TARGET: $1\n"
        
        # Loop through all files, filtering out vendor/cache garbage
        find "$1" -type f \
            ! -path '*/.*' \
            ! -path '*node_modules*' \
            ! -path '*venv*' \
            ! -path '*.terraform*' \
            ! -path '*.tofu*' | while read -r file; do
                
                # Double-check that it is a parseable text or source file
                if file "$file" | grep -qE 'text|empty|JSON|XML|YAML'; then
                    echo -e "#FILE: $file"
                    echo "\`\`\`text"
                    cat "$file"
                    echo -e "\`\`\`\n"
                fi
        done
    } | pbcopy
    echo "Success: Enclosed directory payload loaded to clipboard for the AI."
}

ripscreen() {
    echo "Capturing active terminal history scrollback canvas..."
    
    # Leverages macOS native terminal automation descriptors
    osascript -e 'tell application "Terminal" to get contents of selected tab of front window' | pbcopy
    
    echo "Success: Full terminal printout trail loaded to clipboard."
}

# Git Navigation Essentials
alias gd='git diff'
alias gs='git status'
alias gr='git restore .'
