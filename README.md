# LineupSI# Lineup Studio — publicação na Vercel

O site é um único arquivo (`index.html`), sem build. O banco e o armazenamento de fotos e vídeos já estão no Supabase (projeto **ScheduleSI**).

## 1. Ajustes no Supabase (2 minutos)

No painel do projeto, em **Authentication**:

1. **Sign In / Providers → Email**: desligue **Confirm email**. Assim a conta criada já entra direto.
2. Depois do passo 3 (primeiro acesso), volte em **Sign In / Providers** e desligue **Allow new users to sign up**. Isso impede que outras pessoas criem conta.
3. Depois de publicar, em **URL Configuration**, coloque o endereço da Vercel em **Site URL**.

## 2. Publicar na Vercel

**Opção A — GitHub (recomendada)**
1. Crie um repositório no GitHub e envie o `index.html` para a raiz dele.
2. Em vercel.com/new, importe o repositório.
3. Em **Framework Preset**, escolha **Other**. Deixe Build Command e Output Directory vazios.
4. Clique em **Deploy**.

**Opção B — linha de comando**
```
npm i -g vercel
cd pasta-com-o-index.html
vercel --prod
```

## 3. Primeiro acesso (você vira o editor)

1. Abra o site, vá na aba **Projetos** e role até **Conta de editor**.
2. Digite e-mail e senha e clique em **Criar conta**.
3. A **primeira** conta que entrar vira a única com permissão de editar. Faça isso logo após publicar.
4. Quem abre o link sem entrar só vê o conteúdo salvo: não consegue alterar nada.

## 4. Uso do dia a dia

- Envie a foto (e o vídeo, se quiser) de cada jogador **uma vez**. A mídia fica ligada ao jogador e já vem preenchida em todo projeto novo.
- **Salvar projeto** grava a escalação completa na nuvem. Ela aparece em qualquer navegador.
- Vídeos: MP4 ou WebM, até 50 MB cada.

## Observações

- A chave que está no `index.html` é a chave pública (anon) do Supabase. Ela foi feita para ficar no navegador; a proteção real está nas regras do banco, que só deixam o editor gravar.
- Projetos que você montou na versão anterior (link do Claude) não vêm junto: as fotos antigas ficaram lá. Reenvie as fotos uma vez nesta versão.