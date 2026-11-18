const bcrypt = require('bcrypt');
const jwt = require('jsonwebtoken');
const clienteRepository = require('../repositories/ClienteRepository');
const crypto = require('crypto');


const validaEmail = async (email, id) => {
    const emailExistente = await clienteRepository.findByEmail(email);

    if (emailExistente && emailExistente._id.toString() !== id) {
        throw new Error("E-mail já cadastrado");
    }
}

const validaCliente = async (id) => {
    const cliente = await clienteRepository.getId(id);

    if (!cliente) {
        throw new Error("Cliente não encontrado");
    }

    return cliente;
}

const criar = async (dados) => {

    await validaEmail(dados.email)

    if (dados.role === 'operador') {
        if (!dados.senha) throw new Error('Senha obrigatória para operador');
        dados.senha = await bcrypt.hash(dados.senha, 10);
    }

    const novoUsuario = await clienteRepository.create(dados);
    return novoUsuario;
};

const login = async (cpf, senha) => {

    const usuario = await clienteRepository.findByCpf(cpf);

    if (!usuario) {
        throw new Error('Usuário não encontrado');
    }

    if (usuario.role === 'operador') {
        if (!senha) throw new Error('Senha é obrigatória para operadores');

        const senhaValida = await bcrypt.compare(senha, usuario.senha);
        if (!senhaValida) {
            throw new Error('Credenciais inválidas');
        }
    }

    const token = jwt.sign(
        { id: usuario._id, role: usuario.role },
        process.env.JWT_SECRET,
        { expiresIn: '1d' }
    );

    return { token, usuario: { id: usuario._id, nome: usuario.nome, role: usuario.role } };
};

const getAll = async () => {
    return await clienteRepository.getAll();
}

const getId = async (id) => {
    return await clienteRepository.getId(id);
}

const update = async (id, dados) => {
    await validaCliente(id);

    if (dados.email) {
        await validaEmail(dados.email, id);
    }
    return await clienteRepository.update(id, dados);
};

const deletarCliente = async (id) => {
    await validaCliente(id);
    return await clienteRepository.deleteCliente(id);
};

const testarConexao = async (id) => {
    const cliente = await validaCliente(id);

    const enviado = enviarMensagem(cliente.tokenApp, {
        tipo: 'teste',
        mensagem: 'Conexão testada pelo admin!'
    });

    if (!enviado) {
        throw new Error('App offline ou não conectado');
    }
};

module.exports = {
    criar,
    getAll,
    getId,
    update,
    deletarCliente,
    testarConexao,
    login
};