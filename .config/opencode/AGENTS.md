# Global Operating Procedure: Initialization and State Management

1. **Enforce Local Conventions:** Upon entering a new repository, check for `./AGENTS.md` in the root. If missing, create it. This file is strictly for project-specific coding conventions, style guides, and strict rule enforcement.
2. **Isolate Structural State:** Check for `./ARCHITECTURE.md` in the root. If missing, create it. This file is exclusively for mapping the directory tree, architectural decisions, and data flow.
3. **Continuous Synchronization:** You must immediately update the structure map in `./ARCHITECTURE.md` whenever you create, move, rename, or delete a file or directory.
4. **Targeted Context:** Do not read `./ARCHITECTURE.md` by default. Only read it when spatial awareness or structural context is explicitly required to complete the current task.
