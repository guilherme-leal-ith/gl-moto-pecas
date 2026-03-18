package com.gl.autopecas.controller;

import com.gl.autopecas.dto.ProdutoRequestDTO;
import com.gl.autopecas.dto.ProdutoResponseDTO;
import com.gl.autopecas.service.ProdutoService;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/produtos")
public class ProdutoController {

    private final ProdutoService produtoService;

    public ProdutoController(ProdutoService produtoService) {
        this.produtoService = produtoService;
    }

    @PostMapping
    public ProdutoResponseDTO saveProduto(@RequestBody ProdutoRequestDTO produtoRequestDTO) {
        return produtoService.saveProduto(produtoRequestDTO);
    }

    @GetMapping
    public List<ProdutoResponseDTO> findAllProdutos() {
        return produtoService.findAllProduto();
    }
}
