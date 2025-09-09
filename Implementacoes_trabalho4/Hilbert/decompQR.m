clear;                                                                              % limpeza das variáveis armazenadas
clc;                                                                                % limpeza do prompt de comando

% Entrada de Dados
lin = input('n = ');                       
col = lin;

format short

% Matriz A

p=input('Usar função hib(n) do MATLAB (y/n)? ', 's');

switch p

    case 'y'

    A=hilb(lin);

if det(A)==0
   
    disp("Determinante é igual a zero!")

    return
end

    case 'n'
    
for lin1 = 1:lin
    for col1 = 1:col
        A(lin1,col1) = 1/(lin1+col1-1);
    end
end

if det(A)==0
   
    disp("Determinante é igual a zero!")

    return
end

end

[na , ma ] = size (A);
if na ~= ma
    disp('Matriz A deve ser quadrada!')
    return
end

kmax = input ('\nDetermine o número máximo de iterações: ');
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
 [V,D]=eig(A);

 if A(n,n)==D(n,n)

%Erro relativo final

er=abs(norm(A-AA))/abs(norm(AA));

%Resultado

telapsed = toc(tstart);

fprintf('\nMatriz A(%d): \n', k);
disp(AA);

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

 A=R*Q;
 k=k+1;

end

if k>kmax

    fprintf('\n O número de iterações não foi suficiente!')

end

telapsed = toc(tstart);
fprintf('\nTempo computacional: %d segundos\n', telapsed);