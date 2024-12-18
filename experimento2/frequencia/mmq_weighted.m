function x = mmq_weighted(D,g,w)
    % Metodo dos Minimos Quadrados 

    % D - tabela de dados com duas colunas (x e y)
    % g - grau do polinomio de ajuste
    % A - matriz do sistema Ax = b
    % b - vetor do sistema Ax = b
    % w - vetor de pesos para ponderar a importância de cada dado de entrada
    
    % Se o vetor w não for especificado, então ele é um vetor linha de 1's
    if nargin == 2 || isempty(w)
        w = ones(1, length(D(:,2)));
    end
    
    w = diag(w);
    % Extrair o conjunto de pontos X e Y da tabela
    X = D(:, 1);
    b = w*D(:, 2);

    [m,~] = size(b);

    % Inicializar a matriz A
    A = zeros(m,g+1);
    
    % Preencher o sistema
    for i = 1:m
        for j = 1:(g+1)
            % Somatorio para cada elemento de A
            A(i, j) = X(i)^(g-j+1);
        end
    end
    A = w*A;
    % Resolver MMQ
    x = (A'*A)\(A'*b);
    % size(x)
end