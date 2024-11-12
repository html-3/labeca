function [Kg] = computing_Kg(filename)
    % Na seção 4.2 do artigo no classroom:
    % E = (Kg/Kt)*Vt, em que Km é a cte de torque, e Kg é cte de força contra-eletromotriz
    % Va aprox E, because there is no load connected to the armature circuit
    % Therefore, Va = (Kg/Kt)Vt
    
    % filename = dados_lin.csv
    
    addpath('D:\1_UFRJ\2024.2\labeca\labeca\experimento1'); % Para Carolina Rodar
    addpath('D:\1_UFRJ\2024.2\labeca\labeca\experimento2\degrau'); % Para Carolina Rodar
    
    [Kt, w, ~] = get_Kt(filename); % w é a velocidade de rotação do motor (rad/s) medida no 1º experimento
    [~, e, ~] = get_Ka(filename); % e é o Va medido no 1º experimento
    
    [K_barra, ~, ~] = get_K('dados.csv'); % K_degrau = 1.3897, e é do 2º experimento
    K = Kt/K_barra;
    
    %Kg = Kt*(w'*e)/(w'*w);
end


