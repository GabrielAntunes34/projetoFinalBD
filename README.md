# ProjetoFinalBD
Projeto final da disciplina SCC0240, Bases de Dados, consistindo em modelar, documentar e implementar uma base de dados relacional para um sistema online de gerenciamento de uma instituição de ensino.

## Arquivos

- `tables.sql` – Criação das tabelas principais
- `index.sql` – Criação de índices e constraints
- `populate.sql` – Inserção de dados iniciais
- `views.sql` – Criação de views
- `queries.sql` – Consultas de teste ou relatório

## Pré-requisitos

- PostgreSQL instalado e funcionando
- pgAdmin 4 instalado (disponível em https://www.pgadmin.org/download/)

## Como executar os scripts

### 1. Abrir o pgAdmin 4
- Inicie o pgAdmin 4 e conecte-se ao seu servidor PostgreSQL.
- Use o nome de usuário `postgres` (ou o que estiver configurado em sua máquina).

### 2. Criar a base de dados
1. No painel esquerdo, expanda o servidor conectado.
2. Clique com o botão direito em **Databases → Create → Database...**
3. Dê um nome à base e clique em **Save**.

### 3. Executar os arquivos `.sql` em ordem

Para cada um dos arquivos abaixo:

1. Clique com o botão direito na base criada e selecione **Query Tool**.
2. No menu superior, vá em **File → Open** e selecione o arquivo `.sql` correspondente.
3. Clique no botão **Executar**.
4. Aguarde a mensagem de sucesso antes de passar para o próximo.

#### Ordem recomendada:

1. `tables.sql`
2. `index.sql`
3. `populate.sql`
4. `views.sql`
5. `queries.sql`

### 4. Verificar se os dados foram inseridos
- Expanda: `nome_do_banco → Schemas → public → Tables`  
- Clique com o botão direito sobre uma tabela e selecione **View/Edit Data → All Rows** para visualizar os dados.
