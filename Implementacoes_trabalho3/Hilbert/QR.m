clear;                                                                              % limpeza das variáveis armazenadas
clc;                                                                                % limpeza do prompt de comando

% Entrada de Dados
lin = input('n = ');                       
col = lin;

format short

% Matriz A

y=1;
n=2;

p=input('Usar função hib(n) do MATLAB (y/n)? ');

if p==1

    A=hilb(lin);

    fprintf('\nMatriz A: \n');
disp (A);

if det(A)==0
   
    disp("Determinante é igual a zero!")

    return
end

disp('Determinante: ');
disp(det(A));

else
    
for lin1 = 1:lin
    for col1 = 1:col
        A(lin1,col1) = 1/(lin1+col1-1);
    end
end

fprintf('\nMatriz A: \n');
disp (A);

if det(A)==0
   
    disp("Determinante é igual a zero!")

    return
end

disp('Determinante: ');
disp(det(A));

end

% Função y = f(x)

for lin1 = 1:lin
    aux=0;
for col1 = 1:lin
    aux = aux+A(lin1,col1);
end
y(lin1,1) = aux/3;
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

fprintf('\ny = \n');
disp (y);

fprintf('\nMatriz Q \n');
disp (Q);

fprintf('\nMatriz R \n');
disp (R);

fprintf('\nTempo computacional: %d segundos\n', telapsed);