 function labeca_01_ploter(filename)
    
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
    data = readtable(filename);
    data = table2array(data);
    
    % Ordem das colunas: 1) Va_ref 2) Va_medido 3) Vt_medido 4) w_medido
    x = data(:, 2); 
    y = data(:, 3);  

    % Calcular a derivada numerica
    dy = diff(y)./diff(x);
    dx = x(1:end-1);  % Ajusta o comprimento de x para coincidir com dy
    
    p = mmq([x y], 4);  % Ajusta a curva dos dados
    dp = polyder(p);  % Obtem a derivada do polinomio
    dy_fit = polyval(dp, dx); % Calcula a curva da derivada

    % Calculo de R^2 (curva)
    curva_tendencia = polyval(p,x);
    
    SS_tot = sum((y - mean(y)).^2); % Soma total dos quadrados
    SS_res_4grau = sum((y - curva_tendencia).^2); 
    R2_4grau = 1 - SS_res_4grau/SS_tot;
    
    eq_4grau = sprintf('%.3fx^4 + %.3fx^3 + %.3fx^2 + %.3fx + %.3f (R^2 = %.3f)',p(1),p(2),p(3),p(4),p(5),R2_4grau);

    % Plotar os dados e a derivada
    figure;
    subplot(2, 1, 1);
    plot(x, y, '-o');
    hold on;
    plot(x, curva_tendencia);
    title('Dados Originais e Curva Ajustada por Minimos Quadrados');
    legend('Dados originais', eq_4grau);
    xlabel('Vt');
    ylabel('Va');
    grid;

    subplot(2, 1, 2);
    plot(dx, dy, '-o', 'DisplayName', 'Derivada Numerica');
    yline(mean(dy_fit(find(dy_fit>1.38))));
    mean(dy_fit(find(dy_fit>1.38)))
    hold on;
    plot(dx, dy_fit, '-r', 'DisplayName', 'Derivada Continua');
    title('Derivada Discreta e Derivada da Regressao');
    xlabel('Vt');
    ylabel('dVa/dVt');
    grid;
    legend show;
    hold off;
    
    % Identificar a regiao linear
    ids_linear = [13 24];
    
    % Realizar a regressao linear
    D = [x y];
    D = D(ids_linear(1):ids_linear(end),:);
    k = mmq_originD, 1);  % Ajusta uma linha (primeiro grau) aos dados
    y_fit = polyval(k, x);  % Calcula os valores ajustados

    % Exibir os coeficientes da regressao
    slope = k(1);
    intercept = k(2);
    fprintf('Coeficiente angular (slope): %.4f\n', slope);
    fprintf('Coeficiente linear (intercept): %.4f\n', intercept);

    % Plotar os dados e a linha de regressao
    figure;
    plot(x, y, 'o', 'DisplayName', 'Dados Originais');  % Dados originais
    hold on;
    plot(x, y_fit, '-r', 'DisplayName', 'Regressao Linear');  % Linha de regressao
    title('Regressao Linear');
    xlabel('Vt');
    ylabel('Va');
    legend show;
    grid;
    hold off;

    fprintf('Regiao linear encontrada entre Vt = %.2f e Vt = %.2f\n', x(ids_linear(1)), x(ids_linear(end)));

    % Salvar os resultados
    save('derivada_dados.mat', 'x', 'y', 'dx', 'dy', 'ids_linear');
    
end