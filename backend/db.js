const mysql = require('mysql2/promise');
require('dotenv').config(); // Charge les variables d'environnement

const pool = mysql.createPool({
  host: process.env.DB_HOST,
  user: process.env.DB_USER,
  password: process.env.DB_PASSWORD,
  database: process.env.DB_NAME,
  waitForConnections: true,
  connectionLimit: 10,
  queueLimit: 0
});

// Test de connexion immédiat
pool.getConnection()
  .then(conn => {
    console.log('✅ Connecté à MySQL avec l\'utilisateur:', process.env.DB_USER);
    conn.release();
  })
  .catch(err => {
    console.error('❌ Erreur de connexion MySQL:', err.message);
    process.exit(1); // Quitte l'application si la connexion échoue
  });

module.exports = pool;