function x = mmq_origin(D, g)
    % Metodo dos Minimos Quadrados com coeficiente linear zero
    
    % D - tabela de dados com duas colunas (x e y)
    % g - grau do polinomio de ajuste
    % A - matriz do sistema Ax = b
    % b - vetor do sistema Ax = b

    % Extrair o conjunto de pontos X e Y da tabela
    X = D(:, 1);
    Y = D(:, 2);

    % Definir a quantidade de coeficientes (grau do polinomio + 1)
    M = g + 1;

    % Inicializar as matrizes A e b
    A = zeros(M, M-1);
    b = zeros(M, 1);

    % Preencher o sistema
    for i = 1:M
        for j = 1:M
            % Somatorio para cada elemento de A
            A(i, j) = sum(X .^ (j + i - 2));     
        end

        % Somatorio para cada elemento de b
        b(i) = sum(Y .* (X .^ (i - 1)));
    end
    % Resolver MMQ
    x = flip(inv(A.'*A) * A.' * b, 1); % Inverte ordem dos coeficientes
    x(end) = 0;
end