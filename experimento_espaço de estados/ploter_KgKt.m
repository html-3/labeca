function ploter_KgKt()
    % Retorna a relação fem x vt

    % Carregar KgKt
    [KgKt, x, y] = get_KgKt('spin.csv');

    % Calculo de R^2 (curva)
    curva_tendencia = polyval([KgKt 0],x);

    SS_tot = sum((y - mean(y)).^2); % Soma total dos quadrados
    SS_res_1grau = sum((y - curva_tendencia).^2); 
    R2_1grau = 1 - SS_res_1grau/SS_tot;

    eq_1grau = sprintf('Kg/Kt = %.5fx (R^2 = %.3f)',KgKt, R2_1grau);

    % Plotar os dados
    figure;
    scatter(x, y, '+');
    hold on;
    plot(x, curva_tendencia);
    title('Dados Originais e Curva Ajustada por Minimos Quadrados');
    legend('Amostragem', eq_1grau);
    ylabel('Va (V)');
    xlabel('Vt (V)');
    grid;

end