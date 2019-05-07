#Cadeira Análise de dados - 2019.1 - UFPE
#Resolução da lista 4
#Aluna: Ayla Reis de Lima

###Questão 1###
#Link: https://github.com/AylaReis/Resolu-o-lista-4

###Questão 2###

##Instalação de pacotes
if(require("tidyverse") == F) install.packages("tidyverse") ; require("tidyverse")
if(require("readxl") == F) install.packages("readxl"); require("readxl")

##Definindo diretório dados do censo
setwd ("/Users/reis/Desktop/AYLA/UFPE/analise_de_dados_pos_graduacao_davi_moreira/dados_encontro_2_ufpe/")

##carrengando arquivos do censo escolar 2016
load("matricula_pe_censo_escolar_2016.RData")
load("docentes_pe_censo_escolar_2016.RData")
load("turmas_pe_censo_escolar_2016.RData")
load("escolas_pe_censo_escolar_2016.RData")

##Definindo diretório dados PNUD
setwd("/Users/reis/Desktop/AYLA/UFPE/analise_de_dados_pos_graduacao_davi_moreira/dados_encontro_2_ufpe")

##Carregando dados PNUD
if(require("tidyverse") == F) install.packages('tidyverse'); require("tidyverse")
if(require("readxl") == F) install.packages('readxl'); require("readxl")

pnud <- read_excel("atlas2013_dadosbrutos_pt.xlsx", sheet = 2)
head("pnud")
unique("pnud$ANO")

##Selecionando dados de 2010 e de PE

#Filtração de dados que serão trabalhados PNUD
pnud_pe_2010 <- pnud %>% filter(ANO == 2010 & UF == 26)


##Filtrando dados que ser?o trabalhados censo escolar
# Docentes <70 anos e > 18 anos, agrupados pelo munic?pio onde lecionam
docentes_sel <- docentes_pe %>% group_by(CO_MUNICIPIO) %>% summarise(num_docentes = sum(NU_IDADE < 70 & NU_IDADE > 18))
docentes_sel

#Alunos <25 anos e > 1 ano
alunos_sel <- matricula_pe %>% group_by(CO_MUNICIPIO) %>% summarise(num_alunos = sum(NU_IDADE < 25 & NU_IDADE > 1))
alunos_sel

##Filtranto o IDMH do pnud
idh_municipios <- pnud_pe_2010 %>% group_by(Codmun7) %>% summarise(idhm = IDHM)
idh_municipios

##Criando aluno por docentes no município
#Unindo em tabela de alunos e docentes
alunos_docentes_municipio <- alunos_sel %>% full_join(docentes_sel,
                                                     by = c("CO_MUNICIPIO" = "CO_MUNICIPIO")
)
dim(docentes_sel)
dim(alunos_sel)
names(alunos_docentes_municipio)

#Alunos por docentes no município
alunos_por_docentes <- alunos_docentes_municipio %>% group_by(CO_MUNICIPIO) %>% summarise(alu_por_doc = num_alunos/num_docentes)
alun_p_doc

##Estatistica descritiva do número de alunos por docente nos municípios

#Média aritimética
mean(alunos_por_docentes[["alu_por_doc"]])

#Mediana
median(alunos_por_docentes[["alu_por_doc"]])

#Moda
moda_alu_por_doc <- c(sample((1:10, 100, replace= T)))
table(moda_alu_por_doc)
table(moda_alu_por_doc)[which.max(table(moda_alu_por_doc))]
  #Há prevalência de ser 10 alunos por professor

#Quantis + val. min e max + mediana + media
summary(alunos_por_docentes[["alu_por_doc"]])

#Amplitude
max(alunos_por_docentes[["alu_por_doc"]]) - min(alunos_por_docentes[["alu_por_doc"]])

#Variância
var(alunos_por_docentes[["alu_por_doc"]])

#Desvio padrão
sd(alunos_por_docentes[["alu_por_doc"]])

#Coeficiente de variação
100*sd(alunos_por_docentes[["alu_por_doc"]])/ mean(alunos_por_docentes[["alu_por_doc"]])


##Maior número de alunos por docente e seu idhm
#Juntando em uma única tabela
alu_por_doc_idhm <- idh_municipios %>% full_join(alunos_por_docentes,
                                                            by = c("Codmun7" = "CO_MUNICIPIO"))
alu_por_doc_idhm

#Ordenando por ordem crescente do idhm
alu_por_doc_idhm_dec <- alu_por_doc_idhm %>% arrange(desc(idhm))
alu_por_doc_idhm_dec

#Trocando o código pelo nome do municício


##
