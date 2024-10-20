function [t, va, vt] = labeca_02_validacao
    data = readtable('dados_validacao.CSV');
    data = table2array(data);
    
    t = data(:,1) - data(1,1);

    tmin = 0.629;
    tmax = tmin + 0.4;
    ids_min = find(t>tmin);
    ids_max = find(t<tmax);
    t_ids = intersect(ids_min, ids_max);
    
    t = t(t_ids) - tmin;
    va = data(t_ids,2)- 5.9;
    vt = data(t_ids,3) + 5.360;
    
    
    Ka = labeca_02_ploter_Ka;
    Kt = labeca_02_ploter_Kt;
    tau = labeca_02_tau_neperiano;
    close all
    plot(t,va)
    hold on
    plot(t,vt)
    grid
end