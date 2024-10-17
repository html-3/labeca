function frequency_response()
    
    [gjw_abs, ~, f] = iterate_fourier();

    % Vetores gjwdb
    gjwdb = 20*log10(gjw_abs);



    % Ajuste por mínimos quadrados das baixas frequências
    x = f(1:3);
    y = gjwdb(1:3);
    polinomio = polyfit(x,y,1); %% Rever MMQ

    % Calculo de R^2 (curva)
    curva_tendencia = polyval(polinomio,x);
    
    SS_tot = sum((y - mean(y)).^2); % Soma total dos quadrados
    SS_res_1grau = sum((y - curva_tendencia).^2); 
    R2_1grau = 1 - SS_res_1grau/SS_tot;
    
    eq_1grau = sprintf('%.3fx (R^2 = %.3f)',polinomio(1), R2_1grau);
   
    
    % Bode Plot
    figure(1)
    semilogx(f, gjwdb, '+'); 
    hold on;
    semilogx(x, curva_tendencia, 'r'); 
    legend('Dados originais', eq_1grau);
    grid on;

    
    % Cálculo de Kdb
    Kdb = polinomio(2);


    % Ajuste por mínimos quadrados para o bode inteiro

    polinomio = polyfit(f,gjwdb,3); %% Rever MMQ

    % Calculo de R^2 (curva)
    curva_tendencia = polyval(polinomio,f);
    
    SS_tot = sum((gjwdb - mean(gjwdb)).^2); % Soma total dos quadrados
    SS_res_1grau = sum((gjwdb - curva_tendencia).^2); 
    R2_3grau = 1 - SS_res_1grau/SS_tot;
    
    eq_3grau = sprintf('%.3fx^3+%.3fx^2+%.3fx+%.3f (R^2 = %.3f)',polinomio(1),polinomio(2),polinomio(3),polinomio(4),R2_3grau);
   
    
    % Bode Plot
    figure(2)
    semilogx(f, gjwdb, '+'); 
    hold on;
    semilogx(f, curva_tendencia, 'r'); 
    legend('Dados originais', eq_3grau);
    grid on;


    ff = logspace(log10(f(1)),log10(f(end)),200);
    gff = polyval(polinomio,ff);
    
    figure(3)
    semilogx(f, curva_tendencia, 'r'); 
    hold on;
    legend('Dados originais', eq_3grau);
    semilogx(ff, gff, 'b');
    grid on;

    

    %Cálculo de K e Tau
    K = 10^(Kdb/20);

    tau = ff(find(Kdb-3)); %% Rever o valor de tau










