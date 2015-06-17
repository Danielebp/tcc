select 
      poptbr13.munic_res as cod_mun,
      tb_municip.ds_nome as nome_mun,
      poptbr13.populacao as pop_mun,
      ces.qtd as qtdcesarias,
      norm.qtd as qtdnormal
      from (poptbr13
	join tb_municip on tb_municip.co_municip = poptbr13.munic_res
	left join (select codmunnasc, count(*) as qtd from dnrj2010
        where  parto = '1' and dtnasc like '__' || '{$str}' || '____'
        group by codmunnasc) as norm 
        on norm.codmunnasc = poptbr13.munic_res
     full join (select codmunnasc, count(*) as qtd from dnrj2010 
        where parto = '2' and dtnasc like '____' || '{$str}' || '____' 
        group by codmunnasc) as ces
        on ces.codmunnasc = poptbr13.munic_res )
      where poptbr13.munic_res like '33%'
      group by poptbr13.munic_res, tb_municip.ds_nome, poptbr13.populacao,  norm.qtd, ces.qtd
      order by poptbr13.munic_res;
