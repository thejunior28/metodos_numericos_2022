clear all;                                                                              % limpeza das variáveis armazenadas
clc;                                                                                % limpeza do prompt de comando

% Entrada de Dados
lin = input('n = ');                       
col = lin;

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

% Vetor solução b
for lin1 = 1:lin
    aux=0;
for col1 = 1:lin
    aux = aux+A(lin1,col1);
end
b(lin1,1) = aux/3;
end

fprintf('\nVetor solução b: \n');
disp (b);

tstart = tic;

% Matriz aumentada
c=[A b];
disp('Matriz aumentada: ');
disp(c);

% Eliminação
n=length(A);

for k=1:n-1
    for i=k+1:n
        m=c(i,k)/c(k,k);
        c(i,k)=0;
        for j=k+1:n+1
            c(i,j)=c(i,j)-m*c(k,j);
        end
    end
end

% Matriz triangular

disp('Matriz triangular aumentada: ');
disp(c);

A=c(:,1:j-1);
disp('Matriz triangular: ');
disp(A);

b=c(:,j);
disp('Matriz solução equivalente: ');
disp(b);

% Resolução do Sistema
n=length(A);
x(n,1)=b(n,1)/A(n,n);

for i=n-1:-1:1
    s=0;
    for j=i+1:n
        s=s+A(i,j)*x(j,1);
    x(i,1)=(b(i,1)-s)/A(i,i);
end
end

telapsed = toc(tstart);

disp('Solução:');
disp(x);

fprintf('\nTempo computacional: %d segundos', telapsed);