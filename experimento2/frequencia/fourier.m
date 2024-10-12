function [gjw_abs, gjw_phi] = fourier(n_harm, t_lower, t_upper, path)

    clc

    % Criar um For para rodar todas as frequências coletadas e encontrar as
    % harmonicas de cada frequencia 
    % 3 vetores: 1 para os ganhos, 1 para as fases e 1 para as
    % frequências naturais de cada frequência

    % Carregar o arquivo CSV
    data = readtable(path);
    data = table2array(data);
    vt = data(:,3);
    va = data(:,2);
    t = data(:,1);

    % Intervalo antes do inicio do sinal
    ids_lower = find(t>t_lower);
    ids_upper = find(t<t_upper);
    ids = intersect(ids_lower, ids_upper);
    
    va = va(ids);
    vt = vt(ids);
    t = t(ids);

  
    % numero de pontos
    p = length(t)-1;

    % intervalo de amostragem
    h = mean(diff(t));

    T = p*h;

    a_0_va = trapz(t,va)/T;
    a_0_vt = trapz(t,vt)/T;

    % Quantidade de Harmônicos desejada
    N = n_harm;

    c_va = zeros(1,N+1);
    c_vt = zeros(1,N+1);

    c_va(1) = a_0_va;
    c_vt(1) = a_0_vt;

    phi_va = zeros(1,N);
    phi_vt = zeros(1,N);

    
    for n = 1:N
        an_va = (2/T)*trapz(t,cos(2*pi*n*(t/T)).*va);
        an_vt = (2/T)*trapz(t,cos(2*pi*n*(t/T)).*vt);

        bn_va = (2/T)*trapz(t,sin(2*pi*n*(t/T)).*va);
        bn_vt = (2/T)*trapz(t,sin(2*pi*n*(t/T)).*vt);

        zn_va = bn_va+1j*an_va;
        zn_vt = bn_vt+1j*an_vt;

        c_va(n+1) = abs(zn_va);
        c_vt(n+1) = abs(zn_vt);

        phi_va(n) = angle(zn_va);
        phi_vt(n) = angle(zn_vt);

    end
   
    gjw_abs = c_vt(2)/c_va(2);
    gjw_phi = phi_vt - phi_va;
 
end