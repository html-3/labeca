function [t_acommod, error] = Pi_Controler_Project(control,reference,tacometer)

origin = find(tacometer.signals.values(1,1:end)' > 1500,1);

% Plot do sinal de referência e sinal de resposta
figure(1)
plot(tacometer.time(origin:floor(end/5)), 5*2.795*tacometer.signals.values(1,origin:floor(end/5))/(4095));
hold on;
plot(reference.time(origin:floor(end/5)), 5*2.795*reference.signals.values(origin:floor(end/5))/(4095));
title('Entrada/Saída x Tempo');
legend('Sinal de Resposta', 'Sinal de Referência')
xlabel('Tempo(s)');
ylabel('Sinais de Referência e Resposta(V)');
grid on;

% Plot do sinal de controle
figure(2);plot(control.time(1:floor(end/5)), 5*2.795*control.signals.values(1,1:floor(end/5))/(4095));
title('Controle x Tempo');
xlabel('Tempo(s)');
ylabel('Sinais de Controle(V)');
grid on;

% Tempo de acomodação
ts = find(tacometer.signals.values(1,1:end)' > 0.98*reference.signals.values(1:end)',1); % Quando atinge 98% do valor do degrau de entrada
t_acommod = tacometer.time(ts);

% Erro em regime permanente
media = zeros(1,2);
values = [1,3];
for i = 1:2
    ids_lower = find(tacometer.time(1:end)>1*values(i));
    ids_upper = find(tacometer.time(1:end)<1.5*values(i));
    ids = intersect(ids_lower, ids_upper);

    media(1,i) = mean(tacometer.signals.values(1,ids));
end
error = 3500 - sum(media)/length(media);
error = 5*2.795*error/(4095);
