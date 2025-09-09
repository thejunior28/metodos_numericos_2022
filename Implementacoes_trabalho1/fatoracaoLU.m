clear;                                                                              % limpeza das variáveis armazenadas
clc;                                                                                % limpeza do prompt de comando

% Entrada de Dados
lin = input('Digite o número da ordem da matriz quadrada: ');                       
col = lin;

% Matriz A
for lin1 = 1:lin
    for col1 = 1:col
        fprintf('Digite o valor para a posição da matriz (%d,%d): ', lin1,col1)
        A(lin1,col1) = input('');
    end
end

fprintf('\nMatriz A: \n');
disp (A);

if det(A)==0
   
    disp("Determinante é igual a zero!")

    return
end


%Reordenamento de matriz

y=1;
n=2;

p=input('Desejar fazer reordenamento da matriz (y/n)? ');

if p==1

m=3;
t=4;
tb=5;
    
z=input(['Método do Mínimo Grau, Método Forma Bloco Triangular ou Método de Triangulação de Bjork (m/t/tb)? ']);

if z==3

%Ordenamento Mínimo Grau

[m,n]=size(A);

%Encontra o número de elementos não nulos da matriz, por coluna
for i=1:n
nz(i)=nnz(A(:,i));
end

fprintf('\nNúmero de elementos não nulos da matriz, por coluna: \n')
disp(nz);

%Ordena o vetor em ordem não decrescente
[y,p]=sort(nz);

fprintf('\nNúmero total de elementos não nulos da matriz: \n')
disp(sum(y));

% matriz ordenada mínimo grau
A=A(:,p);

disp('Matriz ordenada mínimo grau: ');
disp(A);

elseif z==4

[m,n]=size(A);

%Encontra o número de elementos não nulos da matriz, por coluna
for i=1:n
nz(i)=nnz(A(:,i));
end

fprintf('\nNúmero de elementos não nulos da matriz, por coluna: \n')
disp(nz);

%Ordena o vetor em ordem não decrescente
[y,p]=sort(nz);

fprintf('\nNúmero total de elementos não nulos da matriz: \n')
disp(sum(y));

% matriz ordenada mínimo grau
A=A(:,p);

%Ordenamento bloco triangular
%Encontrar a posição na linha do elemento não nulo

Bbloco=A;
for i=1:n
    if y(i)==1
        pos1=find(Bbloco(:,i)~=0);
        aux1=Bbloco(pos1,:);
        Bbloco(pos1,:)=Bbloco(i,:);
        Bbloco(i,:)=aux1;
    elseif y(i)>1
        nz1=find(Bbloco(:,i)~=0);
        m1=length(nz1);
        for j=1:m1
            yl(j)=nnz(Bbloco(nz1(j),:));
        end
        [y2,p]=min(yl);
    end
            aux2=Bbloco(p,:);
        Bbloco(p,:)=Bbloco(i,:);
        Bbloco(i,:)=aux2;
end

A=Bbloco;
disp('Matriz ordenada bloco triangular: ');
disp(A);

elseif z==5

% Triangularização de Björck

n=length(A);
Bbloco=A;

for i=1:n-1
pos1=find(Bbloco(:,i));

for j=i+1:n
pos2=find(Bbloco(:,j));

        if pos1(1,:)>pos2(1,:)
        aux1=Bbloco(:,i);
        Bbloco(:,i)=Bbloco(:,j);
        Bbloco(:,j)=aux1;
        end

end

end

A=Bbloco;

disp('Matriz ordenada de Björck: ');
disp(A);

end

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