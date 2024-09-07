const { Sequelize } = require('sequelize');

// Database connection
const sequelize = new Sequelize('accounting_db', 'postgres', 'your_password', {
    host: 'localhost',
    dialect: 'postgres',
});

module.exports = sequelize;
