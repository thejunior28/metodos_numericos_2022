% =========================================================================
% SCRIPT PARA COMPRESSÃO DE IMAGENS USANDO SVD (Singular Value Decomposition)
% =========================================================================
% Este script carrega uma imagem, permite ao usuário redimensioná-la e,
% em seguida, aplica a compressão SVD com um nível de qualidade (k) 
% escolhido pelo usuário. Ao final, exibe uma comparação visual e a taxa 
% de compressão.
% =========================================================================

%% 1. INICIALIZAÇÃO E LIMPEZA DO AMBIENTE
clear;      % Limpa todas as variáveis da memória
clc;        % Limpa a janela de comando
close;  % Fecha todas as figuras abertas

%% 2. CARREGAMENTO E PRÉ-PROCESSAMENTO DA IMAGEM
% Carrega a imagem. Substitua 'images.jpg' pelo nome do seu arquivo.
nomeArquivo = 'images.jpg';
try
    imagemRGB = imread(nomeArquivo);
catch
    error('Erro ao carregar a imagem. Verifique se o arquivo "%s" está no mesmo diretório do script.', nomeArquivo);
end

% Converte a imagem para escala de cinza, se ela for colorida.
% A SVD é aplicada em uma matriz 2D, por isso a necessidade da conversão.
if size(imagemRGB, 3) == 3
    imagemCinza = rgb2gray(imagemRGB);
else
    imagemCinza = imagemRGB; % A imagem já está em escala de cinza
end

% Converte a matriz da imagem para o tipo 'double' com valores entre 0 e 1.
% Isso é importante para a precisão dos cálculos matemáticos da SVD.
imagemDouble = im2double(imagemCinza);

%% 3. REDIMENSIONAMENTO DA IMAGEM (ENTRADA DO USUÁRIO)
% Solicita ao usuário as novas dimensões da imagem.
% Inclui validação para garantir que os valores sejam números positivos.
novaAltura = 0;
while novaAltura <= 0 || isnan(novaAltura)
    novaAltura = input('Digite a nova altura da imagem (ex: 300): ');
end

novaLargura = 0;
while novaLargura <= 0 || isnan(novaLargura)
    novaLargura = input('Digite a nova largura da imagem (ex: 400): ');
end

% Redimensiona a imagem para as dimensões fornecidas.
A = imresize(imagemDouble, [novaAltura, novaLargura]);

%% 4. APLICAÇÃO DA DECOMPOSIÇÃO SVD
% Realiza a Decomposição em Valores Singulares (SVD) na matriz da imagem.
% A = U * S * V'
% U e V são matrizes ortogonais e S é uma matriz diagonal com os valores singulares.
[U, S, V] = svd(A);

% Extrai os valores singulares da matriz diagonal S para um vetor.
valoresSingulares = diag(S);

%% 5. ESCOLHA DA QUALIDADE DA COMPRESSÃO (ENTRADA DO USUÁRIO)
% Determina o número máximo de valores singulares que podem ser usados.
rankMaximo = min(novaAltura, novaLargura); 

% Solicita ao usuário o valor de 'k' (número de valores singulares a usar).
% 'k' controla a qualidade e o nível de compressão da imagem.
fprintf('Escolha a qualidade da imagem (k), um valor entre 1 e %d.\n', rankMaximo);
k = 0;
while k < 1 || k > rankMaximo || isnan(k) || floor(k) ~= k
    k = input(sprintf('Digite o valor de k (1-%d): ', rankMaximo));
    if isempty(k) || k < 1 || k > rankMaximo || isnan(k) || floor(k) ~= k
        fprintf('Entrada inválida. Por favor, insira um número inteiro entre 1 e %d.\n', rankMaximo);
        k = 0;
    end
end

% Reconstrói a imagem (Ak) usando apenas os 'k' primeiros valores singulares.
% Esta é a matriz da imagem comprimida.
Ak = U(:, 1:k) * S(1:k, 1:k) * V(:, 1:k)';

%% 6. CÁLCULO DA TAXA DE COMPRESSÃO
% A compressão ocorre porque, em vez de armazenar m*n pixels, armazenamos
% apenas as matrizes U, S e V truncadas.
dadosOriginais = novaAltura * novaLargura;
dadosComprimidos = novaAltura * k + k + novaLargura * k;
taxaCompressao = (dadosComprimidos / dadosOriginais) * 100;

%% 7. VISUALIZAÇÃO DOS RESULTADOS
% Cria a primeira figura para comparar as imagens.
figure('Name', 'Comparação SVD', 'NumberTitle', 'off');

% Mostra a imagem original (redimensionada)
subplot(1, 2, 1);
imshow(A);
axis image;
title(['Original (' num2str(novaAltura) 'x' num2str(novaLargura) ')']);

% Mostra a imagem comprimida
subplot(1, 2, 2);
imshow(Ak);
axis image;
title(['Comprimida com k = ' num2str(k)]);

% Adiciona um título geral à figura com a informação de compressão.
sgtitle(sprintf('Taxa de Compressão: %.2f%% dos dados originais', taxaCompressao));

% Cria a segunda figura para o gráfico de valores singulares.
figure('Name', 'Valores Singulares', 'NumberTitle', 'off');
% Plota os valores em escala logarítmica para melhor visualização.
semilogy(valoresSingulares, 'b-');
hold on;
% Marca o ponto correspondente ao 'k' escolhido.
semilogy(k, valoresSingulares(k), 'r*', 'MarkerSize', 10, 'LineWidth', 1.5);
hold off;
grid on;
title('Decaimento dos Valores Singulares');
xlabel('Índice do Valor Singular');
ylabel('Valor Singular (em escala log)');
legend('Valores Singulares', sprintf('k = %d', k));