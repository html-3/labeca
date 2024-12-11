clear all

[Ra, La, f, J, t, va, vt, ia, Kt, Kg, Ka] = electrical_mechanical_parameters('buslin01.csv');

%% Modelagem do motor cc por um modelo de 2ª ordem
% dx/dt = [di_a/dt dv_t/dt]

A = [-Ra/La -Kg/(Kt*La);
     Ka*Kt/J -f/J];

b = [1/La ; 0];
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

    %% Rastreamento robusto com realimentação de estados e de saída
    P = [-150 -5]; % eig(A) = -288.2302; -13.8708
    k = place(A,b,P)'; % Ganhos de realimentação de estados
%     ki = 1;
%     A_cl = [A-b*k' ki*b;
%                 -c      0];
    
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
        
        fprintf('Intervalo de valores de ki que satisfazem a condição: [%.2f, %.2f] \n', valid_ki(1), valid_ki(end));
        
        ki_1 = valid_ki(1);
        ki_end = valid_ki(end);
        
        A_cl_1 = [A-b*k' ki_1*b; -c  0];
        A_cl_end = [A-b*k' ki_end*b; -c  0];
        
        fprintf('Para ki %.2f, tem-se que os autovalores de A_cl são: \n', valid_ki(1))
        display(eig(A_cl_1))
        fprintf('\nE para o 2° valor de ki como %.2f, os autovalores são: \n', valid_ki(end))
        display(eig(A_cl_end))
        
    else
        disp('Não foi encontrado nenhum valor de ki que satisfaça a condição. \n');
    end
  
  %% Projeto do observador
  
    % Tempo de acomodação da resposta do sistema em malha fechada com PI
    load('labeca\experimento_controladores\Carolina_dados_PI\control.mat');
    load('labeca\experimento_controladores\Carolina_dados_PI\reference.mat');
    load('labeca\experimento_controladores\Carolina_dados_PI\tacometer.mat');
    [tss, ~] = Pi_Controler_Project(control,reference,tacometer);
    close all

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

    % A dimensão da matriz A é de 2x2, e b*k' é 2x2, logo (A - b*k') é 2x2
    % A dimensão de ki_1*b é 2x1, e a de c é 1x2
    % Logo, a matriz A_cl que é [A-b*k' ki*b; -c 0], tem dimensão 3x3
    % Se A é 2x2, então (A-l*c) também precisa ser 2x2, portanto, 'l' deve ser 2x1, e seguindo a eq. 5.35
    % da apostila de 2008 (pg 71), precisa ter um vetor linha de zeros abaixo
    % de b*k', logo esse vetor tem tamanho 1x2, assim, tem-se:
    
    % Matriz ampliada com o integrador e observador:
    A_cl_obs = [A_cl_1; zeros(2,3)];
    vetor_obs = [b*k'; 0 0; A-l*c];
    A_obs = [A_cl_obs vetor_obs];
    eig_A_obs = eig(A_obs)

end