require('dotenv').config(); // Charge les variables d'environnement en premier
const express = require('express');
const path = require('path');
const mysql = require('mysql2/promise');
const app = express();

// Configuration de la base de données
const pool = mysql.createPool({
  host: process.env.DB_HOST || 'localhost',
  user: process.env.DB_USER || 'boardgame_user',
  password: process.env.DB_PASS || 'votre_mot_de_passe_fort',
  database: process.env.DB_NAME || 'boardgame_db',
  waitForConnections: true,
  connectionLimit: 10,
  queueLimit: 0
});

// Middleware
app.use(express.json());

// Test de connexion à la DB au démarrage
pool.getConnection()
  .then(connection => {
    console.log('✅ Connecté à MySQL avec l\'utilisateur:', process.env.DB_USER || 'boardgame_user');
    connection.release();
  })
  .catch(err => {
    console.error('❌ ERREUR DB:', err.message);
    console.log('Configuration utilisée:', {
      host: process.env.DB_HOST,
      user: process.env.DB_USER,
      database: process.env.DB_NAME
    });
  });

// Routes
app.get('/api/ping', async (req, res) => {
  try {
    const [result] = await pool.query('SELECT COUNT(*) AS count FROM game');
    res.json({ count: result[0].count });
  } catch (err) {
    res.json({ count: 0 });
  }
});


// Servir les fichiers statiques
app.use(express.static(path.join(__dirname, '../frontend')));

// Démarrer le serveur
const PORT = process.env.PORT || 8080;
app.listen(PORT, () => {
  console.log(`
  🚀 Backend lancé sur http://localhost:${PORT}
  `);
});