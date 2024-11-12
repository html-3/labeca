function [Ra, La, f, J, t, va, vt, ia, Kt, Kg, Ka] = electrical_mechanical_parameters(filename)

    % filename = 'buslin01.csv'

    % Coleta de dados
    data = readtable(filename, 'ReadVariableNames', false);
    data = table2array(data);
    
    % Vetor corrente de armadura
    G = 20; % Ganho na saída
    ia = G * data(:,4); 
    ia = ia(2:2:end); % Metade do sampling
    ia = ia - mean(ia(1:4)); % Remoção de Offset de ia
    
    % Vetor tensão tacômetro
    vt = data(:,3);
    vt = vt(2:2:end); % Metade do sampling
    vt = vt-mean(vt(1:4)); % Remoção de Offset de vt
    
    % Vetor tensão de armadura
    va = data(:,2);
    va = va(2:2:end); % Metade do sampling
    va = va - mean(va(1:4)); % Remoção de Offset de va
    
    % Vetor tempo
    t = data(:,1);
    t = t(2:2:end); % Metade do sampling
    t = t - t(1); % Remoção de Offset de t
    
    % Remoção de valores pequenos (?)
    V = [va, vt, ia];
    index = find(V >= 0,1);
    t = t(index:end);
    V = V(index:end,:);
    
    va = V(:,1);
    vt = V(:,2);
    ia = V(:,3);
    
    % Definição do vetor entradas elétrico e mecânico
    [Kt, ~, ~] = get_Kt('dados_lin.csv'); % Encontrado no primeiro experimento em laboratório
    [Kg] = computing_Kg('dados_lin.csv');
    Kg = Kg;
    
    % Como Ka tem a mesma dimensão de Kg, eles são iguais (Basilio, 2004)
    Ka = Kg; % Será alterado
    
    % Variáveis de estado intermediárias
    Ue = va - (Kg/Kt) *vt;
    Um = Ka*Kt*ia;

    % Montagem de Me e Mm
    Me = [ia(1:end-1), Ue(1:end-1)];
    Mm = [vt(1:end-1), Um(1:end-1)];

    % Mínimos quadrados para encontrar Xe e Xm
    Xe = inv(Me'*Me)*Me'*ia(2:end);
    Xm = inv(Mm'*Mm)*Mm'*vt(2:end);

    % Estimação dos parâmetros elétricos e mecânicos
    phi_e = Xe(1);
    gamma_e = Xe(2);
    phi_m = Xm(1);
    gamma_m = Xm(2);
    
    % Intervalo de amostragem
    h = mean(diff(t)); 

    Ra = (1-phi_e)/gamma_e;
    La = -(Ra*h)/log(phi_e);
    f = (1-phi_m)/gamma_m;
    J = -(f*h)/log(phi_m);
end
