function [Ra, La, f, J, va, vt, ia, t, Kt, Kg, Ka] = electrical_mechanical_parameters(filename)

    % Coleta de dados
    data = readtable(filename, 'ReadVariableNames', false);
    data = table2array(data);

    ia = 20*data(:,4); % Ganho na saída
    ia = ia(2:2:end);
    ia = ia- mean(ia);

    vt = data(:,3);
    vt = vt(2:2:end);
    vt = vt-mean(vt);

    va = data(:,2);
    va = va(2:2:end);
    va = va - mean(va);

    t = data(:,1);
    t = t(2:2:end);
    t(ids)

    % Definição do vetor entradas elétrico e mecânico
    Kt = 0.153; % Encontrado no primeiro experimento em laboratório
    Ka = 9.106; % Encontrado no primeiro experimento em laboratório
    Kg = 1/Ka;
    Ka = Kg; % Será alterado

    Ue = va-(Kg/Kt)*vt;
    Um = Ka*Kt*ia;

    % Montagem de Me e Mm
    Me = [ia(1:end-1), Ue(1:end-1)];
    Mm = [vt(1:end-1), Um(1:end-1)];

    % Mínimos quadrados para encontrar Xe e Xm
    Xe = inv(Me'*Me)*Me'*ia(2:end);
    Xm = inv(Mm'*Mm)*Mm'*vt(2:end);

    % Estimação dos parâmetros
    phi_e = Xe(1);
    phi_m = Xm(1);
    gamma_e = Xe(2);
    gamma_m = Xm(2);

    h = mean(diff(t)); % Intervalo de amostragem

    Ra = (1-phi_e)/gamma_e;
    La = -(Ra*h)/(log(phi_e));
    f = (1-phi_m)/gamma_m;
    J = -(f*h)/log(phi_m);

