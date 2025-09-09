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

disp('Determinante: ');
disp(det(A));

%Reordenamento de matriz

y=1;
n=2;

p=input('Desejar fazer reordenamento da matriz (y/n)? ');

if p==1

m=3;
t=4;
tb=5;
    
z=input('Método do Mínimo Grau, Método Forma Bloco Triangular ou Método de Triangulação de Bjork (m/t/tb)? ');

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

disp('Solução:');
disp(x);