clear all;                                                                              % limpeza das variáveis armazenadas
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

disp('Determinante: ');
disp(det(A));

% Vetor solução b
for b1 = 1:lin
    fprintf('Digite o valor para a posição do vetor (%d,%d): ', b1,1)
    b(b1,1) = input('');
end

fprintf('\nVetor solução b: \n');
disp (b);

%% Decomposição
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

%% Substituições Sucessivas
n=length(G);                                      % ordem da matriz L
y(1,1)=b(1,1)/G(1,1);                             
    for j=2:n
        aux=0;
        for k=1:j-1
            aux=aux+G(j,k)*y(k,1);
        end
        y(j,1)=(b(j,1)-aux)/G(j,j);
    end

%% Substituições Retroativas
n=length(Gt);                                      % ordem da matriz U
x(n,1)=y(n,1)/Gt(n,n);                             
    for j=n-1:-1:1
        aux=0;
        for k=j+1:n
            aux=aux+Gt(j,k)*x(k,1);
        end
        x(j,1)=(y(j,1)-aux)/Gt(j,j);
    end

%% Apresentação do Resultado
disp('Matriz G:');
disp(B);
disp('Matriz Gt:');
disp(B');
disp('Solução:');
disp(x);
