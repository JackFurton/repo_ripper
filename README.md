# Repo Ripper (v4.0 Enterprise)

### Secure Local AI Context Harvester & Text-Anchor Execution Engine

Repo Ripper is a zero-dependency, native Python CLI workspace companion engineered specifically for secure, air-gapped environments. It solves the critical trade-off between leverage and compliance by harvesting precise codebase context frames for Large Language Models and safely executing code updates locally via a line-agnostic text-anchor engine—all without installing insecure external binaries or streaming repository telemetry outside your network boundary.

---

## Core System Architecture

* **Object-Oriented Execution Base:** Built using a purely native Python 3 standard library framework, completely eliminating fragile shell escaping and multi-layered string interpreter nesting.
* **Tokenless Remote Tracking:** Scrapes open pull/merge requests directly off the tracking origin server, building line-by-line patch analysis grids into your context without storing or passing API tokens.
* **The Secret Shield:** Features localized security hooks that scan and automatically suppress plaintext credential assets (`.env`, `.tfvars`, `.pem`, private keys, cloud service account json blocks) from entering the clipboard buffer.
* **Indentation & Byte-Trap Defense:** Natively strips out non-breaking web browser byte artifacts (`\xa0`) during clipboard ingestion, maintaining flawless indentation structures across whitespace-sensitive files (YAML, Python, Terraform).
* **Line-Agnostic Engine:** Completely bypasses traditional diff coordinate line numbers (`@@ -1,5 +1,12 @@`), utilizing string match-blocks that remain 100% resilient even if a file shifts or changes elsewhere.

---

## Terminal Command Center Stack

Exposing the platform shortcuts inside your environment grants lightning-fast macro access:

### 1. Read-Only Context Harvesting
* `rip`: Runs a swift localized inventory sweep of your directory tree and reads top-level module maps.
* `ripc`: Captures your full codebase structure and **automatically appends strict systemic prompt parameters** directly to your macOS clipboard. Use this before jumping to your AI window.
* `riplist`: Queries remote branches to instantly view open MR/PR tracker IDs on the contract server.
* `riprules`: Gathers engineering compliance playbooks, lint configurations, and naming criteria into your pasteboard buffer.
* `ripsig`: Compiles a rapid interface summary of variables, functions, and exposed module layouts.

### 2. Micro Triage & Code Analysis
* `ripmr <id>`: Evaluates a specific remote merge request delta, maps out line changes, and loads the context straight to your clipboard.
* `ripbreak <path/to/log.txt or raw text>`: Feeds terminal error stack traces directly into the engine to automatically isolate breaking code frames and extract matching localized code windows (+/-10 lines).
* `Vim Hotkey (,c)`: Pressing `,c` while inside a Vim buffer instantly extracts that file's full profile map into your clipboard workspace.

### 3. Agentic Write Modifications
* `ripapply`: Intercepts structured AI text-patches sitting on your clipboard, verifies structural integrity, auto-creates folders if building a project from scratch, and cleanly drops the updates onto your computer's disk.

---

## The Operational Workflow Loop

```text
       [ Terminal ] --------( 1. ripc )-------> [ Mac Clipboard ]
            ^                                          │
            │                                     ( 2. Cmd+V )
            │                                          ▼
     ( 4. ripapply )                             [ AI Workspace ]
            │                                          │
            │                                    ( 3. Copy Fix )
            └─────────── [ Mac Clipboard ] <───────────┘
```

1. **Harvest:** Navigate into your branch and run `ripc`. Your context footprint and prompt constraints are now loaded on your clipboard.
2. **Consult:** Paste (**Cmd+V**) the payload directly to the AI window and describe your ticket objective.
3. **Capture:** The AI writes out a modification wrapped inside your exact text-anchor block format. Click **Copy** on that response window.
4. **Execute:** Return to your local terminal and run `ripapply`. The script instantly synchronizes the file layouts on disk.

---

## The AI Structural Patch Template

Because your `ripc` execution teaches the model how your workspace operates, the AI will always respond utilizing this exact, merge-conflict-inspired text schema:

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

> ### The Scratch File Pattern
> When creating brand-new files from scratch, the AI will state the path in the `#FILE:` tag, leave the `<<<<<<< SEARCH` section entirely blank, and output the total new architecture layout inside the `REPLACE` section. Running `ripapply` detects this pattern, automatically constructs the missing directory tree paths, and spawns the fresh file asset onto your computer cleanly.
