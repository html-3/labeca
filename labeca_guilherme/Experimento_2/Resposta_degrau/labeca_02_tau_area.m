function [tau_area] = labeca_02_tau_area()
    [~,~,~,y_inf,~] = labeca_02_K_degrau;
    
    close all
    clc
    
    %A_base = 5.829;

    % Carregar o arquivo CSV
    data = readtable('carolina_dados.CSV');
    data = table2array(data);
    t = data(:,1);
    vt = data(:,3);
    
    % Retirando Offset de Vt
    ids_lower = find(-0.4 < t);
    ids_upper = find(0 > t);
    ids = intersect(ids_upper, ids_lower);
    vt = vt - mean(vt(ids));

    
    % Selecionando Janela de Regime Transitório
    ids_lower = find(0.0 < t);
    ids_upper = find(0.35 > t);
    ids = intersect(ids_upper, ids_lower);
    
    figure
    plot(t(ids), vt(ids))

    A0 = trapz(t(ids), y_inf - vt(ids));
    

    tau_area = A0/y_inf;
end