# DeepWiki Plugin for Claude Code

Query documentation for any public GitHub repository using [DeepWiki](https://deepwiki.com).

## Features

- **Repository exploration** -- Browse documentation structure of any GitHub repo
- **Deep reading** -- Read comprehensive documentation content
- **AI-powered Q&A** -- Ask natural-language questions about any repository
- **Auto-trigger** -- Activates when GitHub repositories are mentioned in conversation
- **Slash command** -- `/deepwiki [owner/repo] [question]` for direct queries

No authentication required. Works with any public GitHub repository.

## Installation

```bash
 claude plugin marketplace add https://github.com/cndoit18/deepwiki.git
 claude plugin install deepwiki@deepwiki-marketplace
```

## Usage

### Automatic Activation

The plugin activates when you mention a GitHub repository:

- "Tell me about the architecture of `vercel/next.js`"
- "How does `https://github.com/facebook/react` handle state management?"
- "Explain the plugin system in `webpack/webpack`"

### Slash Command

```
/deepwiki owner/repo
/deepwiki owner/repo how does the build system work?
```

### MCP Tools

| Tool                  | Purpose                                     |
| --------------------- | ------------------------------------------- |
| `read_wiki_structure` | Get documentation outline for a repository  |
| `read_wiki_contents`  | Read detailed documentation content         |
| `ask_question`        | Ask a question and get an AI-powered answer |

Verify with `/mcp` after installation.

## Limitations

- Only works with public GitHub repositories
- Documentation quality depends on repository size and structure
