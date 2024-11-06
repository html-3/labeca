function [Ra, La, f, J] = electrical_mechanical_parameters(filename)

    % Coleta de dados
    data = readtable(filename, 'ReadVariableNames', false);
    data = table2array(data);
    ia = 20*data(:,4); % Ganho na saída
    vt = data(:,3);
    va = data(:,2);
    t = data(:,1);

    % Definição do vetor entradas elétrico e mecânico
    Kt = 0.153; % Encontrado no primeiro experimento em laboratório
    Ka = 9.106;    % Encontrado no primeiro experimento em laboratório
    Kg = 1;    % Será alterado

    Ue = va-(Kg/Kt)*vt;
    Um = Ka*Kt*ia;

    % Montagem de Me e Mm
    Me = [[0;ia(1:end-1)] [0;Ue(1:end-1)]];
    Mm = [[0;vt(1:end-1)] [0;Um(1:end-1)]];

    % Mínimos quadrados para encontrar Xe e Xm
    Xe = inv(Me'*Me)*Me'*ia;
    Xm = inv(Mm'*Mm)*Mm'*vt;

    % Estimação dos parâmetros
    phi_e = Xe(1);
    phi_m = Xm(1);
    gamma_e = Xe(2);
    gamma_m = Xe(2);
 
    h = (t(end)-t(1))/length(t);% Intervalo de amostragem

    Ra = (1-phi_e)/gamma_e;
    La = -(Ra*h)/(log(phi_e));
    f = (1-phi_m)/gamma_m;
    J = -(f*h)/log(phi_m);

