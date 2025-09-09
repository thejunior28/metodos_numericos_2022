clear all;                                                                              % limpeza das variáveis armazenadas
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

% Implementação do método gradiente

t = A*u-b;
p=-t;
q=-(t'*t)/((A*t)'*t);
x = u + q*p;
v=x;
z=v-u;
cr = norm(z)/norm(v);

if cr < er

fprintf('\nA solução aproximada do sistema x* = : \n');
disp(x)

fprintf('Número final de iterações : 1');

return
end

r = t + q*A*p;

k=2;

while k<=9223372036854775806

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

            fprintf('\nA solução aproximada do sistema x= \n');
            disp(x);
            fprintf('\nNúmero de iterações = %d\n', k);
            fprintf('\nO erro relativo na última iteração é igual a \n');
            disp(cr);

            telapsed = toc(tstart);
            fprintf('\nTempo computacional: %d segundos\n', telapsed);
return
end

    r=r+q*A*p;
    k=k+1;    
end

    fprintf('O método não encontrou solução após kmax iterações');


            telapsed = toc(tstart);
            fprintf('\nTempo computacional: %d segundos', telapsed);