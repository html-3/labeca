function [K_val, tau_nep_val, tau_area_val, va, vt, t] = labeca_02_validacao_26_09
    
    % Coleta de dados
    data = readtable('dados_validacao.CSV');
    data = table2array(data);
    vt = data(:,3);
    va = data(:,2);
    t = data(:,1);

    % Tempo antes do degrau a ser considerado
    t_min_pre = -0.1;
    % Tempo de começo e fim do sinal
    t_min = -0.05;
    t_max = t_min + 0.4;
    
    % Intervalo de dados do sinal
    ids_min_pre = find(t>t_min_pre);
    ids_max_pre = find(t<t_min);
    t_pre_ids = intersect(ids_min_pre, ids_max_pre);

    % Intervalo do sinal
    ids_min = find(t>t_min);
    ids_max = find(t<t_max);
    t_ids = intersect(ids_min, ids_max);
    
    % Média do inicio do sinal
    va_min = mean(va(t_pre_ids));
    vt_min = mean(vt(t_pre_ids));
    
    % Deslocando os sinais para zero
    t = t(t_ids);
    vt = vt(t_ids)- vt_min;
    va = va(t_ids) - va_min;
    
    % Intervalo no infinito
    t_inf_min = 0.25;
    t_inf_max = 0.4;
    ids_min_inf = find(t>t_inf_min);
    ids_max_inf = find(t<t_inf_max);
    t_inf_ids = intersect(ids_min_inf, ids_max_inf);
    
    % Cálculo de K
    vt_inf = mean(vt(t_inf_ids));
    K_val = (vt_inf)/mean(va(t_inf_ids));

    % Intervalo dinamico
    ids_din_min = find(0.0 < t);
    ids_din_max = find(0.3 > t);
    ids_din = intersect(ids_din_min, ids_din_max);
    
    % Cálculo de tau area
    A0 = trapz(t(ids_din), vt_inf - vt(ids_din));
    tau_area_val = A0 / vt_inf;


    % Cálculo de tau neperiano
    b = log(vt_inf./(abs(vt_inf-vt(ids_din))));
    a = t(ids_din)'*b/(norm(t(ids_din))^2);
    tau_nep_val = 1/a;

    close all
    plot(t,va)
    hold on
    plot(t,vt)

    grid
end