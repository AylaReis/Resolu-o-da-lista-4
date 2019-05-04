#Cadeira Análise de dados - 2019.1 - UFPE
#Resolução da lista 4
#Aluna: Ayla Reis de Lima

###Questão 1###
#Link: https://github.com/AylaReis/Resolu-o-lista-4

###Questão 2###

#Instalação de pacotes
if(require("tidyverse") == F) install.packages("tidyverse") ; require("tidyverse")
if(require("readxl") == F) install.packages("readxl"); require("readxl")

#Definindo diretório dados do censo
setwd ("/Users/reis/Desktop/AYLA/UFPE/analise_de_dados_pos_graduacao_davi_moreira/dados_encontro_2_ufpe/")

#carrengando arquivos do censo escolar 2016
load("matricula_pe_censo_escolar_2016.RData")
load("docentes_pe_censo_escolar_2016.RData")
load("turmas_pe_censo_escolar_2016.RData")
load("escolas_pe_censo_escolar_2016.RData")

#Definindo diretório dados PNUD
setwd("/Users/reis/Desktop/AYLA/UFPE/analise_de_dados_pos_graduacao_davi_moreira/dados_encontro_2_ufpe")



