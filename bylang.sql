select repo,
       sum(code) tot,
       
       sum(CASE WHEN lang='Rust'THEN code ELSE 0 END) rust,
       sum(CASE WHEN lang='Elixir'THEN code ELSE 0 END) elixir,
       sum(CASE WHEN lang='Go'THEN code ELSE 0 END) go,

       sum(CASE WHEN lang='Kotlin'THEN code ELSE 0 END) kotlin,
       sum(CASE WHEN lang='Java'THEN code ELSE 0 END) java,
       
       sum(CASE WHEN lang='F#'THEN code ELSE 0 END) fsharp,
       sum(CASE WHEN lang='C#'THEN code ELSE 0 END) csharp,

       sum(CASE WHEN lang='JavaScript'THEN code ELSE 0 END) js,
       sum(CASE WHEN lang='Python'THEN code ELSE 0 END) py,
       sum(CASE WHEN lang='Ruby'THEN code ELSE 0 END) ruby,       
       sum(CASE WHEN lang='PHP'THEN code ELSE 0 END) php,

       sum(CASE WHEN lang='CSS'THEN code ELSE 0 END) css,
       sum(CASE WHEN lang='HTML'THEN code ELSE 0 END) html,

       sum(CASE WHEN lang='SQL' THEN code ELSE 0 END) sql,
       
       sum(CASE WHEN lang='JSON'THEN code ELSE 0 END) json,
       sum(CASE WHEN lang='YAML'THEN code ELSE 0 END) yaml,
       sum(CASE WHEN lang='XML'THEN code ELSE 0 END) xml,
       sum(CASE WHEN lang='Markdown'THEN code ELSE 0 END) md,              

       sum(CASE WHEN lang='Bourne'THEN code ELSE 0 END) bash,
       sum(CASE WHEN lang='Powershell'THEN code ELSE 0 END) pshell,
       sum(CASE WHEN lang='Dockerfile' THEN code ELSE 0 END) docker,
       sum(CASE WHEN lang='Maven' THEN code ELSE 0 END) maven


      
from tbl
group by repo
order by sum(code)
