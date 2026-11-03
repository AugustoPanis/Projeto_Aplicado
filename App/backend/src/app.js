const express = require("express");
const cookieParser = require('cookie-parser');
const cors = require("cors"); 
require('dotenv').config();

const app = express();
app.use(cookieParser());

app.use(cors({
  origin: "*"
}));
app.use(express.json());

const clienteRoutes = require("./routes/clienteRoutes.js");

app.use("/clientes", clienteRoutes);

module.exports = app;