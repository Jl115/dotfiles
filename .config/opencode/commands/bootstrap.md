---
description: Auto-detect stack, generate Guidelines, create a Living Architecture Map, and enforce Agent Identity.
agent: build
---

# Bootstrap Project Ecosystem

You are an expert Software Architect. Your task is to analyze the codebase and generate three critical artifacts: the **Guidelines Skill** (Rules), the **Architecture Skill** (Map), and the **Agent Identity** (Enforcement).

## Phase 1: Deep Analysis

1.  **Scan Configuration Files:** Read `package.json`, `pubspec.yaml`, `pom.xml`, `requirements.txt`, etc.
2.  **Determine Variables:**
    - `{{project_name}}`: The name of the project (e.g., `floriplan`).
    - `{{stack}}`: The full technology stack (e.g., "Node.js + Vue 3").
    - `{{architecture_style}}`: The industry standard architecture (e.g., "Modular Monolith", "Clean Architecture").
    - `{{state_management}}`: The best practice library (e.g., "Pinia", "Bloc").
    - `{{di_tool}}`: Dependency injection tool.
    - `{{db_tool}}`: Database/ORM tool.

## Phase 2: Create "Guidelines" Skill (The Rules)

Create the directory `.opencode/skills/{{project_name}}-guidelines/`.
Inside, create `SKILL.md` with the following content:

```markdown
---
name: {{project_name}}-guidelines
description: CRITICAL framework rules, coding standards, and commands for {{project_name}}.
---

# {{project_name}} Technical Guidelines

## Project Overview

- **Stack:** {{stack}}
- **Architecture Pattern:** {{architecture_style}}

## Core Rules

1.  **Structure:** Follow {{architecture_style}} strictly.
2.  **State Management:** MUST use {{state_management}}.
3.  **Database:** Use {{db_tool}} for data access.

## Commands

- **Build:** `<insert_build_command>`
- **Test:** `<insert_test_command>`
- **Lint:** `<insert_lint_command>`
  Phase 3: Create "Architecture" Skill (The Map)
  Action: Scan the current file structure (excluding node_modules, .git, dist, build).
  Create the directory .opencode/skills/{{project_name}}-architecture/.
  Inside, create SKILL.md with the following content based on your scan:

## {{project_name}}-architecture

name: {{project_name}}-architecture
description: A living map of the project structure, modules, and data flow. Read this to navigate. UPDATE THIS when adding files/modules.

---

# {{project_name}} Architecture Map

This file documents the high-level structure of the application.

## High-Level Directory Tree

_(Insert a Markdown tree of the current src/lib structure here)_
_(Example:)_

- `src/`
  - `modules/`
    - `auth/` - Authentication logic
    - `dashboard/` - Main view

## Key Modules & Responsibilities

_(Describe the main folders and what belongs in them based on the detected {{architecture_style}})_

## Data Flow

_(Briefly describe how data moves, e.g., Repository -> Service -> Controller -> View)_
Phase 4: Create Agent Identity (AGENTS.md)
Create (or overwrite) the file AGENTS.md in the root directory.
Use this exact format:

# {{project_name}} - AI Agent Identity

You are an expert **{{stack}}** developer working on the **{{project_name}}** project.

## CRITICAL: Mandatory Skill Workflow

You have two custom skills that serve as your "Brain" and "Map". You **MUST** use them as follows:

### 1. The Rules (`{{project_name}}-guidelines`)

Trigger this skill **BEFORE** writing code to check:

- Coding standards and naming conventions.
- Correct build/test commands.
- Framework-specific patterns ({{architecture_style}}).

### 2. The Map (`{{project_name}}-architecture`)

Trigger this skill **BEFORE** creating files to understand where they belong.

- **READ** this skill to find existing modules and services.
- **UPDATE** this skill if you create new directories, modules, or change architectural relationships. **Keep the map execution-ready.**

## Core Project DNA (Do Not Deviate)

- **Architecture:** {{architecture_style}}.
- **State Management:** {{state_management}}.
- **Tooling:**
  - Dependency Injection: **{{di_tool}}**
  - Database: **{{db_tool}}**

Do not guess directory structures. If you are unsure, consult the `{{project_name}}-architecture` skill.
```
