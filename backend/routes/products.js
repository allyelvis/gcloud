const express = require('express');
const router = express.Router();
const Product = require('../models/Product');

// Add product
router.post('/add', async (req, res) => {
    const { name, price, stock } = req.body;
    try {
        const newProduct = await Product.create({ name, price, stock });
        res.json(newProduct);
    } catch (err) {
        res.status(500).json({ error: err.message });
    }
});

// Get all products
router.get('/list', async (req, res) => {
    try {
        const products = await Product.findAll();
        res.json(products);
    } catch (err) {
        res.status(500).json({ error: err.message });
    }
});

module.exports = router;
