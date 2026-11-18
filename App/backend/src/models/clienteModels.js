const mongoose = require('mongoose');

const clienteSchema = new mongoose.Schema({
    cpf: { 
        type: String, 
        required: true, 
        unique: true 
    },
    nome: {
        type: String,
        required: true,
        trim: true,
    },
    email: {
        type: String,
        required: true,
        trim: true,
        lowercase: true,
    },
    senha: { 
        type: String, 
        required: false 
    },
    tokenApp: {
        type: String,
        unique: true,
        trim: true,
    },
    role: 
    { 
        type: String, 
        enum: ['cliente', 'operador'], 
        default: 'cliente' },
});

module.exports = mongoose.model('Cliente', clienteSchema);