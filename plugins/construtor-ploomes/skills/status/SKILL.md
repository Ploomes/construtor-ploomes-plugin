---
name: status
description: Mostra a conta conectada ao Construtor Ploomes, a pasta desta conversa, o artefato ativo e se a API do construtor está disponível. Use quando a pessoa perguntar "qual conta", "status" ou "está conectado?".
---

# Construtor Ploomes status

Call `mcp__plugin_construtor-ploomes_ploomes-construtor__account_info` and summarize it in a few lines, in Brazilian Portuguese (pt-BR):

- the account and the user (and, if it is a regular user, that their key changes every time they sign in);
- this conversation's folder;
- the artifacts on this machine and the active one;
- the builder API, Ploomes Flows and the harness (the installed version and, if the API already serves a newer one, that `atualizar_harness` fetches it).

If the tool answers that the account isn't connected, pass its message on, with the address of the Ploomes login page.
