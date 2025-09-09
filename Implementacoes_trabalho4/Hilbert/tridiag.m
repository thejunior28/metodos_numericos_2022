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

AA=A;
kmax = input ('\nDetermine o número máximo de iterações: ');

tstart = tic;
 
% Householder

[m,n]=size(A);

for l=1:m-1
x=A(1:m,l);
r=norm(x);
x(1:l,1)=0;

for k=1:n-2
y=x*0;
y(1+k,1)=r;

end

u=(x-y)/norm(x-y);
H=eye(m)-2*u*u';
A=H.*A.*H;

end

T=A;

if A==A'

    fprintf('\n A matriz A é simétrica.')

[V,D]=eig(AA);

% Decomposição QR

[~,n] = size(A);
Q = T;
R = zeros(n,n);

while k<=kmax
for j = 1:n
    Q=T;
    R(j,j) = norm(Q(:,j));
    if (R(j,j) == 0)
        telapsed = toc(tstart);
        fprintf('\nMatriz não definida positiva \n');
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

er=abs((sum(diag(R))-sum(diag(AA))))/abs(sum(diag(AA)));

%Resultado

telapsed = toc(tstart);

fprintf('\nMatriz A(%d): \n', k);
disp(A);

fprintf('\nDeterminante: %d \n',det(A));

fprintf('\nMatriz R(%d) \n', k);
disp (R);

fprintf('\nAutovalores de A: (%s)\n', strjoin(cellstr(num2str(diag(A))),', '))

fprintf('\nNúmero de iterações: %d \n', k)

fprintf('\nErro relativo final: %d \n', er);

fprintf('\nTempo computacional: %d segundos\n', telapsed);

     return
 end
 end

 T=R*Q;
 k=k+1;

end

telapsed = toc(tstart);

if k>kmax

    fprintf('\n O número de iterações não foi suficiente!')

    %Erro relativo final

er=abs(sum(diag(T))-sum(diag(AA)))/abs(sum(diag(AA)));

%Resultado


fprintf('\nMatriz A: \n');
disp(AA);

fprintf('\nDeterminante: %d \n',det(AA));

fprintf('\nMatriz Tridiagonal: \n');
disp(T);

fprintf('\nAutovalores de A: (%s)\n', strjoin(cellstr(num2str(diag(A))),', '))

fprintf('\nErro relativo final: %s\n', strjoin(cellstr(num2str(er)),', '));

fprintf('\nTempo computacional: %d segundos\n', telapsed);
end

return

end

telapsed = toc(tstart);
    fprintf('\n A matriz A não é simétrica.')

%Erro relativo final

er=abs(sum(diag(T))-sum(diag(AA)))/abs(sum(diag(AA)));

%Resultado


fprintf('\nMatriz A: \n');
disp(AA);

fprintf('\nDeterminante: %d \n',det(AA));

fprintf('\nMatriz Tridiagonal: \n');
disp(T);

fprintf('\nAutovalores de A: (%s)\n', strjoin(cellstr(num2str(diag(A))),', '))

fprintf('\nErro relativo final: %s\n', strjoin(cellstr(num2str(er)),', '));

fprintf('\nTempo computacional: %d segundos\n', telapsed);