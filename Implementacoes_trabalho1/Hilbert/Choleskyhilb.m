clear all;                                                                              % limpeza das variáveis armazenadas
clc;                                                                                % limpeza do prompt de comando

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

tstart = tic;

% Decomposição
[nl,nc]=size(A);
B=zeros(nl,nc);
det=1;

for j=1:nl
    soma=0;
    for k=1:j-1
        soma=soma+A(j,k)^2;
    end
    t=A(j,j)-soma;
    if t>0
        A(j,j)=sqrt(t);
        B(j,j)=A(j,j);
        r=1/A(j,j);
        det=det*t;
    else
        disp('Matriz não definida positiva');
        return
    end
    for l=j+1:nl
        soma=0;
        for k=1:j-1
            soma=soma+A(l,k)*A(j,k);
        end
        A(l,j)=(A(l,j)-soma)*r;
        B(l,j)=A(l,j);
    end
end

G=B;
Gt=B';

% Substituições Sucessivas
n=length(G);                                      % ordem da matriz L
y(1,1)=b(1,1)/G(1,1);                             
    for j=2:n
        aux=0;
        for k=1:j-1
            aux=aux+G(j,k)*y(k,1);
        end
        y(j,1)=(b(j,1)-aux)/G(j,j);
    end

% Substituições Retroativas
n=length(Gt);                                      % ordem da matriz U
x(n,1)=y(n,1)/Gt(n,n);                             
    for j=n-1:-1:1
        aux=0;
        for k=j+1:n
            aux=aux+Gt(j,k)*x(k,1);
        end
        x(j,1)=(y(j,1)-aux)/Gt(j,j);
    end

telapsed = toc(tstart);

% Apresentação do Resultado
disp('Matriz G:');
disp(B);
disp('Matriz Gt:');
disp(B');
disp('Solução:');
disp(x);


fprintf('\nTempo computacional: %d segundos', telapsed);

