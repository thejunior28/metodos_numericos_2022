clear;                                                                              % limpeza das variáveis armazenadas
clc;                                                                                % limpeza do prompt de comando

% Entrada de Dados
  er = input('Digite o valor de epsilon: '); 

if er<0
    fprintf('Epsilon deve ser maior que zero!');
    return
end

om = input('Digite o Paramêtro ômega (0<w<2):');

if om<0
   fprintf('O parâmetro ômega deve ser 0<w<2')
    return
end

if om>2
   fprintf('O parâmetro ômega deve ser 0<w<2')
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

% Determinação da sequência de aproximações

n=length(A);
aux1=0;
aux2=0;
x=u;

for k=1:9223372036854775806
    
    for i=1:n
        for j=1:i-1
            aux1 = A(i,j)*x(j,1);
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

            telapsed = toc(tstart);
            fprintf('\nTempo computacional: %d segundos', telapsed);
            return
        end
u=x;
    k=k+1; 
end

    fprintf('O método não encontrou solução após kmax iterações');


            telapsed = toc(tstart);
            fprintf('\nTempo computacional: %d segundos\n', telapsed);