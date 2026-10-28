# Construtor Ploomes

Plugin do Claude Code para construir no CRM de um cliente da Ploomes conversando. Você pede uma tela, um formulário de CPQ, uma configuração da conta ou um fluxo, e o agente constrói. A prévia abre numa página local. Cada turno em que o agente escreve na pasta vira uma versão na conta, e a publicação é um botão na página, que sempre pede confirmação.

## Instalar

No Claude Code:

```
/plugin marketplace add Ploomes/construtor-ploomes-plugin
/plugin install construtor-ploomes@construtor-ploomes
```

Depois, rode `/reload-plugins` ou abra uma conversa nova, para o plugin carregar.

Instalar não pede login. A página de login abre no seu primeiro pedido ao Construtor, ou quando você roda `/construtor-ploomes:conectar`.

Se a sua organização já cadastrou este marketplace, o Construtor Ploomes aparece direto na lista de plugins do Claude Code. Nesse caso, não instale também pelo terminal: as duas cópias aparecem lado a lado na lista de plugins.

### No Claude Code Desktop

O Desktop usa os plugins instalados no Claude Code da mesma máquina. Instale pelo terminal, com os comandos acima, e abra uma conversa nova no Desktop. Lá, a página de login e a página do Construtor abrem no painel Browser, ao lado da conversa, e não no navegador.

## O que você precisa

- **Claude Code.**
- **Um usuário de integração na conta do cliente, com perfil de administrador.** Ele fica em Ploomes › Administração › Usuários de integração. A User-Key desse usuário vai na página de login da Ploomes, que o plugin abre no navegador (no Desktop, no painel Browser). Ela nunca vai na conversa.
- **Node.js: não precisa instalar.** O plugin procura um Node 20.19 ou 22.12 (ou mais novo) na máquina. Se não achar, baixa o Node oficial, confere o hash (sha256) do arquivo e usa essa cópia.

## Como começar

1. Abra o Claude Code numa pasta vazia, que vai guardar o que você construir.
2. Peça o que quer, por exemplo "uma tela com os negócios abertos do mês".
3. Na primeira vez, a página de login da Ploomes abre no navegador. Cole a User-Key e confirme. Para conectar antes de pedir algo, rode `/construtor-ploomes:conectar`.

Enquanto nenhuma conta estiver conectada, o Claude Code avisa disso ao abrir: na primeira conversa depois de instalar e, depois, nas conversas abertas numa pasta vazia ou numa pasta do Construtor.

Comandos do plugin:

- `/construtor-ploomes:conectar`: abre a página de login da Ploomes.
- `/construtor-ploomes:ajuda`: o que dá para pedir e os comandos.
- `/construtor-ploomes:artefatos`: as telas e os formulários de CPQ da conta.
- `/construtor-ploomes:status`: a conta conectada, a pasta e a tela ativa.

## Atualizações

O Claude Code atualiza o plugin pelo marketplace. A versão nova vale na sessão seguinte.

## Sobre este repositório

Este repositório só recebe as versões publicadas do plugin. O código-fonte fica num repositório interno da Ploomes. Para dúvidas ou problemas, fale com a Ploomes.

## Licença

Uso restrito. Veja o arquivo [LICENSE](LICENSE).
