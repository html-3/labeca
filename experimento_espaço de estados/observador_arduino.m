[Ra, La, f, J, t, va, vt, ia, Kt, Kg, Ka] = electrical_mechanical_parameters('buslin01.csv');
[~, ~, Kd1, Kd2, Ko, Ki, ~, ~, ~] = control_params()

%% Construção Observador de estados

% Definição das matrizes
A_mod = [-Ra/La, -Kg/(La*Kt*Kd2*Ki);
     Kt*Ka/J, -f/(J*Kd2*Ki)];
B_mod = [1/(La*Kd1*Ko); 0];
% C = [0 1]; % Agora o sistema mede diretamente ambos os estados: [i_a, ω]

A = [-Ra/La -Kg/(Kt*La);
     Ka*Kt/J -f/J];
B = [1/La ; 0];
C = [0 1]; % Agora o sistema mede diretamente ambos os estados: [i_a, ω]
D = zeros(2, 1); % Nenhuma influência direta da entrada na saída

% Verificação de observabilidade para viabilidade de alocação de polos
% Matriz de Observabilidade
O = obsv(A, C);
disp('Matriz de Observabilidade:');
disp(O);

% Verificar o posto da matriz de observabilidade
if rank(O) == size(A,1)
    disp('O sistema é observável.');
else
    disp('O sistema NÃO é observável.');
end

% Polos do sistema original
poles_system = eig(A);
disp('Polos do sistema original:');
disp(poles_system);

% Escolha dos polos do observador (mais negativos que os do sistema)
desired_poles = [poles_system(1), poles_system(2)*3 ]; % Ajuste conforme necessário
disp('Polos desejados para o observador:');
disp(desired_poles);

% Cálculo da matriz K (alocação de polos)
L = place(A', C', desired_poles)'; % C agora é 2x2, então L será 2x2
disp('Matriz L do observador:');
disp(L);

% Dinâmica do observador
A_observer = A - B*L';
B_observer = [B, L]; % Adiciona as entradas físicas e as saídas medidas
C_observer = eye(size(A)); % O observador fornece todos os estados estimados
D_observer = zeros(size(A, 1), size(B_observer, 2)); % Ajustar para entradas combinadas

% Mostrar matrizes do observador
disp('Matrizes do Observador:');
disp('A_observer = '), disp(A_observer);
disp('B_observer = '), disp(B_observer);
disp('C_observer = '), disp(C_observer);
disp('D_observer = '), disp(D_observer);

% Sistema de espaço de estados do observador
observer_system = ss(A_observer, B_observer, C_observer, D_observer);

disp('Sistema de Espaço de Estados do Observador criado.');

%% Construção do Controle Robusto
% A = [-Ra/La, -Kg/(La*Kt*Kd2*Ki);
%      Kt*Ka/J, -f/(J*Kd2*Ki)];
% B = [1/(La*Kd1*Ko); 0];
% C = [0 1]; % Agora o sistema mede diretamente ambos os estados: [i_a, ω]

A = [-Ra/La -Kg/(Kt*La);
     Ka*Kt/J -f/J];
B = [1/La ; 0];
C = [0 1];
syms Kt_control_1 Kt_control_2 ki s;  % Adicionando 's' como variável simbólica

A_r = [A(1,1) - B(1:1)*Kt_control_1 A(1,2)-B(1:1)*Kt_control_2 ki*B(1:1);
    A(2,1) A(2,2) 0;
    0 -C(2) 0];

det_A_r = collect(det(s*eye(size(A_r))-A_r));
coeffs_det_A_r = coeffs(det_A_r, s)

% Alocação de polos
desired_poles1 = [poles_system(2), poles_system(2), poles_system(1)]

pol_caract = poly(desired_poles1)

    
ki = double(solve(coeffs_det_A_r(end-3)==pol_caract(4), ki))

Kt_control_1 = double(solve(coeffs_det_A_r(end-1)==pol_caract(2), Kt_control_1))

A_r = [A(1,1) - B(1:1)*Kt_control_1 A(1,2)-B(1:1)*Kt_control_2 Ki*B(1:1);
    A(2,1) A(2,2) 0;
    0 -C(2) 0];
det_A_r = collect(det(s*eye(size(A_r))-A_r));
coeffs_det_A_r = coeffs(det_A_r, s)

Kt_control_2 = double(solve(coeffs_det_A_r(end-2)==pol_caract(3), Kt_control_2))

K_prime = [Kt_control_1 Kt_control_2]
display(L)
display(Ki)

A_r = [A(1,1) - B(1:1)*Kt_control_1 A(1,2)-B(1:1)*Kt_control_2 ki*B(1:1);
    A(2,1) A(2,2) 0;
    0 -C(2) 0];

eig(A_r)