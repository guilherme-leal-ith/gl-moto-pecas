package com.gl.autopecas.entity;

import jakarta.persistence.*;

import java.math.BigDecimal;

@Entity
@Table(name = "TB_PRODUTO")
public class Produto {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id;

    @Column(length = 100, nullable = false)
    private String nome;

    @Column(length = 50, nullable = false)
    private String categoria;

    @Column(length = 50)
    private String garantia;

    @Column(length = 50)
    private String marca;

    @Column(precision = 10, scale = 2, nullable = false)
    private BigDecimal preco;

    //precisa desse sem args pq o JPA exige, ja q ao fzr uma busca, o jpa instancia a entidade, mas sem saber
    //quais argumentos passar, por isso do const vazio, pra criar o objeto em branco. dps ele vai botando os valores
    // de valor em valor via setters
    public Produto(){};

    //esse é pro dev, ajuda a criar entidades no cod sem precisar chamar setter a getter
    //sem int id pq é auto increment
    public Produto(String nome, String categoria, String garantia, String marca, BigDecimal preco) {
        this.nome = nome;
        this.categoria = categoria;
        this.garantia = garantia;
        this.marca = marca;
        this.preco = preco;
    }

    //getters: o jpa ou qq q seja q precisa acessar os valores usa os getters
    //setters: usados pelo jpa pra preencher os campos do objeto vazio
    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getNome() {
        return nome;
    }

    public void setNome(String nome) {
        this.nome = nome;
    }

    public String getCategoria() {
        return categoria;
    }

    public void setCategoria(String categoria) {
        this.categoria = categoria;
    }

    public String getGarantia() {
        return garantia;
    }

    public void setGarantia(String garantia) {
        this.garantia = garantia;
    }

    public String getMarca() {
        return marca;
    }

    public void setMarca(String marca) {
        this.marca = marca;
    }

    public BigDecimal getPreco() {
        return preco;
    }

    public void setPreco(BigDecimal preco) {
        this.preco = preco;
    }
}
