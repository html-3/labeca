function [tau_nep] = labeca_02_tau_neperiano()

    [~,~,~,y_inf,~] = labeca_02_K_degrau;

    close all
    clc

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

    %plot(t,vt);
    
    % Selecionando Janela de Regime Transitório
    ids_lower = find(0.0 < t);
    ids_upper = find(0.35 > t);
    ids = intersect(ids_upper, ids_lower);
    
    figure;
    plot(t(ids), vt(ids))

    % Tempo de subida t = 0.35
    b = log(y_inf./(abs(y_inf-vt(ids))));
    a = t(ids)'*b/(norm(t(ids))^2);
    tau_nep = 1/a;

end