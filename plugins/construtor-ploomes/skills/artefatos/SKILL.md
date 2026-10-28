---
name: artefatos
description: Lista os artefatos da conta conectada ao Construtor Ploomes (telas e formulários de CPQ), os desta máquina e os do chat do CRM, com o ativo marcado. Use quando a pessoa pedir "meus artefatos", "o que já fiz" ou "listar telas".
---

# Account artifacts

1. Call `mcp__plugin_construtor-ploomes_ploomes-construtor__list_artifacts` once, with no `source`: it lists this machine and the account together. If the person asked only for one kind of CPQ form (proposta, venda, documento de cliente, documento de negócio), pass `templateKind`.
2. Answer in two groups, **Telas** and **Formulários de CPQ** (only the forms when you passed `templateKind`), with the counts the tool gives; never count the lines yourself. In each group, list first the ones on this machine, marking the active one, and then the ones that exist only in the CRM, saying they can be continued here. For each CPQ form, say its document template, and whether it is published or a draft when the tool says so.
3. If a tool answers that the account isn't connected, pass its message on, with the address of the Ploomes login page.

Keep the answers short and in Brazilian Portuguese (pt-BR).
