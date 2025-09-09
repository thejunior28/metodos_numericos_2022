clear;                                                                              % limpeza das variáveis armazenadas
clc;                                                                                % limpeza do prompt de comando

format short

% Matriz A

[A,rows,cols,entries,rep,field,symm] = mmread('bcsstk02.mtx');


if det(A)==0
   
    disp("Determinante é igual a zero!")

    return
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

 telapsed = toc(tstart);

fprintf('\nMatriz A \n');
disp (A);

fprintf('\nMatriz Q \n');
disp (Q);

fprintf('\nMatriz R \n');
disp (R);

fprintf('\nTempo computacional: %d segundos\n', telapsed);