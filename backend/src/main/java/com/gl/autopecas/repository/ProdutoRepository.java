package com.gl.autopecas.repository;

import com.gl.autopecas.entity.Produto;
import org.springframework.data.repository.CrudRepository;
//manter interface limpa, apenas colocar pra binding de mets q  ainda n existem
public interface ProdutoRepository extends CrudRepository<Produto, Integer> {

}
