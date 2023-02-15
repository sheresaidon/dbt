select distinct *
from (select * from parent_loads)
union all
(select * from child_loads)
