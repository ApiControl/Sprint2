function validarInformacoesUsuario() {
    var nomeCadastro = i_cadastro_nome.value;
    var nascimentoCadastro = i_cadastro_nascimento.value;
    var emailCadastro = i_cadastro_email.value;
    var senhaCadastro = i_cadastro_senha.value;
    var confirmacaoSenhaCadastro = i_cadastro_confirmacao_senha.value;

   if(nomeCadastro.length < 1 || nascimentoCadastro .length < 1 ||
        (emailCadastro.length < 1 || (emailCadastro.indexOf("@") < 0 || emailCadastro.indexOf(".") < 0)) || senhaCadastro.length < 8 || senhaCadastro != confirmacaoSenhaCadastro) {

            if(nomeCadastro.length < 1) {
                setErro(i_cadastro_nome, "O nome de usuário é obrigatório.")
            } else {
                setSucesso(i_cadastro_nome)
            }
            if(nascimentoCadastro.length < 1) {
                setErro(i_cadastro_nascimento, "Digite uma data de nascimento válida")
            } else {
                setSucesso(i_cadastro_nascimento)
            }
            if(emailCadastro.length < 1) {
                setErro(i_cadastro_email, "O email é obrigatório")
            }else if(emailCadastro.indexOf("@") < 0 || emailCadastro.indexOf(".") < 0) {
                setErro(i_cadastro_email, "Digite um email válido")
            }else {
                setSucesso(i_cadastro_email);
            }
            if(senhaCadastro.length < 1) {
                setErro(i_cadastro_senha, "A senha é obrigatória");
            } else if(senhaCadastro.length < 8) {
                setErro(i_cadastro_senha, "A senha deve conter ao menos 8 caracteres");
            } else if(senhaCadastro != confirmacaoSenhaCadastro) {
                    setErro(i_cadastro_senha, "As senhas não coincidem")
                    setErro(i_cadastro_confirmacao_senha, "As senhas não coincidem")
            }else {
                setSucesso(i_cadastro_confirmacao_senha);
                setSucesso(i_cadastro_senha);
            }
    } else {

    console.log("Passou")
    cadastroEndereco();
    }

}

function setErro(input, msg) {
    var formControl = input.parentElement;
    var small = formControl.querySelector("small")

    // msg de erro
    small.innerText = msg;

    // Adicionar classe de erro
    formControl.className = "controleFormulario erro"
}

function setSucesso(input) {
    var formControl = input.parentElement;

    // Adicionar classe de sucesso

    formControl.className = "controleFormulario sucesso"

}