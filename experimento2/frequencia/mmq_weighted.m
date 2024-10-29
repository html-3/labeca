function x = mmq_weighted(D,w, g)
    % Metodo dos Minimos Quadrados 

    % D - tabela de dados com duas colunas (x e y)
    % g - grau do polinomio de ajuste
    % A - matriz do sistema Ax = b
    % b - vetor do sistema Ax = b

    % Extrair o conjunto de pontos X e Y da tabela
    X = D(:, 1);
    b = D(:, 2);

    % Inicializar a matriz A
    A = zeros(size(b),g+1);
    
    % Preencher o sistema
    for i = 1:size(b)
        for j = 1:(g+1)
            % Somatorio para cada elemento de A
            A(i, j) = X(i)^(g-i+1)     
        end

        % Somatorio para cada elemento de b
        b(i) = sum(Y .* (X .^ (i - 1)));
    end
    A
    b
    % Resolver MMQ
    x = flip(inv(A.'*A) * A.' * b, 1); % Inverte ordem dos coeficientes
    size(x)
end