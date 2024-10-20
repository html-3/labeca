function [Kt] = labeca_02_ploter_Kt()
% input da funcao: nome do arquivo .csv
    % output: 
    % * plots Va vs Vt; 
    % * derivada de Vt no tempo (onde Vt eh a tensao de saida do tacometro), 
    % tando numerica como continua (a partir de um curve fitting 
    % dos dados por um polinomio de grau 4);
    % * mostra a regiao linear, os coeficientes linear e angular da 
    % regressao linear 
    % Exemplo de uso da funcao: labeca_01_ploter("labeca_01_dados.csv")
    close all
    clc

    % Carregar o arquivo CSV
    data = readtable('dados.csv');
    data = table2array(data);
    data(:, 4) = (data(:, 4)*(2*pi))/60;
    
    % Ordem das colunas: 1) Va_ref 2) Va_medido 3) Vt_medido 4) w_medido
    x = data(14:24, 4) - data(14,4);
    y = data(14:24, 3) - data(14,3);

    p = mmq([x y], 1);  % Ajusta a curva dos dados

    %dp = polyder(p);  % Obtem a derivada do polinomio
    %dy_fit = polyval(dp, dx); % Calcula a curva da derivada

    % Calculo de R^2 (curva)
    curva_tendencia = polyval(p,x);
    
    SS_tot = sum((y - mean(y)).^2); % Soma total dos quadrados
    SS_res_1grau = sum((y - curva_tendencia).^2); 
    R2_1grau = 1 - SS_res_1grau/SS_tot;
    
    eq_1grau = sprintf('%.3fx (R^2 = %.3f)',p(1), R2_1grau);

    Kt = p(1);

    % Plotar os dados e a derivada
    figure;
    plot(x, y, '-o');
    hold on;
    plot(x, curva_tendencia);
    title('Dados Originais e Curva Ajustada por Minimos Quadrados');
    legend('Dados originais', eq_1grau);
    xlabel('W(rad/s)');
    ylabel('Vt(V)');
    grid;

   