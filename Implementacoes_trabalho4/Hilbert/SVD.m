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

if A==A'
    fprintf('A matriz A é singular!\n')
else
    fprintf('A matriz A não é singular!\n')
end

tstart = tic;

a=A;

[m,n] = size(A);

% SVD

J=a'*a;

[Q,D]=eig(J);
D = D.^0.5;

for i=1:n
Q(:,i)=Q(:,i)/norm(Q(:,i));
P(:,i)=A*Q(:,i)/D(i,i);
end

 A=P*D;
 A=A*Q';

 %Erro

 er= abs(norm(A-a))/abs(norm(a));

telapsed = toc(tstart);

fprintf('\nMatriz A inicial: \n');
disp(a);

fprintf('\nDeterminante: %d \n',det(a));

fprintf('\nMatriz A=P*D*Qt: \n');
disp(A);

fprintf('\nDeterminante: %d \n',det(a));

fprintf('\nMatriz P \n');
disp (P);

fprintf('\nMatriz Diagonal \n');
disp (D);

fprintf('\nMatriz Q \n');
disp (Q);

fprintf('\nErro relativo final: %d \n', er);

fprintf('\nAutovalores de A: (%s)\n', strjoin(cellstr(num2str(diag(D))),', '));

fprintf('\nTempo computacional: %d segundos\n', telapsed);