function [Ka] = labeca_02_ploter_Ka()
% input da funcao: nome do arquivo .csv
    % output: 
    % plot Va vs W;
    close all
    clc

    % Carregar o arquivo CSV
    data = readtable('dados.csv');
    data = table2array(data);
    data(:, 4) = (data(:, 4)*(2*pi))/60; % Conversão de RPM para rad/s.  
    
    % Ordem das colunas: 1) Va_ref 2) Va_medido 3) Vt_medido 4) w_medido
    y = data(14:24, 4) - data(14,4);
    x = data(14:24, 2) - data(14,2);
    
    p = mmq_origin([x y], 1);  % Ajusta a curva dos dados

    % Calculo de R^2 (curva)
    curva_tendencia = polyval(p,x);
    
    SS_tot = sum((y - mean(y)).^2); % Soma total dos quadrados
    SS_res_1grau = sum((y - curva_tendencia).^2); 
    R2_1grau = 1 - SS_res_1grau/SS_tot;
    
    eq_1grau = sprintf('%.3fx (R^2 = %.3f)',p(1), R2_1grau);

    Ka = p(1);

    % Plotar os dados
    figure;
    plot(x, y, '-o');
    hold on;
    plot(x, curva_tendencia);
    title('Dados Originais e Curva Ajustada por Minimos Quadrados');
    legend('Dados originais', eq_1grau);
    ylabel('W(rad/s)');
    xlabel('Va(V)');
    grid;
end
   