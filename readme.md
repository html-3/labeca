# Laboratório de Controle e Automação

2024.2

## Membros

Caronlina Segundo

Guilherme Mattero

Henrique Lozano

## Introdução

Este repositório trata sobre a matéria de LABECA durante o período de 2024.2 da equipe anteriormente nomeada. O repositório é divido conforme os relatórios determinados pelo prof. João Carlos Basílio.

1. Obtenção da região linear se operação
2. ⁠Identifação do modelo de primeira ordem do motor CC (função de transferência)
   1. Utilizando a resposta em frequência e construção de diagrama de Bode
   2. Utilizando a resposta ao degrau (método da área e do logaritmo neperiano)
3. Identificação dos parâmetros do modelo de segunda ordem do motor CC (espaço de estados)
4. ⁠Projeto de um controlador PID com base no modelo de primeira ordem
   1. Projeto
   2. Simulação
   3. Implementação utilizando Arduino + SIMULINK ou CLP
5. Projeto de um observador de estados e de um controlador por realimentação de estados e de saída para rastreamento robusto
   1. Projeto
   2. Simulação
   3. Implementação utilizando Arduino + SIMULINK

## Implementação

Os scripts são divididos em funções 'get' e 'ploter', ambas podem receber como argumento 'filename' para definir os dados no sobre o qual serão computados os comandos.
