const { Sequelize, DataTypes } = require('sequelize');
const sequelize = require('../database');

// Define Product model
const Product = sequelize.define('Product', {
    name: {
        type: DataTypes.STRING,
        allowNull: false,
    },
    price: {
        type: DataTypes.FLOAT,
        allowNull: false,
    },
    stock: {
        type: DataTypes.INTEGER,
        allowNull: false,
    }
});

module.exports = Product;
