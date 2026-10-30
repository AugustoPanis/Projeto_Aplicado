const express = require('express');

const router = express.Router();

const clienteController = require('../controllers/clienteController');
const authMiddleware = require('../middleware/authMiddleware')

router.get('/', clienteController.getAll);
router.get('/:id', clienteController.getId);
router.post('/', clienteController.criar);
router.post('/testar', authMiddleware, clienteController.testarConexao);
router.put('/:id', clienteController.update);
router.delete('/:id', clienteController.deletarCliente);


module.exports = router;