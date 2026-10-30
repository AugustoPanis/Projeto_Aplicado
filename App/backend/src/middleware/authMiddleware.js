const Cliente = require('../repositories/ClienteRepository'); // ou o seu repository

const authMiddleware = async (req, res, next) => {
    try {
        const authHeader = req.headers.authorization;

        if (!authHeader) {
            return res.status(401).json({ error: 'Token não fornecido.' });
        }

        const [, tokenApp] = authHeader.split(' ');
        console.log("TOKEN RECEBIDO DO POSTMAN:", `"${tokenApp}"`)

        // No middleware:
const cliente = await Cliente.findOne(tokenApp); // Passando a string direto

        if (!cliente) {
            return res.status(401).json({ error: 'Token inválido ou acesso revogado.' });
        }

        req.cliente = cliente;
        next();
    } catch (error) {
        console.log('ERRO NO MIDDLEWARE:', error);
        return res.status(500).json({ error: 'Erro interno na autenticação.' });
    }
};

module.exports = authMiddleware;