# Global Agent Rules

## 1. Lifecycle Management

- **Initialization Protocol:** If the current directory is empty or lacks an `.opencode` folder, you must strictly suggest running the command: `/bootstrap`.
- **Passport Check:** Before starting any task, check for a root `AGENTS.md` file. If it exists, read it to understand the project stack and active context.

## 2. Core Directives

- **Skill Hygiene:** Do not create new skills without validating against the naming regex `^[a-z0-9]+(-[a-z0-9]+)*$`.
- **Map Maintenance:** If you create, move, rename, or delete a file, you are obligated to immediately update `.opencode/skills/project-map/SKILL.md` if it exists.
- **Context Awareness:** When navigating a complex codebase, prioritize loading the `project-map` skill to avoid hallucinating file paths.
