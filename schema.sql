-- Lineup Studio — estrutura do banco (Supabase / Postgres)
-- Rode este arquivo uma vez no SQL Editor do seu projeto Supabase.

-- Quem pode editar (o primeiro usuário que "reivindicar" vira o editor)
create table public.editors (user_id uuid primary key references auth.users(id) on delete cascade);
alter table public.editors enable row level security;

create or replace function public.is_editor() returns boolean
language sql stable security definer set search_path = public as
$$ select exists (select 1 from public.editors where user_id = (select auth.uid())) $$;

create or replace function public.claim_editor() returns boolean
language plpgsql security definer set search_path = public as $$
begin
  if auth.uid() is null then return false; end if;
  if not exists (select 1 from public.editors) then
    insert into public.editors(user_id) values (auth.uid());
  end if;
  return exists (select 1 from public.editors where user_id = auth.uid());
end $$;

revoke execute on function public.is_editor() from public, anon;
revoke execute on function public.claim_editor() from public, anon;
grant execute on function public.is_editor() to authenticated;
grant execute on function public.claim_editor() to authenticated;

-- Projetos (escalações salvas) e mídia dos jogadores do elenco
create table public.projects (
  id text primary key,
  name text not null default '',
  data jsonb not null,
  updated_at timestamptz not null default now()
);
create table public.players (
  id text primary key,
  data jsonb not null,
  updated_at timestamptz not null default now()
);
alter table public.projects enable row level security;
alter table public.players enable row level security;

-- Leitura pública; escrita só para o editor
create policy projects_read on public.projects for select to anon, authenticated using (true);
create policy projects_insert on public.projects for insert to authenticated with check ((select public.is_editor()));
create policy projects_update on public.projects for update to authenticated using ((select public.is_editor())) with check ((select public.is_editor()));
create policy projects_delete on public.projects for delete to authenticated using ((select public.is_editor()));

create policy players_read on public.players for select to anon, authenticated using (true);
create policy players_insert on public.players for insert to authenticated with check ((select public.is_editor()));
create policy players_update on public.players for update to authenticated using ((select public.is_editor())) with check ((select public.is_editor()));
create policy players_delete on public.players for delete to authenticated using ((select public.is_editor()));

-- Pasta pública para fotos e vídeos (até 50 MB por arquivo)
insert into storage.buckets (id, name, public, file_size_limit, allowed_mime_types)
values ('media', 'media', true, 52428800, array['image/png','image/jpeg','image/webp','image/gif','video/mp4','video/webm'])
on conflict (id) do nothing;

create policy media_insert on storage.objects for insert to authenticated with check (bucket_id = 'media' and (select public.is_editor()));
create policy media_update on storage.objects for update to authenticated using (bucket_id = 'media' and (select public.is_editor())) with check (bucket_id = 'media' and (select public.is_editor()));
create policy media_delete on storage.objects for delete to authenticated using (bucket_id = 'media' and (select public.is_editor()));