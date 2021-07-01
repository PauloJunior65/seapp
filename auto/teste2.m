parfor i = 1:1
end
clear;
clc;
configuracao.save = 'Manaus-Barcelos';
mload;
op_exportar_barco(index,[],configuracao,resultado,dado,network,otimizacao);

configuracao.save = 'Manaus-Itacoatiara';
mload;
op_exportar_barco(index,[],configuracao,resultado,dado,network,otimizacao);

configuracao.save = 'Manaus-Parintins';
mload;
op_exportar_barco(index,[],configuracao,resultado,dado,network,otimizacao);
