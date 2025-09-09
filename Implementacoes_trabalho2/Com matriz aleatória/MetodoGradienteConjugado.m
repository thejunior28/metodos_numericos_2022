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

[A,rows,cols,entries,rep,field,symm] = mmread('bcsstk22.mtx');


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

% Pré-condicionamento
y=1;
n=2;

p=input('Desejar aplicar o pré-condicionamento (y/n)? ');

if p==1

A=ichol(A);

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

x=u;
% Implementação do método gradiente

t = A*x-b;
p=-t;
q=-(t'*t)/((A*t)'*t);
u=x;
x = x + q*p;
v=x;
z=v-u;
cr = norm(z)/norm(v);

if cr < er


fprintf('Número final de iterações : 1');

 fprintf('\nO erro relativo na última iteração é igual a \n');
            disp(cr);

return
end

r = t + q*A*p;

k=2;

while k<=10^3

alp = (r'*r)/(t'*t);
t = t + q*A*p;
p = -r+alp*p;
q=-(r'*r)/((A*p)'*p);
u=x;
x=x+q*p;
v=x;
z=v-u;
cr = norm(z)/norm(v);

if cr < er

fprintf('\nNúmero final de iterações : \n');
disp(k)

 fprintf('\nO erro relativo na última iteração é igual a \n');
            disp(cr);

telapsed = toc(tstart);

fprintf('\nTempo computacional: %d segundos\n', telapsed);

format long e
disp('Grau de esparsidade: ');
jj=jpp/(jpp+entries);
disp(jj);
return
end

    r=r+q*A*p;
    k=k+1;    
end

    fprintf('O método não encontrou solução após kmax iterações');

telapsed = toc(tstart);

fprintf('\nTempo computacional: %d segundos', telapsed);

format long e
disp('Grau de esparsidade: ');
jj=jpp/(jpp+entries);
disp(jj);