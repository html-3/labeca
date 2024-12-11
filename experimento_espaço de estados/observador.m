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

% Testando se a planta tem zeros na origem
[num,den] = ss2tf(A,b,c,0); % calcula a função de transferência

%% Rastreamento robusto com realimentação de estados e de saída
P = [-150 -5]; % eig(A) = -288.2302; -13.8708
k = place(A,b,P)'; % Ganhos de realimentação de estados
ki = 1;
A_cl = [A-b*k' ki*b;
            -c      0];
        
%eig(A_cl)
A_obs = [];
    
% 
% % Iterar sobre valores de ki para garantir que autovalores tenham parte real negativa
% ki_range = -10:0.1:10; % Intervalo de valores de ki
% valid_ki = []; % Lista de valores de ki válidos
% 
% for ki = ki_range
%     % Matriz ampliada com o integrador
%     A_cl = [A-b*k' ki*b;
%             -c      0];
%     
%     % Autovalores da matriz ampliada
%     eig_A_cl = eig(A_cl);
%     
%     % Verificar se todos os autovalores têm parte real negativa
%     if all(real(eig_A_cl) < 0)
%         valid_ki = [valid_ki, ki]; % Adicionar ki válido à lista
%     end
% end
% 
% if ~isempty(valid_ki)
%     disp('Valores de ki que satisfazem a condição:');
%     disp(valid_ki);
% else
%     disp('Não foi encontrado nenhum valor de ki que satisfaça a condição.');
% end
