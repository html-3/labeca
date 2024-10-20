function [t, va, vt, K_degrau, tau_area, tau_nep] = labeca_02_simulink_export()
    tau_nep = labeca_02_tau_neperiano();
    tau_area = labeca_02_tau_area();
    [t, va, vt, ~, K_degrau] = labeca_02_K_degrau();

    clc
    close all
end