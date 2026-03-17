package com.gl.autopecas.service;

import com.gl.autopecas.entity.Produto;
import com.gl.autopecas.repository.ProdutoRepository;
import org.springframework.stereotype.*;

@Service
public class ProdutoService {

    ProdutoRepository produtoRepository;

    public Produto saveProduto(Produto produto) {
        return produtoRepository.save(produto);
    }
}
