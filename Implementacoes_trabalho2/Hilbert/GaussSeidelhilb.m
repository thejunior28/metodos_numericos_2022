clear;                                                                              % limpeza das variáveis armazenadas
clc;                                                                                % limpeza do prompt de comando

% Entrada de Dados
  er = input('Digite o valor de epsilon: '); 

if er<0
    fprintf('Epsilon deve ser maior que zero!');
    return
end

lin = input('n = ');                       
col = lin;

% Matriz A
y=1;
n=2;

p=input('Usar função hib(n) do MATLAB (y/n)? ');

if p==1

    A=hilb(lin);

    fprintf('\nMatriz A: \n');
disp (A);

if det(A)==0
   
    disp("Determinante é igual a zero!")

    return
end

disp('Determinante: ');
disp(det(A));

else
    
for lin1 = 1:lin
    for col1 = 1:col
        A(lin1,col1) = 1/(lin1+col1-1);
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

end

% Vetor solução b
for lin1 = 1:lin
    aux=0;
for col1 = 1:lin
    aux = aux+A(lin1,col1);
end
b(lin1,1) = aux/3;
end

fprintf('\nVetor solução b: \n');
disp (b);

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
fprintf('\nO método de Gauss-Seidel gera uma sequência {x(k)} que converge para a solução do sistema dado, independente da escolha da aproximação inicial x(0).\n')
else
    fprintf('\nA convergência do método não depende da solução inicial. Não podemos concluir que a sequência diverge.\n');
    return
end

% x0

r=length(A);
y=1;
n=2;

p=input('x0 é um vetor nulo (y/n)? ');

if p==1

u=zeros(r,1);

else
u=rand(r,1);

end

tstart = tic;

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

    v=x;
    z=v-u;
    cr = norm(z)/norm(v);

        if cr<er
            fprintf('\nA solução aproximada do sistema x= \n');
            disp(x);
            fprintf('\nNúmero de iterações = %d\n', k);
            fprintf('\nO erro relativo na última iteração é igual a \n');
            disp(cr);

            telapsed = toc(tstart);
            fprintf('\nTempo computacional: %d segundos', telapsed);

            return
        end

    u=x;
    k=k+1; 
end

if cr>=er
    fprintf('O método não encontrou solução após kmax iterações');


            telapsed = toc(tstart);
            fprintf('\nTempo computacional: %d segundos', telapsed);

end