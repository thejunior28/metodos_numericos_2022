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

% Solução com ajuste exponencial

y=log(y);

tstart = tic;

x = (A'*A)\(A'*y);
y_ap = A*x;

% Erro quadrático médio
n = length(y);
e  = y - y_ap;
E = (e'*e)/n;

telapsed = toc(tstart);

fprintf('\ny = \n');
disp (y);

disp('y aproximado:');
disp(y_ap);

disp('[X] =');
disp(x);

disp('Erro:');
disp(E);


fprintf('\nTempo computacional: %d segundos\n', telapsed);