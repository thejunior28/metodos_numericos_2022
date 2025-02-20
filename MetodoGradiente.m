clear;                                                                              % limpeza das variáveis armazenadas
clc;                                                                                % limpeza do prompt de comando

format short

% Entrada de Dados
er = input('Digite o valor de epsilon: '); 

if er<=0
    fprintf('Epsilon deve ser maior que zero!');
    return
end

% Matriz A

[A,rows,cols,entries,rep,field,symm] = mmread('gre__512.mtx');


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

end

end

% Esparsidade da matriz A

disp('Esparsidade da matriz A: ');
jp=find(A(:,:)==0);
jpp=sum(jp);
disp(jpp);

% Vetor solução b

b=rand(rows);

% x0

y=1;
n=2;

p=input('x0 é um vetor nulo (y/n)? ');

if p==1

u=zeros(rows);

else
u=rand(rows);

end

tstart = tic;

% Implementação do método gradiente

k=0;
x=u;

while k<=10^3
r = b - A*x;
    u=x;
alp = (r'*r)/(r'*A*r);
x = x + alp*r;
v=x;
z=v-u;
cr = norm(z)/norm(v);
k=k+1;

if cr < er
    fprintf('\nA solução aproximada do sistema x* = : \n');
disp(x)

fprintf('\nNúmero final de iterações : \n');
disp(k)


telapsed = toc(tstart);

fprintf('\nTempo computacional: %d segundos', telapsed);

format long e
disp('Grau de esparsidade: ');
jj=jpp/(jpp+entries);
disp(jj);

return
end
end

    fprintf('O método não encontrou solução após kmax iterações');

telapsed = toc(tstart);

fprintf('\nTempo computacional: %d segundos', telapsed);

format long e
disp('Grau de esparsidade: ');
jj=jpp/(jpp+entries);
disp(jj);