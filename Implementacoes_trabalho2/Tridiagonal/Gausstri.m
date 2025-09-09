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