# Lineup Studio

Plataforma web para **montar e apresentar escalações esportivas** no estilo das transmissões de TV. De um lado fica o campo tático; do outro, os jogadores em destaque, com foto ou vídeo. Funciona para **futebol de campo, Fut 7 e futsal**.

O resultado serve para transmissões, vídeos de apresentação do time e redes sociais.

## O que ela faz

- **Três modalidades**, cada uma com seu campo e suas formações prontas, mais formação **livre** (arraste os jogadores no campo).
  - Futebol de campo: 4-3-3, 4-4-2, 4-2-3-1, 3-5-2, 3-4-3, 4-1-4-1 e outras.
  - Fut 7: 3-2-1, 2-3-1, 2-2-2, 3-1-2 e outras.
  - Futsal: 3-1, 4-0, 2-2, 1-2-1 e outras.
- **Apresentação animada**: cada jogador aparece primeiro **grande, em destaque**, e depois desliza para o seu card. O vídeo do jogador, se houver, toca durante o destaque. Há três modos (destaque e depois card, só destaque, todos de uma vez), ordem e velocidade ajustáveis, e pausa.
- **Elenco e reservas** com número, nome, nome na camisa, posição, foto e vídeo. É possível substituir titulares por reservas.
- **Personalização**: temas, cores, tipografia, estilo do campo, layout, tamanho das fotos, animação e posição da faixa de informações.
- **Formatos**: 16:9, 9:16, 1:1 e 4:3.
- **Saída**: tela cheia, modo **sem botões** para gravação, imagem **PNG** em alta resolução e gravação da apresentação em vídeo (.webm).
- **Nuvem**: projetos, fotos e vídeos ficam guardados no Supabase. A mídia fica ligada ao jogador e já vem preenchida em todo projeto novo.

## Como usar

O site tem cinco abas na lateral e uma barra com o formato e os botões de apresentar.

1. **Projetos**: salva e reabre escalações, cria projetos novos e faz o login do editor.
2. **Jogadores**: nome do time, escudo, modalidade, titulares e reservas. Cada jogador tem os botões 📷 (foto) e 🎬 (vídeo) e um campo para trocar com outro jogador.
3. **Formação**: escolha a formação e arraste os jogadores no campo. Também define a ordem e o modo da apresentação.
4. **Estilo**: tema, cores, fonte, campo, layout, animação, velocidade e tempo do vídeo em destaque.
5. **Exportação**: formato, imagem PNG, gravação de vídeo e tela cheia.

**Para apresentar:** clique em **▶ Apresentar**. Para uma apresentação limpa, use **🎬 Sem botões**: o site entra em tela cheia e começa sozinho depois de 3 segundos, sem nenhum botão na tela (dá tempo de iniciar a gravação de tela).

**Atalhos na tela cheia**

| Tecla | Ação |
|---|---|
| Espaço | Pausa e retoma |
| Enter | Reinicia a apresentação |
| C | Mostra ou esconde os controles |
| Esc | Sai da tela cheia |

## Como funciona o salvamento

- Quem **não está logado** vê tudo, mas não altera nada.
- O **editor** (uma conta de e-mail e senha) envia fotos e vídeos e salva projetos. A **primeira** conta que entrar vira a única com permissão de edição.
- Fotos e vídeos vão para o Storage do Supabase. O projeto salvo guarda só os endereços deles.
- Sem login, o site salva só no navegador (sem fotos na nuvem).

## Tecnologias

- HTML, CSS e JavaScript puro, em um único arquivo (`index.html`), sem build.
- [Supabase](https://supabase.com): banco Postgres, Storage e Auth.
- [html2canvas](https://html2canvas.hertzen.com) para exportar PNG.
- [Vercel](https://vercel.com) para hospedar.

## Estrutura do repositório

```
index.html              # o site inteiro
supabase/schema.sql     # tabelas, regras de acesso e pasta de mídia
README.md
```

## Instalação

### 1. Supabase

1. Crie um projeto em supabase.com.
2. No **SQL Editor**, rode o conteúdo de `supabase/schema.sql`.
3. Em **Project Settings → API**, copie a **Project URL** e a chave **anon**.
4. Abra o `index.html`, procure por `const CFG=` e cole a URL e a chave.
5. Em **Authentication → Sign In / Providers → Email**, desligue **Confirm email**.

### 2. Vercel

**Pelo GitHub (recomendado)**
1. Envie este repositório para o GitHub.
2. Em vercel.com/new, importe o repositório.
3. Em **Framework Preset**, escolha **Other**. Deixe Build Command e Output Directory vazios.
4. Clique em **Deploy**.

**Pela linha de comando**
```
npm i -g vercel
vercel --prod
```

Para testar localmente, abra o `index.html` no navegador ou rode `npx serve`.

### 3. Primeiro acesso

1. Abra o site, vá em **Projetos** e role até **Conta de editor**.
2. Informe e-mail e senha e clique em **Criar conta**. Faça isso logo após publicar: a primeira conta vira o editor.
3. No Supabase, em **Authentication → Sign In / Providers**, desligue **Allow new users to sign up**. Em **URL Configuration**, coloque o endereço da Vercel em **Site URL**.
4. Envie a foto de cada jogador uma vez. Depois disso ela vem preenchida em todo projeto novo.

## Como alterar o elenco

O elenco inicial está na constante `RAW` do `index.html`. Cada linha segue este formato:

```
[Nome completo, Nome na camisa, Número, Tamanho da camisa, Tamanho do calção]
```

O card mostra o primeiro nome pequeno e o **nome na camisa** grande. Os 11 primeiros titulares iniciais ficam na constante `PREF` (índices da lista `RAW`).

## Segurança e privacidade

- A chave `anon` do Supabase é pública por natureza e pode ficar no `index.html`. A proteção está nas regras de acesso (RLS): todos leem, só o editor grava.
- Nunca coloque no repositório a chave `service_role` nem a senha do banco.
- O elenco no `index.html` tem nomes completos e tamanhos de uniforme de pessoas reais. Se o repositório for **público**, esses dados ficam expostos. Prefira um repositório **privado** ou troque a lista `RAW` por dados fictícios.

## Limitações

- Vídeos: MP4 ou WebM, até 50 MB cada (outros formatos, como .mov, não são aceitos).
- A gravação em vídeo usa a captura da aba do navegador e pede permissão. Em alguns navegadores ela pode não estar disponível; nesse caso use a gravação de tela do sistema em tela cheia.
- A exportação em PNG pode variar levemente entre navegadores.

## Licença

Defina a licença do projeto antes de torná-lo público.