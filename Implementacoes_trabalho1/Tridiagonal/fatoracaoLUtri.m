clear;                                                                              % limpeza das variáveis armazenadas
clc;                                                                                % limpeza do prompt de comando

% Entrada de Dados
t=input('Digite o valor dos elementos da diagonal abaixo: ');

if t==0
    fprintf('Digite um número diferente de zero!')
    return
end

r=input('Digite o valor dos elementos da diagonal principal: ');

if r==0
    fprintf('Digite um número diferente de zero!')
    return
end

q=input('Digite o valor dos elementos da diagonal acima: ');

if q==0
    fprintf('Digite um número diferente de zero!')
    return
end

f=[t;r;q];

lin = input('Digite o número da ordem da matriz quadrada: ');

if lin<=0
    return
end

A=zeros(lin);

for i=1:lin
    for j=1:lin
        if i==j+1
            A(i,j)=f(1);
        elseif i==j
            A(i,j)=f(2);
        elseif i==j-1
            A(i,j)=f(3);
        end
    end
end

disp('A matriz tridigonal é: ')
disp(A);

if det(A)==0
   
    disp("Determinante é igual a zero!")

    return
end

% Vetor solução b
for b1 = 1:lin
    fprintf('Digite o valor para a posição do vetor (%d,%d): ', b1,1)
    b(b1,1) = input('');
end

fprintf('\nVetor solução b: \n');
disp (b);

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

% Apresentação do Resultado
disp('Matriz L:');
disp(L);
disp('Matriz U: ');
disp(U);
disp('Determinante:');
disp(Det);
disp('Solução:');
disp(x);