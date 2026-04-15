---
name: deepwiki
description: This skill should be used when the user mentions a "GitHub repository", provides a "github.com" URL, uses "owner/repo" format, asks to "explain a codebase", "how does this repo work", "what is the architecture of X", "how is X implemented", "tell me about" an open-source project, asks to compare how multiple open-source projects implement a feature, or needs documentation about a library's internals. Also use when the user invokes /deepwiki.
version: 0.1.0
argument-hint: "[owner/repo] [question]"
allowed-tools:
  - mcp__plugin_deepwiki_deepwiki__read_wiki_structure
  - mcp__plugin_deepwiki_deepwiki__read_wiki_contents
  - mcp__plugin_deepwiki_deepwiki__ask_question
---

# DeepWiki - GitHub Repository Documentation

Query documentation for any public GitHub repository using DeepWiki MCP tools. DeepWiki provides auto-generated, AI-powered documentation covering architecture, code structure, and implementation details. No authentication required.

## Repository Detection

Extract the repository identifier from user input. Normalize to `owner/repo` format:

| Input Format | Example | Extracted |
|---|---|---|
| Full URL | `https://github.com/vercel/next.js` | `vercel/next.js` |
| Short URL | `github.com/facebook/react` | `facebook/react` |
| Shorthand | `denoland/deno` | `denoland/deno` |
| With path | `github.com/owner/repo/blob/main/src/index.ts` | `owner/repo` |

Strip trailing slashes, query parameters, and path segments beyond `owner/repo`.

## Tool Selection

Choose based on the user's intent:

### Broad Exploration

User wants to understand a repository overall, browse docs, or "tell me about X":

1. Call `mcp__plugin_deepwiki_deepwiki__read_wiki_structure` with `repoName`
2. Present the outline as a navigable list
3. Offer to deep-dive into specific topics

### Specific Question

User asks a direct question about a repository:

1. Call `mcp__plugin_deepwiki_deepwiki__ask_question` with `repoName` and `question`
2. Present the AI-powered answer

### Deep Reading

User wants comprehensive docs on a repository:

1. Call `mcp__plugin_deepwiki_deepwiki__read_wiki_contents` with `repoName`
2. Present and summarize the documentation content

### Prefer `ask_question` for specific queries

When the user asks "how does X work" or "what is the architecture of Y", use `ask_question` directly. It provides the most targeted, context-grounded answers.

## Slash Command Handling

When invoked via `/deepwiki`:

- **With repo + question** (`/deepwiki vercel/next.js how does routing work?`): use `ask_question`
- **With repo only** (`/deepwiki vercel/next.js`): use `read_wiki_structure` to show the outline
- **No arguments** (`/deepwiki`): ask the user which repository to query

## Response Format

Structure all responses:

1. State the repository (`owner/repo`)
2. Present information organized by topic or relevance
3. Include architecture descriptions and code references when available
4. Suggest follow-up queries when appropriate

## Guidelines

- Always extract `owner/repo` before making any tool call
- Do not fabricate repository information -- rely solely on DeepWiki tool results
- If a tool call fails, suggest verifying the repository name and that it is public
- For multi-repo comparisons, call tools for each repo and synthesize
- When the user mentions a well-known library without specifying the repo, infer the GitHub repo if confident (e.g., "React" → `facebook/react`, "Next.js" → `vercel/next.js`)

## Additional Resources

### Reference Files

- **`references/tool-usage.md`** - Complete parameter reference, usage examples, workflow patterns, and error handling for all three DeepWiki MCP tools
