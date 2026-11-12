echo "Digite o caminho para o arquivo: "
read CAMINHO
if [[ -f "$CAMINHO" ]]; then
    echo "Arquivo Encontrado"
    if [[ -r "$CAMINHO" ]]; then
        echo "permissão dada"
        echo "Acesso liberado"
    else
        echo "Permissão Não Concedida"
    fi
else
    echo "Arquivo Não Encontrado"
fi