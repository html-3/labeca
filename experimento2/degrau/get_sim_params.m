function [K, tau_nep, tau_area, t, vt, va] = get_sim_params(filename)
  % Coleta de dados
  data = readtable(filename);
  data = table2array(data);
  vt = data(:,3);
  va = data(:,2);
  t = data(:,1);

  % Obter parametros
  [K, ~, ~] = get_K(filename);
  [tau_area] = get_tau_area(filename);
  [tau_nep] = get_tau_nep(filename);

  % Intervalo do sinal
  ids_lower = find(t>-0.1);
  ids_upper = find(t<0.7);
  ids = intersect(ids_lower, ids_upper);

  % Intervalo antes do inicio do sinal
  ids_lower_pre = find(t>-0.1);
  ids_upper_pre = find(t<0.0);
  ids_pre = intersect(ids_lower_pre, ids_upper_pre);

  % Média do inicio do sinal
  va_min = mean(va(ids_pre));
  vt_min = mean(vt(ids_pre));
  
  % Deslocando os sinais para zero
  t = t(ids);
  vt = vt(ids) - vt_min;
  va = va(ids) - va_min;
end