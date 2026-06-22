# Repo Ripper (v3.10)

### Secure Local AI Context Harvester & Text-Anchor Execution Engine

Repo Ripper is a zero-dependency, local workspace companion designed for secure, air-gapped environment engineering. It solves two major compliance bottlenecks: securely gathering repository context for AI assistants without leaking sensitive credentials, and automatically applying code fixes to your workspace without manual copy-pasting or editor drift.

---

## Core Features & Architecture

* **Tokenless Remote Discovery:** Scrapes live merge/pull request references straight from the remote origin server without passing API tokens or checked-out branches.
* **The Secret Shield:** Automatically detects and blocks plaintext security assets (`.env`, `.tfvars`, `.pem`, private keys, cloud service account json files) from entering your clipboard string.
* **Diagnostic Crash Tracer:** Intercepts raw terminal logs, isolates failing code assets, and extracts matching localized code windows (+/-10 lines) for immediate debugging context.
* **Autonomous Write Layer:** Features an embedded Python execution parsing engine that translates text-anchor `SEARCH/REPLACE` strings directly into local code modifications, completely wiping browser space-encoding traps (`\xa0`) behind the scenes.

---

## Terminal Command Center Stack

Adding the proper profile mappings to your local environment grants access to these macro shortcuts:

### 1. Context Harvesting (Read-Only Matrix)
* `rip`: Runs a quick local sweep of the active directory hierarchy and includes primary top-level configurations.
* `ripc`: Captures the entire workspace frame **and automatically appends execution constraints** directly to your macOS clipboard. Use this before hopping into your AI chat window.
* `riplist`: Runs tokenless remote discovery to view all live open MR/PR IDs on the contract repository.
* `riprules`: Safely pulls down local compliance playbooks, lint specifications, and naming conventions into your active clipboard buffer.
* `ripsig`: Compiles a rapid interface summary of functions, global modules, and variable footprints.

### 2. Micro Triage & Code Analysis
* `ripmr <id>`: Pulls down a specific remote merge request delta, constructs a line-by-line patch analysis, and loads the code frame directly to your clipboard.
* `ripbreak <path/to/log.txt or raw text>`: Feeds runtime crash dumps directly to the script to isolate code breaks and pull immediate workspace frames.
* `vim hotkey (,c)`: While inside a source file, pressing `,c` pulls the full layout profile of that active buffer directly into your clipboard.

### 3. Agentic Modification (Active Write Layer)
* `ripapply`: Intercepts custom AI `SEARCH/REPLACE` text blocks sitting on your clipboard, checks integrity, and drops the modifications safely onto your computer's local disk files.

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

1. **Harvest:** Enter your branch and run `ripc`. Your context map and structural generation rules are now sitting on your clipboard.
2. **Consult:** Paste (**Cmd+V**) the context directly to the AI window and describe your ticket objective.
3. **Capture:** The AI generates a fix wrapped inside a strict markdown schema. Click **Copy** on that response block.
4. **Yeet:** Flip back to your terminal window and type `ripapply`. The script handles directory building, matching, and file updates instantly.

---

## The AI Structural Patch Template

Because your `ripc` command teaches the AI how your workspace operates, the model will always respond using this exact "text sandwich" template:

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
> If you are building a new project from scratch, the AI will specify the target file path in the `#FILE:` tag, leave the `<<<<<<< SEARCH` section entirely blank, and output the total new codebase structure inside the `REPLACE` frame. Running `ripapply` will automatically spawn the required directory tree and generate the fresh configuration asset seamlessly.
