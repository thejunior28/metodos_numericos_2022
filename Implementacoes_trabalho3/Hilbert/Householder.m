clear;                                                                              % limpeza das variáveis armazenadas
clc;                                                                                % limpeza do prompt de comando

% Entrada de Dados
lin = input('n = ');                       
col = lin;

format short

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

% Função y = f(x)

for lin1 = 1:lin
    aux=0;
for col1 = 1:lin
    aux = aux+A(lin1,col1);
end
y(lin1,1) = aux/3;
end

tstart = tic;

% Householder

   [m,n]=size(A);
   Q=eye(m);
for k=1:n
    z = -sign(A(k,k))*norm(A(k:m,k));
    v = [zeros(k-1,1); A(k,k)-z; A(k+1:m,k)];
    f = v'*v;
    if f == 0, continue; end
for j = k:n
     c = v'*A(:,j); 
     A(:,j) = A(:,j)-(2*c/f)*v; 
end
end

R=A;

for j=k:m
     c = v'*Q(:,j); 
     Q(:,j) = Q(:,j)-(2*c/f)*v;
end

Q=Q;

 telapsed = toc(tstart);

fprintf('\ny = \n');
disp (y);

fprintf('\nMatriz Q \n');
disp (Q);

fprintf('\nMatriz R \n');
disp (R);

fprintf('\nTempo computacional: %d segundos\n', telapsed);