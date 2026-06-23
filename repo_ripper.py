#!/usr/bin/env python3
import os
import sys
import argparse
import subprocess

class RepoRipper:
    def __init__(self, target_dir, copy_to_clipboard=False):
        self.target_dir = os.path.abspath(target_dir)
        self.copy_to_clipboard = copy_to_clipboard
        self.payload_buffer = []

    def log(self, text):
        self.payload_buffer.append(text)

    def print_payload(self):
        final_markdown = "\n".join(self.payload_buffer)
        if self.copy_to_clipboard:
            try:
                process = subprocess.Popen(['pbcopy'], stdin=subprocess.PIPE)
                process.communicate(input=final_markdown.encode('utf-8'))
                print("Success: Context loaded to macOS clipboard.")
            except Exception:
                print("Error: Clipboard integration failed.")
        else:
            print(final_markdown)

    def generate_native_tree(self, path, current_depth=1, max_depth=3, prefix=""):
        if current_depth > max_depth: return
        try:
            entries = sorted(os.scandir(path), key=lambda e: e.name)
        except Exception: return

        entries = [e for e in entries if not e.name.startswith('.') and e.name not in ['node_modules', 'venv', 'target', '__pycache__', '.git', '.terraform', '.tofu']]
        
        for i, entry in enumerate(entries):
            is_last = (i == len(entries) - 1)
            connector = "└── " if is_last else "├── "
            self.log(f"{prefix}{connector}{entry.name}")
            if entry.is_dir():
                next_prefix = prefix + ("    " if is_last else "│   ")
                self.generate_native_tree(entry.path, current_depth + 1, max_depth, next_prefix)

    def append_header(self, suppress_tree=False):
        current_branch = "main"
        try:
            current_branch = subprocess.check_output(['git', 'rev-parse', '--abbrev-ref', 'HEAD'], cwd=self.target_dir).decode('utf-8').strip()
        except Exception: pass
        
        self.log("# REPO RIPPER CONTEXT COMPANION")
        self.log(f"**Primary Target:** `{self.target_dir}` | **Branch:** `{current_branch}`\n")
        
        if not suppress_tree:
            self.log("## DIRECTORY STRUCTURE\n```text")
            self.log(os.path.basename(self.target_dir))
            self.generate_native_tree(self.target_dir)
            self.log("```")

    def execute_list(self):
        self.log("\n## REMOTE LIVE MERGE/PULL REQUEST REFERENCES")
        try:
            proc = subprocess.Popen(['git', 'ls-remote', 'origin', 'refs/merge-requests/*/head', 'refs/pull/*/head'], stdout=subprocess.PIPE, stderr=subprocess.PIPE, cwd=self.target_dir)
            stdout, _ = proc.communicate(timeout=10)
            remote_refs = stdout.decode('utf-8', errors='ignore').strip()
            
            self.log("```text")
            for line in remote_refs.splitlines():
                parts = line.split()
                if len(parts) >= 2:
                    ref = parts[1]
                    clean_ref = ref.replace('refs/merge-requests/', '').replace('refs/pull/', '').replace('/head', '')
                    self.log(f"ID: {clean_ref}")
            self.log("```")
        except Exception:
            self.log("Remote origin references unreachable or timed out.")

    def execute_apply(self):
        self.log("\n## ACTIVE AGENTIC TEXT-ANCHOR WRITE EXECUTION INITIALIZED")
        try:
            raw_clipboard = subprocess.check_output(['pbpaste']).decode('utf-8', errors='ignore')
        except Exception: return
        
        clean_content = raw_clipboard.replace('\xa0', ' ').replace('\r\n', '\n')
        lines = clean_content.splitlines()
        current_file, search_block, replace_block, state, applied_count = None, [], [], "OUTSIDE", 0

        for line in lines:
            if line.startswith("#FILE:"):
                current_file = line.replace("#FILE:", "").strip()
            elif line.startswith("<<<<<<< SEARCH"):
                state, search_block = "SEARCH", []
            elif line.startswith("======="):
                state, replace_block = "REPLACE", []
            elif line.startswith(">>>>>>> REPLACE"):
                state = "OUTSIDE"
                if not current_file: continue
                
                full_path = os.path.join(self.target_dir, current_file)
                s_str, r_str = "\n".join(search_block), "\n".join(replace_block)

                if not os.path.exists(full_path) and not s_str:
                    os.makedirs(os.path.dirname(full_path), exist_ok=True)
                    with open(full_path, 'w', encoding='utf-8') as nf: nf.write(r_str + "\n")
                    print(f"Success: Created new file: {current_file}")
                    applied_count += 1
                elif os.path.exists(full_path):
                    with open(full_path, 'r', encoding='utf-8', errors='ignore') as f: f_content = f.read()
                    if s_str in f_content:
                        with open(full_path, 'w', encoding='utf-8') as f: f.write(f_content.replace(s_str, r_str))
                        print(f"Success: Patched file: {current_file}")
                        applied_count += 1
            else:
                if state == "SEARCH":
                    search_block.append(line)
                elif state == "REPLACE":
                    replace_block.append(line)
        print(f"\nExecution Complete: Synchronized {applied_count} workspace mutations.")

def main():
    parser = argparse.ArgumentParser(description="Repo Ripper v5.0 Lean - Secure AI Workspace Companion")
    parser.add_argument('target_dir', help="Path to target directory workspace.")
    parser.add_argument('--copy', action='store_true', help="Harvest codebase tree map and inject strict system prompt constraints to clipboard.")
    parser.add_argument('--list', action='store_true', help="Query upstream server to discover live active MR/PR tracking ID numbers.")
    parser.add_argument('--apply', action='store_true', help="Surgically apply text-anchor SEARCH/REPLACE patches onto local disk files.")
    args = parser.parse_args()

    ripper = RepoRipper(args.target_dir, copy_to_clipboard=args.copy)

    if args.apply:
        ripper.execute_apply()
    elif args.list:
        ripper.append_header(suppress_tree=True)
        ripper.execute_list()
        ripper.print_payload()
    else:
        ripper.append_header()
        ripper.print_payload()

if __name__ == "__main__":
    main()
