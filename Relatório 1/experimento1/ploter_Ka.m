function [] = ploter_Ka()
    % Retorna o diagrama da regiao linear de Ka

    % Carregar Ka
    [Ka, x, y] = get_Ka('dados_lin.csv');

    % Calculo de R^2 (curva)
    curva_tendencia = polyval([Ka 0],x);

    SS_tot = sum((y - mean(y)).^2); % Soma total dos quadrados
    SS_res_1grau = sum((y - curva_tendencia).^2); 
    R2_1grau = 1 - SS_res_1grau/SS_tot;

    eq_1grau = sprintf('%.3fx (R^2 = %.3f)',Ka, R2_1grau);

    % Plotar os dados
    figure;
    plot(x, y, '-o');
    hold on;
    plot(x, curva_tendencia);
    title('Dados Originais e Curva Ajustada por Minimos Quadrados');
    legend('Dados originais', eq_1grau);
    ylabel('W (rad/s)');
    xlabel('Va (V)');
    grid;
end
