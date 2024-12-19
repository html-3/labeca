clear all

% PROJETAR PENSANDO EM 5% OVERSHOOT SUBAMORTECIDO, E DEPOIS PROJETAR PRA
% SER CRITICAMENTE AMORTECIDO
% DEPOIS, FAZER O SIMULINK DO PRÓXIMO EXPERIMENTO DO OBSERVADOR, USING
% EMBED SYSTEM

[Ra, La, f, J, t, va, vt, ia, Kt, Kg, Ka] = electrical_mechanical_parameters('buslin01.csv');

%% Modelagem do motor cc por um modelo de 2ª ordem
% dx/dt = [di_a/dt dv_t/dt]

A = [-Ra/La -Kg/(Kt*La);
     Ka*Kt/J -f/J]

b = [1/La ; 0]
c = [0 1]; % tensão

% Testando se o par A,b é controlável
Co = ctrb(A,b);
unco = length(A) - rank(Co); % Se unco == 0, então o par A,b é controlável 

% Testando se o par A,c é observável 
Ob = obsv(A,c);
unobsv = length(A) - rank(Ob); % Se unobsv == 0, então o par A,c é observável 

if unco == 0 && unobsv == 0
    
    % Testando se a planta tem zeros na origem
    [num,den] = ss2tf(A,b,c,0); % calcula a função de transferência
    sys_origin = tf(num,den)

    %% Rastreamento robusto com realimentação de estados e de saída
    
    disp('Polos do sistema sem controle: ');
    disp(eig(A));
    
    % PARTE Q PRECISA SER ANALISADA: A RESPOSTA TA DANDO UM OVERSHOOT
    % HORROROSO
%     PO = 5; % 5% de overshoot
%     csi_cl = abs(log(PO/100))/sqrt(pi^2 + log(PO/100)^2);
%     
%     load('labeca\experimento_controladores\Carolina_dados_PI\control.mat');
%     load('labeca\experimento_controladores\Carolina_dados_PI\reference.mat');
%     load('labeca\experimento_controladores\Carolina_dados_PI\tacometer.mat');
%     [tss_cl, ~] = Pi_Controler_Project(control,reference,tacometer)
%     close all
%     
%     wn_cl = 4/(tss_cl*csi_cl*1.5);
% 
%     pol_des_cl = [1, 2*csi_cl*wn_cl, wn_cl^2];
% 
    P = [-290 -40]; % eig(A) = -288.2302; -13.8708
    pol_des_cl = [1, -1*(P(1)+P(2)), P(1)*P(2)];
    
    syms s k1 k2
    k = [k1;k2];
    pol_caract = det((A-b*k') - s*eye(2,2));
    coeff_cl = coeffs(pol_caract, s, 'All');

    sol = solve(pol_des_cl(2) == coeff_cl(2), pol_des_cl(3) == coeff_cl(3));
    k = double([sol.k1;sol.k2]);
    
    disp('Ganhos k calculados: ');
    disp(k);
    
    disp('Polos realocados: ');
    disp(eig(A-b*k'));
    
    % Iterar sobre valores de ki para garantir que autovalores tenham parte real negativa
    ki_range = -1:0.1:100; % Intervalo de valores de ki
    valid_ki = []; % Lista de valores de ki válidos
    
    for ki = ki_range
        % Matriz ampliada com o integrador
        A_cl = [A-b*k' ki*b;
                -c      0];
        
        % Autovalores da matriz ampliada
        eig_A_cl = eig(A_cl);
        
        % Verificar se todos os autovalores têm parte real negativa
        if all(real(eig_A_cl) < 0)
            valid_ki = [valid_ki, ki]; % Adicionar ki válido à lista
        end
    end
    
    if ~isempty(valid_ki)
        
        fprintf('Intervalo de valores de ki que satisfazem a condição: [%.2f, %.2f]', valid_ki(1), valid_ki(end));
        
        ki_1 = valid_ki(1);
        ki_end = valid_ki(750);
        
        A_cl_1 = [A-b*k' ki_1*b; -c  0];
        A_cl_end = [A-b*k' ki_end*b; -c  0];
        
        fprintf('Para ki %.2f, tem-se que os autovalores de A_cl são: \n', valid_ki(1))
        display(eig(A_cl_1))
        fprintf('\nE para o 2° valor de ki como %.2f, os autovalores são: \n', valid_ki(750))
        display(eig(A_cl_end))
        
    else
        disp('Não foi encontrado nenhum valor de ki que satisfaça a condição. \n');
    end
    
    b_cl = [0; 0; 1];
    c_cl = [c 0];
    [numerador,denominador] = ss2tf(A_cl_end,b_cl,c_cl,0); % MUDEI AQUI OH
    disp('Função de Transferência do controle de malha fechada: ');
    sys = tf(numerador,denominador)
    
    figure(1);
    rlocus(sys);
    
    % https://www.mathworks.com/help/ident/ref/stepdataoptions.html
    % Zona linear: 4.55V a 14.99V
    % Config = RespConfig(Bias=5,Amplitude=8,Delay=0); % disponível p/ versões posteriores a 2023a
    opt = stepDataOptions('InputOffset',5,'StepAmplitude',8);
    
    figure(2)
    step(sys,opt)
    sys_info = stepinfo(sys);
    % Tempo de acomodação da resposta do sistema em malha fechada com PI robusto
    tss = sys_info.SettlingTime

    %% Projeto do observador
  
    csi = 1; % criticamente amortecido(sem overshoot, para não haver risco de sair da zona linear)
    wn = 4/(tss*csi);
    wn_observador = 5*wn; % 5 vezes maior para ser mais rápido e não interferir  no sistema

    pol_desejado = [1, 2*csi*wn_observador, wn_observador^2];

    syms s l_1 l_2
    l = [l_1;l_2];
    A_hat = A-l*c;
    pol_caracteristico = det(s*eye(2,2)-A_hat);
    coeff = coeffs(pol_caracteristico, s, 'All');

    sol = solve(pol_desejado(2) == coeff(2), pol_desejado(3) == coeff(3));
    l = double([sol.l_1;sol.l_2]);
    
    disp('Ganhos L do observador: ');
    disp(l);
    
    % Testando se a dinâmica do observador é realmente mais rápida que a do
    % sistema com o controle PI (NÃO CREIO Q ESSA PARTE SEJA REALMENTE NECESSÁRIA)
%     A_obs = A-l*c;
%     [num_obs,den_obs] = ss2tf(A_obs,[0;0],c,0);
%     sys_obs = tf(num_obs,den_obs);
% 
%     figure(3)
%     x0 = [0 ; 2];
%     initial(ss(A_obs,[0;0], c, 0), x0)
    
%     step(sys_obs, x0, opt)
%     sys_obs_info = stepinfo(sys_obs);
%     tss_obs = sys_obs_info.SettlingTime

 %% Juntando o controle realimentado robusto com o observador 

    % A dimensão da matriz A é de 2x2, e b*k' é 2x2, logo (A - b*k') é 2x2
    % A dimensão de ki_1*b é 2x1, e a de c é 1x2
    % Logo, a matriz A_cl que é [A-b*k' ki*b; -c 0], tem dimensão 3x3
    % Se A é 2x2, então (A-l*c) também precisa ser 2x2, portanto, 'l' deve ser 2x1, e seguindo a eq. 5.35
    % da apostila de 2008 (pg 71), precisa ter um vetor linha de zeros abaixo
    % de b*k', logo esse vetor tem tamanho 1x2, assim, tem-se:

    % Matriz ampliada com o integrador e observador:
    A_cl_obs = [A_cl_end; zeros(2,3)]; % AQUI TB
    vetor_obs = [b*k'; 0 0; A-l*c];
    A_full = [A_cl_obs vetor_obs];
    eig_A_full = eig(A_full);

    b_full = [0 0 1 0 0]';
    c_full = [c 0 0 0];

    [num_full,den_full] = ss2tf(A_full,b_full,c_full,0);
    sys_full = tf(num_full,den_full);

    figure(3)
    step(sys_full,opt)
    sys_full_info = stepinfo(sys_full);
    tss_full = sys_full_info.SettlingTime

end