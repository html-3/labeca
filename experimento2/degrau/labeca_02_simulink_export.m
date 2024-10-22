function [K_degrau, tau_area, tau_nep] = labeca_02_simulink_export(filename)
    tau_nep = get_tau_nep(filename);
    tau_area = get_tau_area(filename);
    [K_degrau, ~, ~] = get_K(filename); % output of get_K is K_degrau, y_inf and A

    clc
    close all
end