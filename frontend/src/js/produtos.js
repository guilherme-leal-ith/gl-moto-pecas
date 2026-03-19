const form = document.getElementById("formProduto");
const tabela = document.querySelector("#tabelaProdutos tbody");

// CADASTRAR
form.addEventListener("submit", async (e) => {
    e.preventDefault();

    const produto = {
        nome: document.getElementById("nome").value,
        categoria: document.getElementById("categoria").value,
        marca: document.getElementById("marca").value,
        preco: document.getElementById("preco").value
    };

    await fetch("http://localhost:8080/produtos", {
        method: "POST",
        headers: {
            "Content-Type": "application/json"
        },
        body: JSON.stringify(produto)
    });

    carregarProdutos();
});

// LISTAR
async function carregarProdutos() {
    const resposta = await fetch("http://localhost:8080/produtos");
    const produtos = await resposta.json();

    tabela.innerHTML = "";

    produtos.forEach(p => {
        tabela.innerHTML += `
            <tr>
                <td>${p.id}</td>
                <td>${p.nome}</td>
                <td>${p.categoria}</td>
                <td>${p.marca}</td>
                <td>${p.preco}</td>
            </tr>
        `;
    });
}

carregarProdutos();