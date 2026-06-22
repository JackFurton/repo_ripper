# --------------------------------------------------------
# REPO RIPPER COMMAND CENTER STACK (v3.11)
# --------------------------------------------------------
alias rip="~/repo_ripper.sh ."
alias riplist="~/repo_ripper.sh . --list"
alias riprules="~/repo_ripper.sh . --rules --copy"
alias ripsig="~/repo_ripper.sh . --sig --copy"
alias ripapply="~/repo_ripper.sh . --apply"

# Context Scraper: Automatically teaches the AI your new Search/Replace tool rules
ripc() {
    ~/repo_ripper.sh . --copy
    (pbpaste; echo -e "\n\n========================================================\nSTRICT RESPONSE CONSTRAINTS FOR THE AI ASSISTANT:\nIf the user asks for code modifications, bug fixes, or file rewrites, you MUST structure your recommendations explicitly using the Text-Anchor SEARCH/REPLACE paradigm template outlined below.\nDo not use unified git diff line coordinates. Output your patch blocks exactly inside standard markdown blocks using this format:\n\n#FILE: path/to/file.ext\n<<<<<<< SEARCH\nExact existing lines of code to match in target file\n=======\nNew replacement lines of code to inject\n>>>>>>> REPLACE\n========================================================") | pbcopy
    echo "Success: Context map + AI Execution instructions loaded to clipboard."
}

ripmr() {
    ~/repo_ripper.sh . --mr "$1" --copy
}
ripbreak() {
    ~/repo_ripper.sh . --trace "$1" --copy
}

# git

alias gd='git diff'
alias gs='git status'
alias gp='git pull'
alias gr='git restore .'
