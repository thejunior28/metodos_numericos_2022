clear;                                                                              % limpeza das variáveis armazenadas
clc;                                                                                % limpeza do prompt de comando

% Entrada de Dados
  er = input('Digite o valor de epsilon: '); 

if er<0
    fprintf('Epsilon deve ser maior que zero!');
    return
end

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


% Vetor solução b
for b1 = 1:lin
    fprintf('Digite o valor para a posição do vetor (%d,%d): ', b1,1)
    b(b1,1) = input('');
end

fprintf('\nVetor solução b: \n');
disp (b);

% x0

for y = 1:lin
    fprintf('Digite o valor para x0 (%d,%d): ',y,1)
    u(y,1) = input('');
end

fprintf('\nx0: \n');
disp (u);

% Teste de convergência

n=length(A);
a=0;
beta=1;

    for i=1:n
    for j=1:i-1
        a(i,1)=beta(j,1)*abs(A(i,j));
    end
    for j=i+1:n
    beta(i,1)=(a(i,1)+abs(A(i,j)))/abs(A(i,i));
    end
    end

betamax = max(beta);
    fprintf('\nbeta = \n');
    disp(betamax);

if betamax < 1
fprintf('O método de Gauss-Seidel gera uma sequência {x(k)} que converge para a solução do sistema dado, independente da escolha da aproximação inicial x(0).')
else
    fprintf('A convergência do método não depende da solução inicial. Não podemos concluir que a sequência diverge.');
    return
end

% Matriz de iteração C e vetor constante g

for i=1:n
    if A(i,i)~=0
        g(i,1)=b(i,1)/A(i,i);
        for j=1:n
            if i~=j
                C(i,j)=-A(i,j)/A(i,i);
            else
                C(i,j)=0;
            end
        end
    end
end

fprintf('\nC = \n');
    disp(C);
fprintf('\ng = \n');
    disp(g);

% Determinação da sequência de aproximações

aux1=0;
aux2=0;
x=u;

for k=1:9223372036854775806
    
    for i=1:n
        x1=x;
        for j=1:i-1
            aux1 = C(i,j)*x1(j,1);
            for j=i+1:n
                aux2 = C(i,j)*u(j,1);
            end
        end
        x(i,1) = aux1 + aux2 + g(i,1);
    end

    fprintf('\nA solução aproximada do sistema x(%d)= \n', k);
    disp(x);
    v=x;
    z=v-u;
    cr = norm(z)/norm(v);

        if cr<er
            fprintf('\nO erro relativo na última iteração é igual a \n');
            disp(cr);
            return
        end

    fprintf('\nErro relativo da iteração %d \n', k);
    disp(cr);

    u=x;
    k=k+1; 
end