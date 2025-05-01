const express = require('express');
const bodyParser = require('body-parser');
const mysql = require('mysql2');
const app = express();
const PORT = 3000;

app.use(bodyParser.json());

// MySQL connection setup
const db = mysql.createConnection({
    host: 'localhost',
    user: 'root',
    password: '123456',
    database: 'clinicdb'
});

db.connect((err) => {
    if (err) throw err;
    console.log('MySQL connected...');
});

// Root route
app.get('/', (req, res) => {
    res.send('Welcome to the Clinicdb Task Manager API!');
});

// Routes

// Create a task
app.post('/tasks', (req, res) => {
    const { user_id, title, description, due_date } = req.body;
    const sql = 'INSERT INTO Tasks (user_id, title, description, due_date) VALUES (?, ?, ?, ?)';
    db.query(sql, [user_id, title, description, due_date], (err, result) => {
        if (err) return res.status(500).json({ error: err.message });
        res.status(201).json({ message: 'Task created', task_id: result.insertId });
    });
});

// Get all tasks
app.get('/tasks', (req, res) => {
    db.query('SELECT * FROM Tasks', (err, results) => {
        if (err) return res.status(500).json({ error: err.message });
        res.json(results);
    });
});

// Update a task
app.put('/tasks/:id', (req, res) => {
    const { title, status } = req.body;
    const sql = 'UPDATE Tasks SET title = ?, status = ? WHERE task_id = ?';
    db.query(sql, [title, status, req.params.id], (err, result) => {
        if (err) return res.status(500).json({ error: err.message });
        res.json({ message: 'Task updated' });
    });
});

// Delete a task
app.delete('/tasks/:id', (req, res) => {
    db.query('DELETE FROM Tasks WHERE task_id = ?', [req.params.id], (err, result) => {
        if (err) return res.status(500).json({ error: err.message });
        res.json({ message: 'Task deleted' });
    });
});

app.listen(PORT, () => {
    console.log(`Server running on http://localhost:${PORT}`);
});
