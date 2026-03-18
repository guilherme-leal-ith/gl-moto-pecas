package com.gl.autopecas.dto;

import java.math.BigDecimal;

public record ProdutoResponseDTO (
    Integer id,
    String nome,
    String categoria,
    String garantia,
    String marca,
    BigDecimal preco
) {}