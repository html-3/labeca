function [t, va, vt] = labeca_02_validacao_2
    
    close all
    clc

    % Coleta de dados
    data = readtable('dados_validacao.CSV');
    data = table2array(data);
    vt = data(:,3);
    va = data(:,2);
    t = data(:,1);

    figure
    plot(t,va,t,vt);
    title("Raw Data");
    ylabel('Amplitude de Tensão(V)');
    legend('Entrada Degrau','Resposta ao degrau');
    xlabel('Tempo(s)');
    grid;

    ids_lower_va_vt = find(-0.02 < t);
    ids_upper_va_vt = find(0 > t);

    % Retirando offset de Va
    ids_va = intersect(ids_upper_va_vt,ids_lower_va_vt);
    va = va - mean(va(ids_va));

    % Retirando offset de Va e Vt
    ids_vt = intersect(ids_upper_va_vt,ids_lower_va_vt);
    vt = vt - mean(vt(ids_vt));

    ids_lower = find(-0.1 < t);
    ids_upper = find(0.3 > t);
    ids = intersect(ids_upper,ids_lower);

    vt = vt(ids);
    va = va(ids);
    t = t(ids);

    figure
    plot(t,va)
    hold on
    plot(t,vt)
    ylabel('Amplitude de Tensão(V)');
    legend('Entrada Degrau','Resposta ao degrau');
    xlabel('Tempo(s)');
    title("Resposta ao degrau - Dados Tratados");
    grid
    
    
    vt_mean = mean(vt(find(t > 0.25)))
    va_mean = mean(va(find(t > 0.25)))
    K_basilio = vt_mean / va_mean

    %{
    % Cálculo de K 
    ids_lower = find(0.25 < t);
    ids_upper = find(0.4 > t);
    ids = intersect(ids_upper,ids_lower);

    y_inf = mean(vt(ids));
    A = mean(va(ids));
    K_validacao = (y_inf)/A;

    % Intervalo Transitorio
    ids_transitorio_lower = find(0.0 < t);
    ids_transitorio_upper = find(0.25 > t);
    ids_transitorio = intersect(ids_transitorio_lower, ids_transitorio_upper);
    
    % Cálculo de tau area
    A0 = trapz(t(ids_transitorio), y_inf - vt(ids_transitorio));
    tau_area = A0 / y_inf;


    % Cálculo de tau neperiano
    b = log(y_inf./(abs(y_inf-vt(ids_transitorio))));
    a = t(ids_transitorio)'*b/(norm(t(ids_transitorio))^2);
    tau_nep = 1/a;
    %}
end