const express = require('express');
const bodyParser = require('body-parser');
const cors = require('cors');
const { Sequelize } = require('sequelize');

// Set up Express app
const app = express();
app.use(bodyParser.json());
app.use(cors());

// Set up PostgreSQL connection
const sequelize = new Sequelize('accounting_db', 'postgres', 'your_password', {
    host: 'localhost',
    dialect: 'postgres',
});

sequelize.authenticate()
    .then(() => console.log('Database connected'))
    .catch(err => console.log('Error: ' + err));

// Start server
const PORT = process.env.PORT || 5000;
app.listen(PORT, () => {
    console.log('Server is running on port', PORT);
});
