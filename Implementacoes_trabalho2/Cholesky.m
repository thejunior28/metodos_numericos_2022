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

% Decomposição
[nl,nc]=size(A);
B=zeros(nl,nc);
det=1;

for j=1:nl
    soma=0;
    for k=1:j-1
        soma=soma+A(j,k)^2;
    end
    t=A(j,j)-soma;
    if t>0
        A(j,j)=sqrt(t);
        B(j,j)=A(j,j);
        r=1/A(j,j);
        det=det*t;
    else
        disp('Matriz não definida positiva');
        return
    end
    for l=j+1:nl
        soma=0;
        for k=1:j-1
            soma=soma+A(l,k)*A(j,k);
        end
        A(l,j)=(A(l,j)-soma)*r;
        B(l,j)=A(l,j);
    end
end

G=B;
Gt=B';

% Substituições Sucessivas
n=length(G);                                      % ordem da matriz L
y(1,1)=b(1,1)/G(1,1);                             
    for j=2:n
        aux=0;
        for k=1:j-1
            aux=aux+G(j,k)*y(k,1);
        end
        y(j,1)=(b(j,1)-aux)/G(j,j);
    end

% Substituições Retroativas
n=length(Gt);                                      % ordem da matriz U
x(n,1)=y(n,1)/Gt(n,n);                             
    for j=n-1:-1:1
        aux=0;
        for k=j+1:n
            aux=aux+Gt(j,k)*x(k,1);
        end
        x(j,1)=(y(j,1)-aux)/Gt(j,j);
    end

% Apresentação do Resultado
disp('Matriz G:');
disp(B);
disp('Matriz Gt:');
disp(B');
disp('Solução:');
disp(x);
