clear;                                                                              % limpeza das variáveis armazenadas
clc;                                                                                % limpeza do prompt de comando

% Matriz A

[A,rows,cols,entries,rep,field,symm] = mmread('blckhole.mtx');


if det(A)==0
   
    disp("Determinante é igual a zero!")

    return
end

[na , ma ] = size (A);
if na ~= ma
    disp('Matriz A deve ser quadrada!')
    return
end

kmax = input ('Determine o número máximo de iterações: ');
k=1;
AA=A;

tstart = tic;

while k<=kmax
 
% Decomposição QR

[~,n] = size(A);
Q = A;
R = zeros(n,n);

for j = 1:n
    R(j,j) = norm(Q(:,j));
    if (R(j,j) == 0)
        telapsed = toc(tstart);
        disp('\nMatriz não definida positiva \n');
        fprintf('\nTempo computacional: %d segundos\n', telapsed);
        return
    end
    Q(:,j) = Q(:,j)/R(j,j);
    R(j,j+1:n) = Q(:,j)'*Q(:,j+1:n);
    Q(:,j+1:n) = Q(:,j+1:n) - Q(:,j)*R(j,j+1:n);
end
 D=eig(A);

 for i=1:n
 if A(i,i)==D(i,1)

%Erro relativo final

er=abs((sum(diag(A))-sum(diag(AA))))/abs(sum(diag(A)));

%Resultado

telapsed = toc(tstart);

fprintf('\nMatriz A(%d): \n', k);
disp(A);

fprintf('\nDeterminante: %d \n',det(A));

fprintf('\nMatriz Q(%d) \n', k);
disp (Q);

fprintf('\nMatriz R(%d) \n', k);
disp (R);

fprintf('\nAutovalores de A: (%s)\n', strjoin(cellstr(num2str(diag(A))),', '))

fprintf('\nNúmero de iterações: %d \n', k)

fprintf('\nErro relativo final: %d \n', er);

fprintf('\nTempo computacional: %d segundos\n', telapsed);

     return
 end
 end

 A=R*Q;
 k=k+1;

end

if k>kmax

    fprintf('\n O número de iterações não foi suficiente!')

end

telapsed = toc(tstart);
fprintf('\nTempo computacional: %d segundos\n', telapsed);