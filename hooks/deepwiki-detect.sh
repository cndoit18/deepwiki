#!/usr/bin/env bash
prompt=$(jq -r .prompt 2>/dev/null)

shopt -s nocasematch
if [[ "$prompt" =~ github ]]; then
	ctx=$(cat "$(dirname "$0")/deepwiki-prompt.md")
	jq -n --arg ctx "$ctx" \
		'{"hookSpecificOutput":{"hookEventName":"UserPromptSubmit","additionalContext":$ctx}}'
fi
