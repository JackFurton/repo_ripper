# Repo Ripper Workspace Toolbelt (v5.0 Lean)

### Secure Local AI Context Harvester & Minimalist Execution Engine

Repo Ripper is a zero-dependency, native hybrid workspace platform engineered specifically for secure, air-gapped corporate environments. It bridges the gap between massive AI engineering leverage and corporate compliance by harvesting precise directory layouts and file context frames locally, while safely executing code mutations via a line-agnostic text-anchor execution engine. It avoids external binary dependencies, heavy daemons, or streaming sensitive repository telemetry outside your workstation boundary.

---

## The Terminal Command Center Matrix

Adding the minimalist profile mappings to your active environment (`~/.zshrc`) grants immediate terminal macro access to these seven primitives:

### 1. Local Workspace Visibility & Ingestion
* `ripc` — **Context Harvester:** Recursively sweeps your local directory tree, skips hidden asset caches, compiles a blueprint directory framework, and auto-appends strict AI system response parameters directly to the macOS clipboard.
* `ripshow <file_path>` — **Target Inspector:** Instantly wraps the entire raw text contents of a targeted file into an isolated markdown block alongside its explicit file path context and copies it to your clipboard. 
* `ripsnap <dir_path>` — **Bulk Folder Snapper:** Recursively targets safe text/code assets inside an entire targeted directory frame, completely bypassing binary risk blocks, and structures them into a single unified workspace payload for multi-file ingestion.
* `ripscreen` — **Scrollback Canvas Grabber:** Automates macOS terminal history collection to instantly capture active console prints, execution trails, or deployment error dumps onto your clipboard without manual mouse selections.

### 2. Upstream Tracking Discovery
* `riplist` — **Remote Radar:** Natively queries open tracking endpoints on the repository origin server to print a clean list of live active Merge/Pull Request tracking ID numbers without needing tokens or browser interaction.
* `ripcheck <id>` — **Live Delta Streamer:** Anonymously streams the text delta of a remote PR directly into your terminal scrollback canvas with zero pagination page freezes (`| cat` bypass). It simultaneously loads the full line-by-line patch differential onto your clipboard so the AI can evaluate cross-branch collisions.

### 3. Agentic Write Execution
* `ripapply` — **Surgical Execution Engine:** Intercepts structured text-patches sitting on your clipboard, cleanses browser whitespace corruption artifacts, auto-creates deep sub-folders if spawning an asset from scratch, and performs line-agnostic string-matching writes straight to local disk.

---

## Editor Native Integrations (Vim)

Your `.vimrc` environment maps your local shell primitives directly to your editor workspace window profile. 

* `,c` — **Active Buffer Ingestion:** Pressing your leader key sequence inside any active editor layout wraps the open code document in clean markdown and automatically injects it into your macOS system clipboard buffer for immediate AI evaluation.

---

## The Operational Workflow Loop

```text
                     ┌───( 1. ripc / ripshow / ripsnap / ripscreen )───┐
                     ▼                                                 │
       [ Local Terminal ] <───────( 4. ripapply )─────────── [ Mac Clipboard ]
             │   ▲                                                     ▲
   ( riplist │   │ ( ripcheck )                                        │
   riplist ) ▼   │                                                ( 3. Copy Fix )
       [ Upstream Repo ]                                               │
             └───────────────( 2. Cmd+V )──────────────────────────> [ AI Chat Pane ]
```

1. **Harvest:** Execute `ripc` to copy your directory tree mapping, run `ripshow` / `ripsnap` to capture codebase bodies, or run `ripscreen` to capture execution errors.
2. **Consult:** Paste (**Cmd+V**) the payload directly to the AI window along with any active logs, or pass a teammate's PR patch data via `ripcheck <id>`.
3. **Capture:** The AI interprets the environment and responds with an explicit code patch wrapped inside text-anchor blocks. Click **Copy** on that response block.
4. **Execute:** Return to your active terminal line, execute `ripapply`, and watch the code update on disk instantly.

---

## Mandatory AI System Response Constraints

When processing user requests, the AI assistant **must** bypass unified git line coordinates (`@@`) and structure all file creations, deletions, edits, or bug fixes utilizing this exact text-anchor SEARCH/REPLACE paradigm template:

```text
#FILE: path/to/your/target_file.tf
<<<<<<< SEARCH
    "log-sink" = {
      rotation_period  = "7776000s"
    }
=======
    "log-sink" = {
      rotation_period  = "7776000s"
      depends_on       = [google_project_service_identity.logging]
    }
>>>>>>> REPLACE
```

> ### The Brand-New File Template Pattern
> When creating fresh files from scratch, state the full deployment path inside the `#FILE:` string tag, leave the `<<<<<<< SEARCH` section entirely empty, and dump the entire new configuration code block cleanly between the `=======` and `>>>>>>> REPLACE` markers. Running `ripapply` detects this profile structure, automatically constructs the missing directory hierarchy paths on your computer, and generates the file asset instantly.

---

### Usage:
```python
usage: repo_ripper.py [-h] [--copy] [--list] [--apply] target_dir

Repo Ripper v5.0 Lean - Secure AI Workspace Companion

positional arguments:
  target_dir  Path to target directory workspace.

optional arguments:
  -h, --help  show this help message and exit
  --copy      Harvest codebase tree map and inject strict system prompt constraints to clipboard.
  --list      Query upstream server to discover live active MR/PR tracking ID numbers.
  --apply     Surgically apply text-anchor SEARCH/REPLACE patches onto local disk files.
```
