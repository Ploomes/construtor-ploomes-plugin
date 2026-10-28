---
name: conectar
description: Conecta a conta da Ploomes ao Construtor Ploomes, abrindo a página de login no navegador. Use quando a pessoa pedir "conectar", "fazer login", "autenticar" ou "como eu autentico".
---

# Connect the Construtor Ploomes account

Call `mcp__plugin_construtor-ploomes_ploomes-construtor__conectar_conta` without arguments and answer in Brazilian Portuguese (pt-BR), in a few lines:

- If it opened the login page, pass its message on with the page address. Tell the person to paste there the User-Key of an integration user of the customer's account, and to come back when the page says "Conta conectada". Never ask for the key in the conversation.
- If the account is already connected, say which account and user. Ask whether they want to switch to another one, and only if they say yes, call `conectar_conta` with `trocar: true`.
