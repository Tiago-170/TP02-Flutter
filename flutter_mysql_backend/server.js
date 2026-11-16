const express = require('express'); 
const mysql = require('mysql'); 
const app = express(); 
const port = 3000; 
const cors = require('cors'); 

app.use(cors()); 
const connection = mysql.createConnection({ 
    host: 'localhost', 
    user: 'gestion_utilisateurs',     
    password: 'bge(cHGi(eCL0ek@', 
    database: 'gestion_utilisateurs' 
}); 

connection.connect(err => { 
    if (err) throw err; 
    console.log('Connecté à la base MySQL'); 
}); 

app.use(express.json()); 

app.get('/api/utilisateurs', (req, res) => { 
    connection.query('SELECT * FROM users', (err, results) => { 
        if (err) throw err; 
        res.json(results); 
    }); 
}); 

app.post('/api/utilisateurs', (req, res) => { 
    const { nom, email, telephone } = req.body; 
    connection.query( 
        'INSERT INTO users (nom, email, telephone) VALUES (?, ?, ?)', 
        [nom, email, telephone], 
        (err, result) => { 
            if (err) throw err; 
            res.status(201).json({ id: result.insertId, nom, email, telephone }); 
        } 
    ); 
    console.log("Utilisateur ajouté avec succès");
}); 
app.listen(port, () => { 
    console.log(`Serveur backend opérationnel : 
    http://localhost:${port}`); 
}); 