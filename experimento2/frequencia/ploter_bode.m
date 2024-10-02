function ploter_bode()
    Ka = get_Ka;
    Kt = get_Kt;
    tau = get_tau_area;

    bode(Kt * Ka, [tau 1])
    grid
end