require("dotenv").config(); // Charge les variables d'environnement en premier
const express = require("express");
const path = require("path");
const mysql = require("mysql2/promise");
const app = express();

// Configuration de la base de données
const pool = mysql.createPool({
	// Utiliser les variables d'environnement si elles existent
	host: process.env.DB_HOST,
	user: process.env.DB_USER,
	password: process.env.DB_PASS,
	database: process.env.DB_NAME,,
	waitForConnections: true,
	connectionLimit: 10,
});

// Middleware
app.use(express.json());

// Test de connexion à la DB au démarrage
pool
	.getConnection()
	.then((connection) => {
		console.log(
			"✅ Connecté à MySQL avec l'utilisateur:",
			process.env.DB_USER || "root"
		);
		connection.release();
	})
	.catch((err) => {
		console.error("❌ ERREUR DB:", err.message);
		console.log("Configuration utilisée:", {
			host: process.env.DB_HOST,
			user: process.env.DB_USER,
			database: process.env.DB_NAME,
		});
	});

// Routes
app.get("/api/ping", async (req, res) => {
	try {
		const [result] = await pool.query("SELECT COUNT(*) AS count FROM game");
		res.json({ count: result[0].count });
	} catch (err) {
		res.json({ count: 0 });
	}
});

app.get("/api/games", async (req, res) => {
	try {
		const [games] = await pool.query("SELECT * FROM Game");
		res.json(games);
	} catch (err) {
		res.status(500).json({ error: err.message });
	}
});

// Afficher seulement les jeux disponibles (via la vue)
app.get("/api/games/available", async (req, res) => {
	try {
		const [games] = await pool.query("SELECT * FROM available_games");
		res.json(games);
	} catch (err) {
		res.status(500).json({ error: err.message });
	}
});

// Ajouter un jeu (via la procédure stockée)
app.post("/api/games", async (req, res) => {
	const {
		ID_Game,
		Price_per_Day,
		Description,
		Minimum_Number_of_Players,
		Maximum_Number_of_Players,
		Minimum_Age,
		Image,
		Name,
		ID_Group,
		ID_USER,
	} = req.body;
	try {
		await pool.query("CALL add_new_game(?,?,?,?,?,?,?,?,?,?)", [
			ID_Game,
			Price_per_Day,
			Description,
			Minimum_Number_of_Players,
			Maximum_Number_of_Players,
			Minimum_Age,
			Image,
			Name,
			ID_Group,
			ID_USER,
		]);
		res.status(201).json({ message: "Jeu ajouté." });
	} catch (err) {
		res.status(500).json({ error: err.message });
	}
});

// Supprimer un jeu
app.delete("/api/games/:id", async (req, res) => {
	try {
		await pool.query("DELETE FROM Game WHERE ID_Game = ?", [req.params.id]);
		res.json({ message: "Jeu supprimé." });
	} catch (err) {
		res.status(500).json({ error: err.message });
	}
});

// Modifier un jeu
app.put("/api/games/:id", async (req, res) => {
	const fields = req.body;
	try {
		await pool.query("UPDATE Game SET ? WHERE ID_Game = ?", [
			fields,
			req.params.id,
		]);
		res.json({ message: "Jeu modifié." });
	} catch (err) {
		res.status(500).json({ error: err.message });
	}
});

// Ajouter un joueur
app.post("/api/players", async (req, res) => {
	const { ID_USER, Email, Password, Name, Age, ID_Group } = req.body;
	try {
		await pool.query(
			"INSERT INTO Player (ID_USER, Email, Password, Name, Age, ID_Group) VALUES (?, ?, ?, ?, ?, ?)",
			[ID_USER, Email, Password, Name, Age, ID_Group]
		);
		res.status(201).json({ message: "Joueur ajouté." });
	} catch (err) {
		res.status(500).json({ error: err.message });
	}
});

// Modifier un joueur
app.put("/api/players/:id", async (req, res) => {
	const fields = req.body;
	try {
		await pool.query("UPDATE Player SET ? WHERE ID_USER = ?", [
			fields,
			req.params.id,
		]);
		res.json({ message: "Joueur modifié." });
	} catch (err) {
		res.status(500).json({ error: err.message });
	}
});

// Supprimer un joueur
app.delete("/api/players/:id", async (req, res) => {
	try {
		await pool.query("DELETE FROM Player WHERE ID_USER = ?", [req.params.id]);
		res.json({ message: "Joueur supprimé." });
	} catch (err) {
		res.status(500).json({ error: err.message });
	}
});

// Louer un jeu (transaction de location)
app.post("/api/borrow", async (req, res) => {
	const { ID_Game, ID_USER, Duration } = req.body;
	try {
		await pool.query("CALL rent_game(?, ?, ?)", [ID_Game, ID_USER, Duration]);
		res.status(201).json({ message: "Jeu loué." });
	} catch (err) {
		res.status(500).json({ error: err.message });
	}
});

// Retourner un jeu
app.post("/api/return", async (req, res) => {
	const { ID_Game, ID_USER } = req.body;
	try {
		await pool.query("CALL return_game(?, ?)", [ID_Game, ID_USER]);
		res.json({ message: "Jeu retourné." });
	} catch (err) {
		res.status(500).json({ error: err.message });
	}
});

// Historique des locations d'un utilisateur (vue)
app.get("/api/players/:id/history", async (req, res) => {
	try {
		const [history] = await pool.query(
			"SELECT * FROM user_rental_history WHERE ID_USER = ?",
			[req.params.id]
		);
		res.json(history);
	} catch (err) {
		res.status(500).json({ error: err.message });
	}
});

// Louer un jeu (transaction de location)
app.post("/api/borrow", async (req, res) => {
	const { ID_Game, ID_USER, Duration } = req.body;
	const connection = await pool.getConnection();
	try {
		await connection.beginTransaction();

		// 1. Vérifier la disponibilité
		const [rows] = await connection.query(
			"SELECT Status FROM game_availability WHERE ID_Game = ? FOR UPDATE",
			[ID_Game]
		);

		if (!rows.length || rows[0].Status !== "Disponible") {
			await connection.rollback();
			return res.status(400).json({ error: "Jeu non disponible." });
		}

		// 2. Insérer la location
		await connection.query(
			"INSERT INTO Borrow (ID_Game, ID_USER, Duration) VALUES (?, ?, ?)",
			[ID_Game, ID_USER, Duration]
		);

		await connection.commit();
		res.status(201).json({ message: "Jeu loué." });
	} catch (err) {
		await connection.rollback();
		res.status(500).json({ error: err.message });
	} finally {
		connection.release();
	}
});
// ...existing code...

// Servir les fichiers statiques
app.use(express.static(path.join(__dirname, "../frontend")));

// Démarrer le serveur
const PORT = process.env.PORT || 8080;
app.listen(PORT, () => {
	console.log(`
  🚀 Backend lancé sur http://localhost:${PORT}
  `);
});
