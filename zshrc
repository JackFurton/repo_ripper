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
    git --no-pager diff main...FETCH_HEAD | pbcopy
    echo "Success: Full line-by-line code changes loaded to clipboard."

    # 2. Dump the exact line diff straight to the terminal screen history (no less pager!)
    echo -e "\n--- LINE-BY-LINE PATCH CHANGES FOR PR !$1 ---"
    git --no-pager diff main...FETCH_HEAD
}

# Git Navigation Essentials
alias gd='git diff'
alias gs='git status'
alias gr='git restore .'
