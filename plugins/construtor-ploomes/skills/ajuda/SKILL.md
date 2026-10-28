---
name: ajuda
description: Explica o que dá para pedir ao Construtor Ploomes e os comandos do plugin. Use quando a pessoa pedir "ajuda", "ajuda do construtor" ou "o que você faz".
---

# Construtor Ploomes help

Answer in Brazilian Portuguese (pt-BR), in a few lines, and cover:

- What the person can ask for in the conversation: a **screen** (tela) inside the CRM, a **CPQ form** (formulário de CPQ) for a document template, a question about the account's settings, continuing an artifact that already exists in the CRM chat, viewing and **restoring versions** (restaurar versões), and **publishing** (publicar).
- That the preview appears on a local page in the browser, with the version status and the Publish (Publicar) button; that each turn that changes the folder becomes a version in the account on its own; and that publishing always asks for confirmation.
- The plugin's commands: `/construtor-ploomes:conectar` (connect the account), `/construtor-ploomes:artefatos` (what already exists), `/construtor-ploomes:status` (the account and the active artifact) and `/construtor-ploomes:ajuda`.
- That the account connects through the Construtor Ploomes login in the browser, where the person pastes the User-Key of an integration user. To switch accounts, call `mcp__plugin_construtor-ploomes_ploomes-construtor__conectar_conta` with `trocar: true`; to sign out, call `mcp__plugin_construtor-ploomes_ploomes-construtor__desconectar_conta`. The new account applies on the next tool call, without restarting Claude Code.
- That flows and automations are built in the account's Ploomes Flows, when the account has that module, and that the page's Flows drawer (Fluxos) shows the screen's flows (or the account's, when no artifact is active) and opens the flow in the Flows app.
- That a conflict with the account (someone saved through the CRM chat after the folder's base) stops saving until the person chooses between bringing the account's version and saving over it; and that the build instructions come from the Ploomes harness, which `atualizar_harness` refreshes.
