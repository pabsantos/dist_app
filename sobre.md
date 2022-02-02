
### Descrição
Essa ferramenta auxilia no cálculo da distância entre pontos, presentes na amostra do [Estudo Naturalístico de Direção Brasileiro](http://www.tecnologia.ufpr.br/portal/ceppur/estudo-naturalistico-de-direcao-brasileiro/)

O botão `Selecione .gpkg` permite realizar o upload de um arquivo de dados espaciais, de até 60 Mb, em formato `.gpkg` (GeoPackage)

O botão `Iniciar cálculo` inicia o processo de conversão de pontos para linhas, e em seguida cria uma nova coluna com as distâncias calculadas em metros.

`Download .gpkg` e `Download .csv` fazem o download dos resultados do cálculo, nos formatos descritos.

A tabela exibida contém as primeiras 15 linhas do arquivo. A sua exibição demonstra que o calculo ocorreu com êxito.

#### Autoria
O app foi escrito por Pedro Augusto Borges dos Santos.

O código-fonte pode ser conferido no [GitHub](https://github.com/pabsantos/dist_app). 

#### Changelog
- 01-02-2022: Primeira versão.
- 02-02-2022: Aplicada a ordenação dos dados de acordo com as colunas `DRIVER`, `ID` e `TIME_ACUM`