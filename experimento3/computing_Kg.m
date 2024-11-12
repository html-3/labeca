function [Kg] = computing_Kg(filename)

    % E = (Kg/Kt)*Vt
    % Va aprox E, because there is no load connected to the armature circuit
    % Therefore, Va = (Kg/Kt)Vt

    % filename = 'dados_lin.csv'

    [Kt, w, ~] = get_Kt(filename);
    [~, e, ~] = get_Ka(filename);
    Kg = Kt*(w'*e)/(w'*w);

end