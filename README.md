# Repo Ripper (v5.0 Lean)

### Secure Local AI Context Harvester & Minimalist Execution Engine

Repo Ripper is a zero-dependency, native Python CLI workspace companion engineered specifically for secure, air-gapped environments. It solves the critical trade-off between AI leverage and compliance by harvesting precise codebase context frames for Large Language Models and safely executing code updates locally via a line-agnostic text-anchor engine—all without installing external binaries, running heavy daemons, or streaming repository telemetry outside your network boundary.

---

## Core System Architecture

* **Standard Library Blueprint:** Built entirely inside a single native Python 3 framework, eliminating fragile multi-layered shell escaping and script wrapper nesting.
* **The Secret Shield:** Automatically bypasses hidden vendor directories, local environment configs, and fat dependency caches (`.git`, `.terraform`, `.tofu`, `node_modules`, `venv`) to ensure instantaneous execution and prevent binary tracking drops.
* **Indentation Defense:** Natively cleans web browser byte artifacts (`\xa0`) during clipboard ingestion, preserving flawless indentation tracking across whitespace-sensitive infrastructure configurations (YAML, Python, Terraform).
* **Line-Agnostic Engine:** Updates code using contextual string match-blocks rather than line numbers (`@@`), remaining 100% resilient even if files drift or shift elsewhere during a sprint.

---

## Terminal Command Center Stack

Adding the lightweight profile mappings to your local environment grants immediate macro access to these core primitives:

### 1. Read-Only Context Harvesting
* `ripc`: Captures your localized workspace directory structure and **automatically appends strict system prompt parameters** straight to your macOS clipboard. Use this before jumping into an AI chat window.
* `riplist`: Queries remote branches to instantly view open MR/PR tracker IDs on the contract tracking server without requiring API tokens or checking out remote branches locally.

### 2. Agentic Write Modifications
* `ripapply`: Intercepts structured text-patches sitting on your clipboard, verifies structural integrity, auto-creates folders if building an architectural block from scratch, and cleanly drops modifications onto local disk files.

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

1. **Harvest:** Open your branch terminal and run `ripc`. Your context footprint and prompt constraints are now loaded on your clipboard.
2. **Consult:** Paste (**Cmd+V**) the payload directly to the AI window and describe your ticket objective.
3. **Capture:** The AI writes out a modification wrapped inside the exact text-anchor block format. Click **Copy** on that response window.
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

> ### 💡 The Scratch File Pattern
> When creating brand-new files from scratch, the AI will state the target path in the `#FILE:` tag, leave the `<<<<<<< SEARCH` section entirely blank, and output the total new architecture layout inside the `REPLACE` section. Running `ripapply` detects this pattern, automatically constructs the missing directory tree paths, and spawns the fresh file asset onto your computer cleanly.
