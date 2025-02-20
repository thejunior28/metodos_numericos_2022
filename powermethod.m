clear;                                                                              % limpeza das variáveis armazenadas
clc;                                                                                % limpeza do prompt de comando

% Matriz A

[A,rows,cols,entries,rep,field,symm] = mmread('bcsstk02.mtx');


if det(A)==0
   
    disp("Determinante é igual a zero!")

    return
end

[na , ma ] = size (A);
if na ~= ma
    disp('Matriz A deve ser quadrada!')
    return
end

% Vetor inicial v
r = input ('Vetor inicial com elementos aleatórios? (y/n): ','s');
switch r 
    case 'y'

v = rand(rows,1);

    [nx, mx] = size(v);
    if v(:,1)==0
        fprintf('\nTodos os elementos são iguais a zeros!\n')
        return
    end

    case 'n'

    u = zeros(na-1,1);
    v = [1;u];

end

% Determinação do erro

er = input ('Erro limite do resultado final: ');

% Método de Potências

kmax = input ('Determine o número máximo de iterações: ');
k=1;
m=0;
x=v;
z=1;

tstart = tic;

while k<=kmax
 l=m;
 w=x;
 x=A*x;
 x=x/norm(x);
 m=max(x);
 z=m-l;
 if abs(z)<=er

     %Erro relativo final

er=norm(x-w)/norm(x);

%Resultado

telapsed = toc(tstart);

fprintf('\nMatriz A: \n');
disp(A);

fprintf('\nDeterminante: %d \n',det(A));

fprintf('\nVetor inicial: \n');
disp(v);

fprintf('\nErro relativo final: %d \n', er);

fprintf('\nO autovetor dominante é %.5f depois de %d iterações e o autovetor correspondente é: (%s)\n', m, k,strjoin(cellstr(num2str(x(:))),', '))

fprintf('\nTempo computacional: %d segundos\n', telapsed);

     return
 end
 k=k+1;
end

if k>kmax

    fprintf('\n O número de iterações não foi suficiente!')

end

telapsed = toc(tstart);
fprintf('\nTempo computacional: %d segundos\n', telapsed);