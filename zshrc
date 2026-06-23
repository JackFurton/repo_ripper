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

ripfind() {
    if [ -z "$1" ]; then
        echo "Error: Please specify a search query or variable name. (e.g., ripfind c5isr_enable)"
        return 1
    fi

    local parent_workspace=$(dirname "$(pwd)")
    
    echo "Scanning sibling repositories for cross-boundary matches: $1..."
    {
        echo -e "# GLOBAL CROSS-REPOSITORY CODE COGNITION INDEX\n"
        echo -e "Search Query Target: \`$1\`\n"
        
        # Iterate over item frameworks inside the parent folder layer
        for repo in "$parent_workspace"/*/; do
            [ -d "$repo" ] || continue
            local folder_name=$(basename "$repo")
            
            # Strict boundary protection against default macOS directory paths
            if [[ "$folder_name" =~ ^(Applications|Desktop|Documents|Downloads|Library|Public|Movies|Music|Pictures|Trash)$ ]]; then
                continue
            fi
            
            # Execute targeted deep-scans exclusively inside real codebase folders
            find "$repo" -maxdepth 4 -type f \( -name "*.tf" -o -name "*.tfvars" -o -name "*.sh" -o -name "*.py" -o -name "*.md" -o -name "*.yml" -o -name "*.yaml" -o -name "*.json" -o -name "*.txt" -o -name "*.env" \) \
                ! -path '*/.*' \
                ! -path '*node_modules*' \
                ! -path '*venv*' \
                ! -path '*.terraform*' \
                ! -path '*.tofu*' 2>/dev/null | while read -r file; do
                    
                    if grep -q "$1" "$file"; then
                        local relative_spec=${file#$parent_workspace/}
                        
                        echo "#FILE: @$relative_spec"
                        echo "\`\`\`text"
                        grep -n -C 2 "$1" "$file"
                        echo -e "\`\`\`\n"
                    fi
            done
        done
    } | pbcopy
    echo "Success: Shielded sibling-repo context matches loaded to clipboard."
}

# Git Navigation Essentials
alias gd='git diff'
alias gs='git status'
alias gr='git restore .'
