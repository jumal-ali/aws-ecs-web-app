'use strict';

const express = require('express');
const morgan = require('morgan');
// const process = require('process');

// Constants
const PORT = 3000;
const HOST = '0.0.0.0';

// App
const app = express();
app.use(morgan('combined'));

// Routing
app.get('/', (req, res) => {
  res.send('<h1 style="color:green;">Hello Super Awesome World</h1>');
});

app.listen(PORT, HOST);
console.log(`Running on http://${HOST}:${PORT}`);
