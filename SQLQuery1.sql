select 
compra.*,
case when status = 0 then 'Aguardando Liberação' when status = 1 then 'Liberado' end
from compra

sp_help usuario
create table Regiao
bairro varchar(100),
