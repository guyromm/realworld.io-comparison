select repo,
       sum(code) tot,
       
       sum(CASE WHEN lang='Clojure'THEN code ELSE 0 END) clojure,       
       
       sum(CASE WHEN lang='JavaScript'THEN code ELSE 0 END) js,
       sum(CASE WHEN lang='ClojureScript'THEN code ELSE 0 END) cljs,       
       sum(CASE WHEN lang='TypeScript' THEN code ELSE 0 END) ts,       
       sum(CASE WHEN lang='Elm'THEN code ELSE 0 END) elm,
       
       sum(CASE WHEN lang='CSS'THEN code ELSE 0 END) css,
       sum(CASE WHEN lang='HTML'THEN code ELSE 0 END) html,

       sum(CASE WHEN lang='JSON'THEN code ELSE 0 END) json,
       sum(CASE WHEN lang='YAML'THEN code ELSE 0 END) yaml,
       sum(CASE WHEN lang='Markdown'THEN code ELSE 0 END) md
      
from tbl
group by repo
order by sum(code)
