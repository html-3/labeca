function [gjw_abs] = fourier(n_harm)

    % Criar um For para rodar todas as frequências coletadas e encontrar as
    % harmonicas de cada frequencia 
    % 3 vetores: 1 para os ganhos, 1 para as fases e 1 para as
    % frequências naturais de cada frequência

    % Carregar o arquivo CSV
    data = readtable('carolina_dados.CSV');
    data = table2array(data);
    vt = data(:,3);
    va = data(:,2);
    t = data(:,1);

  
    % numero de pontos
    p = length(t)-1;
    % intervalo de amostragem
    h = diff(t);
    h = h(1);

    T = p*h;

    a_0_ut = trapz(t,ut)/T;
    a_0_yt = trapz(t,yt)/T;

    % Quantidade de Harmônicos desejada
    N = n_harm;

    c_ut = zeros(1,N+1);
    c_yt = zeros(1,N+1);

    c_ut(1) = [a_0_ut];
    c_yt(1) = [a_0_yt];

    phi_ut = zeros(1,N);
    phi_yt = zeros(1,N);

    
    for n = 1:N
        an_ut = (2/T)*trapz(t,cos(2*pi*n*(t/T)).*ut);
        an_yt = (2/T)*trapz(t,cos(2*pi*n*(t/T)).*yt);

        bn_ut = (2/T)*trapz(t,sin(2*pi*n*(t/T)).*ut);
        bn_yt = (2/T)*trapz(t,sin(2*pi*n*(t/T)).*yt);

        zn_ut = bn_ut+1j*an_ut;
        zn_yt = bn_yt+1j*an_yt;

        c_ut(n+1) = abs(zn_ut);
        c_yt(n+1) = abs(zn_yt);

        phi_ut(n) = angle(zn_ut);
        phi_yt(n) = angle(zn_yt);

    end

    %gjw_abs = c_yt./c_ut;
    

end