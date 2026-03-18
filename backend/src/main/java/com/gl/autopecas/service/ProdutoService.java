package com.gl.autopecas.service;

import com.gl.autopecas.dto.ProdutoRequestDTO;
import com.gl.autopecas.dto.ProdutoResponseDTO;
import com.gl.autopecas.entity.Produto;
import com.gl.autopecas.mapper.ProdutoMapper;
import com.gl.autopecas.repository.ProdutoRepository;
import org.springframework.stereotype.*;

import java.util.List;

@Service
public class ProdutoService {

    private final ProdutoRepository produtoRepository;

    public ProdutoService(ProdutoRepository produtoRepository) {
        this.produtoRepository = produtoRepository;
    }

    public ProdutoResponseDTO saveProduto(ProdutoRequestDTO produtoRequestDTO) {
        Produto produto = ProdutoMapper.toEntity(produtoRequestDTO);
        Produto produtoSaved = produtoRepository.save(produto);

        return ProdutoMapper.produtoResponseDTO(produtoSaved);
    }

    public List<ProdutoResponseDTO> findAllProduto() {
        List<Produto> lista = produtoRepository.findAll();

        List<ProdutoResponseDTO> listaMapeadaParaDTO =
                lista.stream()
                        .map(ProdutoMapper::produtoResponseDTO)
                        .toList();

        return listaMapeadaParaDTO;
    }
}
