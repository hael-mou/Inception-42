// server.js
const express = require('express');
const path = require('path');
const app = express();
const port = 8081;

// Serve static files from the 'public' directory
app.use(express.static(path.join(__dirname, 'public')));

// Endpoint to sum two numbers
app.get('/sum', (req, res) => {
    const { a, b } = req.query;
    if (a && b) {
        const sum = parseFloat(a) + parseFloat(b);
        res.json({ sum });
    } else {
        res.status(400).json({ error: 'Please provide two numbers a and b' });
    }
});

app.listen(port, () => {
    console.log(`Server running at http://localhost:${port}`);
});
