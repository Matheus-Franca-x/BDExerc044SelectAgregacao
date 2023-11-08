# BDExerc044
## Links:
---
### [para SQLLocadora.sql](#sqllocadorasql)
#### [exercício adicional](#locadora-exerc3-adicional)
---
## SQLLocadora.sql
### Considere o diagrama abaixo:

![image](https://github.com/Matheus-Franca-x/BDExerc021/assets/99504777/7e0d7ff0-ad86-4f1c-b368-bf4e62943652)

### Restrições:
- Ano de filme deve ser menor ou igual a 2021.
- Data de fabricação de DVD deve ser menor do que hoje.
- Número do endereço de Cliente deve ser positivo.
- CEP do endereço de Cliente deve ter, especificamente, 8 caracteres.
- Data de locação de Locação, por padrão, deve ser hoje.
- Data de devolução de Locação, deve ser maior que a data de locação.
- Valor de Locação deve ser positivo.

### Esquema:
- A entidade estrela deveria ter o nome real da estrela, com 50 caracteres
- Verificando um dos nomes de filme, percebeu-se que o nome do filme deveria ser um atributo com 80 caracteres

### Considere os dados:
#### filme:
|   ID   |                             Filme                           |  Ano  |
|--------|-------------------------------------------------------------|-------|
|  1001  | Whiplash                                                    | 2015  |
|  1002  | Birdman                                                     | 2015  |
|  1003  | Interestelar                                                | 2014  |
|  1004  | A Culpa é das Estrelas                                      | 2014  |
|  1005  | Alexandre e o Dia Terrível, Horrível, Espantoso e Horroroso | 2014  |
|  1006  | Sing                                                        | 2016  |

#### estrela:
|   ID   |      Nome       |        Nome Real     |
|--------|-----------------|----------------------|
|  9901  | Michael Keaton  | Michael John Douglas |
|  9902  | Emma Stone      | Emily Jean Stone     |
|  9903  | Miles Teller    | NULL                 |
|  9904  | Steve Carell    | Steven John Carell   |
|  9905  | Jennifer Garner | Jennifer Anne Garner |

#### filme_estrela:
| FilmeId | EstrelaId |
|---------|-----------|
|  1002   |   9901    |
|  1002   |   9902    |
|  1001   |   9903    |
|  1005   |   9904    |
|  1005   |   9905    |

#### dvd:
|  Num  | Data de Fabricação | FilmeId |
|-------|--------------------|---------|
| 10001 |   2020-12-02       |   1001  |
| 10002 |   2019-10-18       |   1002  |
| 10003 |   2020-04-03       |   1003  |
| 10004 |   2020-12-02       |   1001  |
| 10005 |   2019-10-18       |   1004  |
| 10006 |   2020-04-03       |   1002  |
| 10007 |   2020-12-02       |   1005  |
| 10008 |   2019-10-18       |   1002  |
| 10009 |   2020-04-03       |   1003  |

#### cliente:
| Num Cadastro |       Nome        |          Logradouro      | Num  |    CEP    |
|--------------|-------------------|--------------------------|------|-----------|
|    5501      |    Matilde Luz    |        Rua Síria         | 150  |  03086040 |
|    5502      | Carlos Carreiro   | Rua Bartolomeu Aires     | 1250 |  04419110 |
|    5503      |  Daniel Ramalho   |      Rua Itajutiba       | 169  |   NULL    |
|    5504      |  Roberta Bento    | Rua Jayme Von Rosenburg  | 36   |   NULL    |
|    5505      |  Rosa Cerqueira   | Rua Arnaldo Simões Pinto | 235  |  02917110 |

#### locacao:
| DVD Num | Cliente Num Cadastro | Data Locação | Data Devolução  | Valor |
|---------|----------------------|--------------|-----------------|-------|
|  10001  |         5502         | 2021-02-18   | 2021-02-21      |  3.50 |
|  10009  |         5502         | 2021-02-18   | 2021-02-21      |  3.50 |
|  10002  |         5503         | 2021-02-18   | 2021-02-19      |  3.50 |
|  10002  |         5505         | 2021-02-20   | 2021-02-23      |  3.00 |
|  10004  |         5505         | 2021-02-20   | 2021-02-23      |  3.00 |
|  10005  |         5505         | 2021-02-20   | 2021-02-23      |  3.00 |
|  10001  |         5501         | 2021-02-24   | 2021-02-26      |  3.50 |
|  10008  |         5501         | 2021-02-24   | 2021-02-26      |  3.50 |

### Operações com dados:
- Os CEP dos clientes 5503 e 5504 são 08411150 e 02918190 respectivamente
- A locação de 2021-02-18 do cliente 5502 teve o valor de 3.25 para cada DVD alugado
- A locação de 2021-02-24 do cliente 5501 teve o valor de 3.10 para cada DVD alugado
- O DVD 10005 foi fabricado em 2019-07-14
- O nome real de Miles Teller é Miles Alexander Teller
- O filme Sing não tem DVD cadastrado e deve ser excluído

# Locadora Exerc3 Adicional:
### Consultar:
- Não esquecer de rever as restrições de datas
1) Consultar, num_cadastro do cliente, nome do cliente, titulo do filme, data_fabricação do dvd, valor da locação, dos dvds que tem a maior data de fabricação dentre todos os cadastrados.
2) Consultar Consultar, num_cadastro do cliente, nome do cliente, data de locação (Formato DD/MM/AAAA) e a quantidade de DVD ́s alugados por cliente (Chamar essa coluna de qtd), por data de locação
3) Consultar Consultar, num_cadastro do cliente, nome do cliente, data de locação (Formato DD/MM/AAAA) e a valor total de todos os dvd ́s alugados (Chamar essa coluna de valor_total), por data de locação
4) Consultar Consultar, num_cadastro do cliente, nome do cliente, Endereço concatenado de logradouro e numero como Endereco, data de locação (Formato DD/MM/AAAA) dos clientes que alugaram mais de 2 filmes simultaneamente
