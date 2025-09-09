clear;                                                                              % limpeza das variáveis armazenadas
clc;                                                                                % limpeza do prompt de comando

% Entrada de Dados
er = input('Digite o valor de epsilon: '); 

if er<0
    fprintf('Epsilon deve ser maior que zero!');
    return
end

kmax = input('Digite o número máximo de iterações: kmax = ');  
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
    x(y,1) = input('');
end

fprintf('\nx0: \n');
disp (x);

% Implementação do método gradiente

k=0;

while k<=kmax
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

return
end
end

if k>kmax
    fprintf('O método não encontrou solução após kmax iterações');
end