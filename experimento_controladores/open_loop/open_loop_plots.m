function [t_acommod, error] = open_loop_plots(out)

% Tempo de acomodação
ts = find(out.vt.Data > 0.98*out.vt_ref.Data,1); % Quando atinge 98% do valor do degrau de entrada
t_acommod = out.vt.Time(ts);

% Erro em regime permanente
vt = out.vt.Data(end);
error = 10 - vt;

% Plots do simulink
figure(1)
title('Vt,Vt_ref x T');
plot(out.vt.Time, out.vt.Data, out.vt_ref.Time, out.vt_ref.Data);
xlabel('Tempo(s)');
legend('Resposta do sistema', 'Entrada Degrau de Referência');
ylabel('Vt,Vt_ref');
grid on;