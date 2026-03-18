package com.gl.autopecas.mapper;

import com.gl.autopecas.dto.ProdutoRequestDTO;
import com.gl.autopecas.dto.ProdutoResponseDTO;
import com.gl.autopecas.entity.Produto;

import java.math.BigDecimal;

public class ProdutoMapper {
    public static Produto toEntity(ProdutoRequestDTO requestDTO) {
        return new Produto(
                requestDTO.nome(),
                requestDTO.categoria(),
                requestDTO.garantia(),
                requestDTO.marca(),
                requestDTO.preco()
        );
    }

    public static ProdutoResponseDTO produtoResponseDTO(Produto produto) {
        return new ProdutoResponseDTO(
                produto.getId(),
                produto.getNome(),
                produto.getCategoria(),
                produto.getGarantia(),
                produto.getMarca(),
                produto.getPreco()
        );
    }
}