function [t, va, vt, y_inf, K_degrau] = labeca_02_K_degrau()

    clc
    close all

    % Dados obtidos no osciloscópio
    A = 6.409;

    % Carregar o arquivo CSV
    data = readtable('carolina_dados.CSV');
    data = table2array(data);
    vt = data(:,3);
    va = data(:,2);
    t = data(:,1);

    ids_lower_va_vt = find(-0.4 < t);
    ids_upper_va_vt = find(0 > t);

    % Retirando offset de Va
    ids_va = intersect(ids_upper_va_vt,ids_lower_va_vt);
    va = va - mean(va(ids_va));

    % Retirando offset de Vt
    ids_vt = intersect(ids_upper_va_vt,ids_lower_va_vt);
    vt = vt - mean(vt(ids_vt));

    % Cálculo da Amplitude do sinal Va
    ids_lower_A = find(0.35 < t);
    ids_upper_A = find(0.73 > t);
    ids_A = intersect(ids_upper_A,ids_lower_A);
    A = mean(va(ids_A));


    figure
    plot(t,va);
    hold on
    plot(t,vt);
    ylabel('Amplitude de Tensão(V)');
    title('Dados de entrada e saída ao degrau x tempo');
    legend('Entrada Degrau','Resposta ao degrau');
    xlabel('Tempo(s)');
    grid;
    % plot(t,movmean(vt,20000), '-b')
    
    ids_lower = find(0.35 < t);
    ids_upper = find(0.73 > t);
    ids = intersect(ids_upper,ids_lower);
    y_inf = mean(vt(ids));

    K_degrau = (y_inf)/A;

    
end