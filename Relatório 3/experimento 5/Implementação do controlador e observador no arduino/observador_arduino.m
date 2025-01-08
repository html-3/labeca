clear all

% Neste arquivo são calculadas as matrizes do sistema, e então os ganhos do controlador e do observador,
% para posteriormente usar esses valores no Simulink, chamado Arduino_observador_2021.slx .

[Ra, La, f, J, t, va, vt, ia, Kt, Kg, Ka] = electrical_mechanical_parameters();

%% Construção Observador de estados
% Definição das matrizes
A = [-Ra/La -Kg/(Kt*La);
     Ka*Kt/J -f/J];
B = [1/La ; 0];
C = [0 1]; % estados: [i_a, vt]
D = zeros(2, 1); 

%% Verificação de observabilidade e controlabilidade 
% Matriz de Observabilidade
O = obsv(A, C);
disp(' ');
disp('Matriz de Observabilidade:');
disp(O);

% Verificar o posto da matriz de observabilidade
if rank(O) == size(A,1)
    disp('O sistema é observável.');
else
    disp('O sistema NÃO é observável.');
end

% Matriz de Controlabilidade
Ctrl = ctrb(A,B);
disp(' ');
disp('Matriz de Controlabilidade:');
disp(Ctrl);

% Verificar o posto da matriz de Controlabilidade
if rank(Ctrl) == size(A,1)
    disp('O sistema é controlável.');
else
    disp('O sistema NÃO é controlável.');
end
disp(' ');

%% Construção dos ganhos do Observador

% Polos do sistema original
poles_system = eig(A);
disp('Polos do sistema original:');
disp(poles_system);

% Escolha dos polos do observador
desired_poles = [poles_system(1), poles_system(2)*3 ];
disp('Polos desejados para o observador:');
disp(desired_poles);

% Cálculo da matriz L (alocação de polos)
L = place(A', C', desired_poles)';
disp('Vetor de ganho do observador:');
disp(L);

%% Projeto dos ganhos do Controle Robusto
syms K1 K2 ki s;  

A_r = [A(1,1) - B(1:1)*K1 A(1,2)-B(1:1)*K2 ki*B(1:1);
    A(2,1) A(2,2) 0;
    0 -C(2) 0];

det_A_r = collect(det(s*eye(size(A_r))-A_r));
coeffs_det_A_r = coeffs(det_A_r, s);

% Alocação de polos
desired_poles1 = [poles_system(2)+1j*poles_system(2), poles_system(2)-1j*poles_system(2), poles_system(1)];
disp('Polos desejados para o controle robusto:');
disp(desired_poles1);

pol_caract = poly(desired_poles1);

ki = double(solve(coeffs_det_A_r(end-3)==pol_caract(4), ki));
K1 = double(solve(coeffs_det_A_r(end-1)==pol_caract(2), K1));

% Uma vez calculados ki e K1, substituindo os valores 
% encontrados na matriz A_r, e então calcula-se K2
A_r = [A(1,1) - B(1:1)*K1 A(1,2)-B(1:1)*K2 ki*B(1:1);
    A(2,1) A(2,2) 0;
    0 -C(2) 0];
det_A_r = collect(det(s*eye(size(A_r))-A_r));
coeffs_det_A_r = coeffs(det_A_r, s);

K2 = double(solve(coeffs_det_A_r(end-2)==pol_caract(3), K2));

K = [K1 K2];

disp('Ganhos do controle robusto:');
disp('K = ');
disp(K);
disp('ki = ');
disp(ki);