function [error] = labeca_02_erro_K()

    clc
    [~,K] = labeca_02_K_degrau;
    Ka = labeca_02_ploter_Ka;
    Kt = labeca_02_ploter_Kt;
    close all

    error = abs((Ka*Kt - K)/(Ka*Kt))*100;

end