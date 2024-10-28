function [K, tau] = frequency_response()
    
    [gjw_abs,~, w] = iterate_fourier(); % esse w está em hz, e não em rad/s

    % Vetores gjwdb
    gjwdb = 20*log10(gjw_abs);
    
    % Tirando o último ponto, com polinômio de grau 3, o tau = 0.1101, e deixando-o, o tau = 0.1124
    % Tirando o último ponto, com polinômio de grau 1, o tau = 0.096.., e deixando-o, o tau = 0.1013
    % pode ser somente o grau do polinômio q ta dando ruim, ou o q fizemos
    % com um grau maior esteja certo.
    gjwdb = gjwdb(1:end-1);
    w = w(1:end-1);

    % Ajuste por mínimos quadrados das baixas frequências
    x = w(1:2)';
    y = gjwdb(1:2)';
    poli_mmq = mmq([x,y],1);

    % Calculo de R^2 (curva)
    curva_tendencia = polyval(poli_mmq,x);
    
    SS_tot = sum((y - mean(y)).^2); % Soma total dos quadrados
    SS_res_1grau = sum((y - curva_tendencia).^2); 
    R2_1grau = 1 - SS_res_1grau/SS_tot;
    
    eq_1grau = sprintf('%.3fx+%.3f (R^2 = %.3f)',poli_mmq(1), poli_mmq(2), R2_1grau);
   
    % Bode Plot
    figure(1)
    semilogx(w, gjwdb, '+'); 
    hold on;
    semilogx(x, curva_tendencia, 'r'); 
    legend('Dados originais', eq_1grau);
    grid on;
    
    % Cálculo de Kdb
    Kdb = poli_mmq(2); % coeficiente linear do polinômio

    % Ajuste por mínimos quadrados para o bode inteiro

    polinomio = mmq([w',gjwdb'],3);

    % Calculo de R^2 (curva)
    curva_tendencia = polyval(polinomio,w);
    
    SS_tot = sum((gjwdb - mean(gjwdb)).^2); % Soma total dos quadrados
    SS_res_1grau = sum((gjwdb - curva_tendencia).^2); 
    R2_3grau = 1 - SS_res_1grau/SS_tot;
    
    eq_3grau = sprintf('%.3fx^3+%.3fx^2+%.3fx+%.3f (R^2 = %.3f)',polinomio(1),polinomio(2),polinomio(3),polinomio(4),R2_3grau); 
    %sprintf('%.3fx+%.3f (R^2 = %.3f)',polinomio(1),polinomio(2),R2_3grau); 
    
    % Bode Plot
    figure(2)
    semilogx(w, gjwdb, '+'); 
    hold on;
    semilogx(w, curva_tendencia, 'r'); 
    legend('Dados originais', eq_3grau);
    grid on;

    ww = logspace(log10(w(1)),log10(w(end)),200);
    gww = polyval(polinomio,ww);
    
    figure(3)
    semilogx(w, curva_tendencia, 'r'); 
    hold on;
    semilogx(ww, gww, 'b');
    legend('Dados originais', eq_3grau);
    grid on;
    
    %Cálculo de K e Tau
    K = 10^(Kdb/20);
    
    tau_gain = Kdb-3;     
    tau = 1/(2*pi*(ww(find(squeeze(gww)<=tau_gain, 1, 'first'))));
end
