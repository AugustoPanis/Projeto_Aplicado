const mongoose = require('mongoose');

const clienteSchema = new mongoose.Schema({
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
    tokenApp: {
        type: String,
        unique: true,
        trim: true,
    },
    role: {
        type: String,
        enum: ['user', 'adm'],
        default: 'user'
    }
});

module.exports = mongoose.model('Cliente', clienteSchema);