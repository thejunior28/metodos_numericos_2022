clear;                                                                              % limpeza das variáveis armazenadas
clc;                                                                                % limpeza do prompt de comando

% Entrada de Dados
  er = input('Digite o valor de epsilon: '); 

if er<0
    fprintf('Epsilon deve ser maior que zero!');
    return
end

kmax = input('Digite o número máximo de iterações: kmax = ');  
om = input('Digite o Paramêtro ômega (0<w<2):');

if om<0
   fprintf('O parâmetro ômega deve ser 0<w<2')
    return
end

if om>2
   fprintf('O parâmetro ômega deve ser 0<w<2')
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

% Determinação da sequência de aproximações

n=length(A);
aux1=0;
aux2=0;
x=u;

for k=1:kmax
    
    for i=1:n
        x1=x;
        for j=1:i-1
            aux1 = A(i,j)*x1(j,1);
            for j=i+1:n
                aux2 = A(i,j)*u(j,1);
            end
        end
        x(i,1) = (1-om)*u(i,1) + (om/A(i,i))*(b(i,1) - aux1 - aux2);
    end

    z=x-u;
    cr = norm(z)/norm(x);

        if cr<er

            fprintf('\nA solução aproximada do sistema x = \n');
            disp(x);

            fprintf('\nO erro relativo na última iteração é igual a \n');
            disp(cr);

            fprintf('\nNúmero de iterações: \n');
            disp(k);

            return
        end

    u=x;
    k=k+1; 
end

if cr>=er
    fprintf('O método não encontrou solução após kmax iterações');
end