function labeca_02_bode()
    Ka = labeca_02_ploter_Ka;
    Kt = labeca_02_ploter_Kt;
    tau = labeca_02_tau_area;
    close all
    clc

    bode(Kt * Ka, [1 tau])
    grid
end