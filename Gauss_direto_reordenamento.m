clear all;                                                                              % limpeza das variáveis armazenadas
clc;                                                                                % limpeza do prompt de comando

% Entrada de Dados

% Matriz A

[A,rows,cols,entries,rep,field,symm] = mmread('fs_541_1.mtx');

format short

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

% Esparsidade da matriz A

disp('Esparsidade da matriz A: ');
jp=find(A(:,:)==0);
jpp=sum(jp);
disp(jpp);

% Vetor solução b

b=rand(rows);

tstart = tic;

% Matriz aumentada
c=[A b];

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

fprintf('\nTempo computacional: %d segundos\n', telapsed);

format long e
disp('Grau de esparsidade: ');
jj=jpp/(jpp+entries);
disp(jj);