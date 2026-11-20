#!/bin/bash

# Read the log file path from the first argument.
arquivo="$1"

# Require one readable .log file.
if [[ -z "$arquivo" || "$arquivo" != *.log ]]; then
    echo "Erro: informe um arquivo terminado em .log." >&2
    echo "Uso: $0 check.log" >&2
    exit 1
fi

# Check that the path points to a readable regular file.
if [[ ! -f "$arquivo" || ! -r "$arquivo" ]]; then
    echo "Erro: '$arquivo' não existe ou não pode ser lido." >&2
    exit 1
fi

# Stop if the log file is empty.
if [[ ! -s "$arquivo" ]]; then
    echo "Erro: o arquivo '$arquivo' está vazio. Nenhum dado foi passado." >&2
    exit 1
fi

# Continue when the log file contains data.
echo "OK: '$arquivo' contém dados. Avançando..."

# Add the next processing step here.