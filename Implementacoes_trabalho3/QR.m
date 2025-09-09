clear;                                                                              % limpeza das variáveis armazenadas
clc;                                                                                % limpeza do prompt de comando

format short

% Matriz A

[A,rows,cols,entries,rep,field,symm] = mmread('bcsstk22.mtx');


if det(A)==0
   
    disp("Determinante é igual a zero!")

    return
end

tstart = tic;

% Decomposição QR

[m,n] = size(A);
Q = eye(m);

for k = 1:n
    z = A(k:m, k);
    v = [- sign(z(1)) * norm(z) - z(1); z(2:end)];
    v = v / sqrt(v' * v);
    for j = 1:n
        A(k:m, j) = v * 2* (v'*A(k:m, j));
    end
    for j = 1:m
        Q(k:m, j) = v * 2* (v'*Q(k:m, j));
    end
 end
 Q = Q';
 R = triu(A);

 telapsed = toc(tstart);

fprintf('\nMatriz A \n');
disp (A);

fprintf('\nMatriz Q \n');
disp (Q);

fprintf('\nMatriz R \n');
disp (R);

fprintf('\nTempo computacional: %d segundos\n', telapsed);