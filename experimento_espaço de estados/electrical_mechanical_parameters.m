function [Ra, La, f, J, t, va, vt, ia, Kt, Kg, Ka] = electrical_mechanical_parameters(filename)

    % filename = 'buslin01.csv'
    
    % Coleta de dados
    data = readtable(filename, 'ReadVariableNames', false);
    data = table2array(data);

    ia = 20*data(:,4); % Ganho na saída
    ia = ia(2:2:end);
    ia = ia - mean(ia); % Remoção de Offset de ia

    vt = data(:,3);
    vt = vt(2:2:end);
    vt = vt-mean(vt);% Remoção de Offset de vt

    va = data(:,2);
    va = va(2:2:end);
    va = va - mean(va);% Remoção de Offset de va

    t = data(:,1);
    t = t(2:2:end);

    V = [va, vt, ia];
    index = find(V>=0,1);

    t = t(index:end);
    V = V(index:end, :);
    
    va = V(:,1);
    vt = V(:,2);
    ia = V(:,3);

    
    % Definição do vetor entradas elétrico e mecânico
    [Kt, ~, ~] = get_Kt('dados_lin.csv'); % Encontrado no 1º experimento em laboratório
    [Kg] = computing_Kg('dados_lin.csv');
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

