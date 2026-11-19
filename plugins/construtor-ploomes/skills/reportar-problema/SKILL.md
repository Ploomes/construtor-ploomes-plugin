---
name: reportar-problema
description: Envia ao time da Ploomes esta conversa e o registro do Construtor Ploomes, para investigarem um problema. A pessoa confirma o envio na página do Construtor. Use quando a pessoa pedir "reportar problema", "reportar erro", "mandar para o suporte" ou disser que o construtor fez algo errado e quer avisar a Ploomes.
argument-hint: "[o que deu errado]"
---

# Report a problem to the Ploomes team

The person wants the Ploomes team to look into something that went wrong. The report sends this conversation and the plugin's log, and it leaves only after the person confirms on the Construtor Ploomes page.

1. Take what went wrong from the person's own words: the text after the command (`$ARGUMENTS`), or what they said in the conversation. Do not ask for more detail, and do not write a diagnosis of your own in its place: the team reads the conversation itself.
2. In the same message, before the call, tell the person in Brazilian Portuguese (pt-BR) that the confirmation is on the Construtor Ploomes page (in Claude Desktop, the Browser panel), that it says what will be sent, and that nothing is sent until they confirm there.
3. Call `mcp__plugin_construtor-ploomes_ploomes-construtor__reportar_problema`, with `descricao` set to the person's words when they gave any.
4. If the tool answers that the question is on the page, follow what it says, and call it again with the same arguments when it asks you to. Never answer the confirmation yourself.
5. When it returns the report code, give the code to the person and tell them to also open a ticket with Ploomes support through the channel they already use, with the code: the report alone notifies no one. If the person did not confirm, say that nothing was sent.
