function [tau_nep] = get_tau_nep(filename)
    % Coleta de dados
    data = readtable(filename, 'ReadVariableNames', false);
    data = table2array(data);
    vt = data(:,3);
    va = data(:,2);
    t = data(:,1);

    % Intervalo antes do inicio do sinal
    ids_lower_pre = find(t>-0.1);
    ids_upper_pre = find(t<0.0);
    ids_pre = intersect(ids_lower_pre, ids_upper_pre);

    % Média do inicio do sinal
    va_min = mean(va(ids_pre));
    vt_min = mean(vt(ids_pre));

    % Deslocando os sinais para zero
    vt = vt- vt_min;
    va = va - va_min;

    % Intervalo dinamico
    ids_lower_dyn = find(0.0 < t);
    ids_upper_dyn = find(0.3 > t);
    ids_dyn = intersect(ids_lower_dyn, ids_upper_dyn);

    % Intervalo do sinal considerado no infinito
    ids_lower_inf = find(t>0.6);
    ids_upper_inf = find(t<0.74);
    ids_inf = intersect(ids_lower_inf, ids_upper_inf);

    y_inf = mean(vt(ids_inf));

    % Cálculo de tau neperiano
    b = log(y_inf./(abs(y_inf-vt(ids_dyn))));
    a = t(ids_dyn)'*b/(norm(t(ids_dyn))^2);
    tau_nep = 1/a;

    fprintf('tau_nep = %.4g 1/s \n', tau_nep);
end