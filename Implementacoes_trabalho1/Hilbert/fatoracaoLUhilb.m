clear;                                                                              % limpeza das variáveis armazenadas
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

% Decomposição LU
n = length(A);                                                                          % ordem da matriz A
U = zeros(n);                                                                           % matriz de zeros para montagem da matriz superior
L = zeros(n);                                                                           % matriz de zeros para montagem da matriz inferior

for j=1:n                                                                               % criação de um vetor para alocação da posição dos pivôs
    pivot(j,1)=j;
end

Det=1;                                                                                  % inicialização do determinante

for j=1:n-1                                                                             % decomposição via pivotação parcial
    p=j;
    Amax=abs(A(j,j));
    for k=j+1:n
        if abs(A(k,j))>Amax
            Amax=abs(A(k,j));
            p=k;
        end
    end
    if p~=j
        for k=1:n
            t=A(j,k);
            A(j,k)=A(p,k);
            A(p,k)=t;
        end
    m=pivot(j,1);
    pivot(j,1)=pivot(p,1);
    pivot(p,1)=m;
    Det=-Det;
    end
    Det=Det*A(j,j);
    if abs(A(j,j))~=0
        r=1/A(j,j);
        for l=j+1:n
            mult = A(l,j)*r;
            A(l,j)=mult;
            for m=j+1:n
                A(l,m)=A(l,m)-mult*A(j,m);
            end
        end
    end
end

Det=Det*A(n,n);

for j=1:n                                                                               % montagem das matrizes L e U
    for k=1:n
        if j<=k
            U(j,k)=A(j,k);
        else
            L(j,k)=A(j,k);
        end
    end
end

L=L+eye(n);

% Resolução do Sistema

y(1,1)=b(pivot(1,1),1);

for j=2:n
    soma=0;
    for k=1:j-1
        soma=soma+L(j,k)*y(k,1);
    end
    y(j,1)=b(pivot(j,1),1)-soma;
end

n=length(U);
x(n,1)=y(n,1)/U(n,n);
for j=n-1:-1:1
    aux=0;
    for k=j+1:n
        aux=aux+U(j,k)*x(k,1);
    end
    x(j,1)=(y(j,1)-aux)/U(j,j);
end

telapsed = toc(tstart);

% Apresentação do Resultado
disp('Matriz L:');
disp(L);
disp('Matriz U: ');
disp(U);
disp('Solução:');
disp(x);

fprintf('\nTempo computacional: %d segundos', telapsed);