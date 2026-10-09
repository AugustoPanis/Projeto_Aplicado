const app = require("./app");
const connectDatabase = require("./config/database");
require('dotenv').config({ path: __dirname + '/.env' });

connectDatabase();

const PORT =  process.env.PORT;

app.listen(PORT, () => {
  console.log(`Servidor rodando na porta ${PORT}`);
});