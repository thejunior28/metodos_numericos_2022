% =========================================================================
% SCRIPT PARA COMPRESSÃO DE IMAGENS COLORIDAS (RGB) USANDO SVD
% =========================================================================
% Este script carrega uma imagem colorida, a separa nos canais R, G e B,
% aplica a compressão SVD em cada canal de forma independente e, ao final,
% recombina os canais para exibir a imagem colorida comprimida.
% =========================================================================

%% 1. INICIALIZAÇÃO E LIMPEZA DO AMBIENTE
clear;      % Limpa todas as variáveis da memória
clc;        % Limpa a janela de comando
close all;  % Fecha todas as figuras abertas

%% 2. CARREGAMENTO E PRÉ-PROCESSAMENTO DA IMAGEM
% Carrega a imagem. Substitua 'imagem_colorida.jpg' pelo nome do seu arquivo.
nomeArquivo = 'images.jpg'; % <<-- COLOQUE O NOME DA SUA IMAGEM AQUI
try
    imagemOriginal = imread(nomeArquivo);
catch
    error('Erro ao carregar a imagem. Verifique se o arquivo "%s" está no mesmo diretório do script.', nomeArquivo);
end

% Verifica se a imagem é realmente colorida (possui 3 canais).
if size(imagemOriginal, 3) ~= 3
    error('Este script foi projetado para imagens coloridas (RGB). A imagem fornecida não possui 3 canais.');
end

% Converte a matriz da imagem para o tipo 'double' com valores entre 0 e 1.
imagemDouble = im2double(imagemOriginal);

%% 3. REDIMENSIONAMENTO DA IMAGEM (ENTRADA DO USUÁRIO)
% Solicita ao usuário as novas dimensões da imagem.
novaAltura = input('Digite a nova altura da imagem (ex: 500): ');
novaLargura = input('Digite a nova largura da imagem (ex: 750): ');

% Validação simples para garantir que a entrada é numérica e positiva
if isempty(novaAltura) || ~isnumeric(novaAltura) || novaAltura <= 0
    novaAltura = size(imagemDouble, 1); % Usa altura original se a entrada for inválida
    fprintf('Altura inválida. Usando altura original de %d pixels.\n', novaAltura);
end
if isempty(novaLargura) || ~isnumeric(novaLargura) || novaLargura <= 0
    novaLargura = size(imagemDouble, 2); % Usa largura original se a entrada for inválida
    fprintf('Largura inválida. Usando largura original de %d pixels.\n', novaLargura);
end

% Redimensiona a imagem e separa nos canais R, G, B
imagemRedimensionada = imresize(imagemDouble, [novaAltura, novaLargura]);
R = imagemRedimensionada(:,:,1);
G = imagemRedimensionada(:,:,2);
B = imagemRedimensionada(:,:,3);

%% 4. APLICAÇÃO DA DECOMPOSIÇÃO SVD EM CADA CANAL
fprintf('Calculando SVD para os 3 canais de cor...\n');
[UR, SR, VR] = svd(R);
[UG, SG, VG] = svd(G);
[UB, SB, VB] = svd(B);

% Extrai os valores singulares de cada canal para plotagem
sv_R = diag(SR);
sv_G = diag(SG);
sv_B = diag(SB);

%% 5. ESCOLHA DA QUALIDADE DA COMPRESSÃO (ENTRADA DO USUÁRIO)
rankMaximo = min(novaAltura, novaLargura);
fprintf('Escolha a qualidade da imagem (k), um valor entre 1 e %d.\n', rankMaximo);
k = 0;
while k < 1 || k > rankMaximo || isnan(k) || floor(k) ~= k
    k = input(sprintf('Digite o valor de k (1-%d): ', rankMaximo));
    if isempty(k) || k < 1 || k > rankMaximo || isnan(k) || floor(k) ~= k
        fprintf('Entrada inválida. Por favor, insira um número inteiro entre 1 e %d.\n', rankMaximo);
        k = 0;
    end
end

%% 6. RECONSTRUÇÃO DOS CANAIS E DA IMAGEM FINAL
% Reconstrói cada canal usando apenas os 'k' primeiros valores singulares
Rk = UR(:, 1:k) * SR(1:k, 1:k) * VR(:, 1:k)';
Gk = UG(:, 1:k) * SG(1:k, 1:k) * VG(:, 1:k)';
Bk = UB(:, 1:k) * SB(1:k, 1:k) * VB(:, 1:k)';

% Recombina os canais para formar a imagem colorida comprimida
imagemComprimida = cat(3, Rk, Gk, Bk);

% Garante que os valores de pixel permaneçam no intervalo válido [0, 1]
imagemComprimida = max(0, min(1, imagemComprimida));

%% 7. CÁLCULO DA TAXA DE COMPRESSÃO
% Para imagens coloridas, o tamanho dos dados é 3 vezes maior
dadosOriginais = novaAltura * novaLargura * 3;
dadosComprimidos = 3 * (novaAltura * k + k + novaLargura * k);
taxaCompressao = (dadosComprimidos / dadosOriginais) * 100;

%% 8. VISUALIZAÇÃO DOS RESULTADOS
% Primeira figura: Comparação das imagens
figure('Name', 'Comparação SVD em Imagem Colorida', 'NumberTitle', 'off');
subplot(1, 2, 1);
imshow(imagemRedimensionada);
axis image;
title(['Original (' num2str(novaAltura) 'x' num2str(novaLargura) ')']);

subplot(1, 2, 2);
imshow(imagemComprimida);
axis image;
title(['Comprimida com k = ' num2str(k)]);

sgtitle(sprintf('Taxa de Compressão: %.2f%% dos dados originais', taxaCompressao));

% Segunda figura: Gráfico dos valores singulares para cada canal
figure('Name', 'Valores Singulares por Canal de Cor', 'NumberTitle', 'off');
semilogy(sv_R, 'r-');
hold on;
semilogy(sv_G, 'g-');
semilogy(sv_B, 'b-');
semilogy(k, sv_R(k), 'r*', 'MarkerSize', 10, 'LineWidth', 1.5'); % Marca k no canal R
semilogy(k, sv_G(k), 'g*', 'MarkerSize', 10, 'LineWidth', 1.5'); % Marca k no canal G
semilogy(k, sv_B(k), 'b*', 'MarkerSize', 10, 'LineWidth', 1.5'); % Marca k no canal B
grid on;
title('Decaimento dos Valores Singulares por Canal');
xlabel('Índice do Valor Singular');
ylabel('Valor Singular (em escala log)');
legend('Canal Vermelho (R)', 'Canal Verde (G)', 'Canal Azul (B)', sprintf('k = %d', k));
hold off;