# DeepWiki Tool Usage Reference

Detailed parameter reference and usage patterns for the three DeepWiki MCP tools.

## Tool Naming

All tools prefixed as: `mcp__plugin_deepwiki_deepwiki__<tool_name>`

This document uses short names for brevity.

## Tool 1: read_wiki_structure

Retrieve the documentation topic structure for a GitHub repository. Returns a hierarchical outline of all available documentation topics.

### When to Use

- First contact with a new repository
- Browsing available documentation before diving deep
- Getting a high-level overview of a codebase
- Identifying relevant sections for targeted reading

### Parameters

- `repoName` (string, required): Repository in `owner/repo` format

### Example

```
read_wiki_structure(repoName="vercel/next.js")
```

Returns a structured outline covering the repository's architecture, components, patterns, and configuration.

### Interpreting Results

The structure reveals high-level architecture topics, component documentation, pattern guides, and configuration topics. Use discovered section names as input for `read_wiki_contents`.

## Tool 2: read_wiki_contents

Read the full documentation content for a GitHub repository's wiki.

### When to Use

- Reading documentation in full detail
- Getting comprehensive information about a repository
- Deep-diving into a topic discovered via `read_wiki_structure`

### Parameters

- `repoName` (string, required): Repository in `owner/repo` format

### Example

```
read_wiki_contents(repoName="facebook/react")
```

Returns detailed documentation content covering the repository.

### Workflow

Typical exploration flow:
1. `read_wiki_structure` to discover topics
2. `read_wiki_contents` to read full documentation
3. `ask_question` for specific follow-up queries

## Tool 3: ask_question

Ask a natural-language question about a GitHub repository and receive an AI-powered, context-grounded answer. The most flexible and powerful tool.

### When to Use

- Answering specific technical questions about a codebase
- Understanding implementation details
- Getting targeted explanations without reading entire docs
- Comparing approaches within a repository

### Parameters

- `repoName` (string, required): Repository in `owner/repo` format
- `question` (string, required): Natural-language question to ask

### Examples

**Architecture question:**

```
ask_question(
  repoName="vercel/next.js",
  question="How does the App Router handle server components differently from the Pages Router?"
)
```

**Implementation question:**

```
ask_question(
  repoName="denoland/deno",
  question="How does Deno's permission system work?"
)
```

**Usage question:**

```
ask_question(
  repoName="supabase/supabase",
  question="What is the recommended pattern for row-level security policies?"
)
```

### Tips for Best Results

- Be specific in the question for targeted answers
- Include context about what aspect interests the user
- Reference specific features or components by name
- Ask one question at a time

## Common Workflow Patterns

### Pattern: New Repository Exploration

```
User: "Tell me about the architecture of tokio-rs/tokio"

1. read_wiki_structure(repoName="tokio-rs/tokio")
   → Present documentation outline

2. User selects a topic

3. ask_question(repoName="tokio-rs/tokio", question="<specific topic>")
   → Present detailed answer
```

### Pattern: Quick Answer

```
User: "How does React's reconciliation algorithm work?"

1. ask_question(
     repoName="facebook/react",
     question="How does the reconciliation algorithm work?"
   )
   → Present AI-generated answer
```

### Pattern: Comparative Research

```
User: "Compare how Vite and Webpack handle hot module replacement"

1. ask_question(repoName="vitejs/vite", question="How does Vite implement HMR?")
2. ask_question(repoName="webpack/webpack", question="How does Webpack implement HMR?")
3. Synthesize and compare both answers
```

### Pattern: Slash Command (`/deepwiki`)

```
/deepwiki vercel/next.js
→ read_wiki_structure, present outline

/deepwiki vercel/next.js how does routing work?
→ ask_question with the specific question

/deepwiki
→ Ask user which repository to query
```

## Error Handling

### Repository Not Found

- Verify `owner/repo` format is correct
- Check that the repository exists and is public
- Suggest the user confirm the repository name

### Empty Results

- The repository may be very new with limited documentation
- Try switching tools (e.g., `read_wiki_structure` → `ask_question`)
- Suggest a more specific question

### Rate Limiting

- Wait a moment before retrying
- Suggest the user try again shortly
- Reduce concurrent queries
