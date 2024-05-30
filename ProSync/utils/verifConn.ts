'use server';

import mysql from 'mysql2/promise';

// Définir un type pour les résultats de la requête
interface TokenResult {
    token: string;
    expireAt: string;
}

export async function verifConn(email: string, password: string): Promise<TokenResult | null> {
    const connection = await mysql.createConnection({
        host: process.env.MYSQL_HOST,
        user: process.env.MYSQL_USER,
        password: process.env.MYSQL_PASSWORD,
        database: process.env.MYSQL_DATABASE,
        port: parseInt(process.env.MYSQL_PORT as string)
    });

    try {
        const [rows] = await connection.execute<any>(
            'SELECT token, expireAt FROM token t, users u WHERE t.idUser = u.idUser AND u.email = ? AND u.hashedPass = ?',
            [email, password]
        );

        // Si il n'y a pas de token, verifier si l'utilisateur existe et créer un token pour lui
        if (rows.length === 0) {
            const [user] = await connection.execute<any>(
                'SELECT * FROM users WHERE email = ? AND hashedPass = ?',
                [email, password]
            );

            if (user.length === 0) {
                await connection.end();
                return null;
            }

            // Ajouter 1 mois à la date actuelle
            const expireAt = new Date();
            expireAt.setMonth(expireAt.getMonth() + 1);

            // Créer un token
            const token = (
                Math.random().toString(36).substring(2) +
                Math.random().toString(36).substring(2) +
                Math.random().toString(36).substring(2) +
                Math.random().toString(36).substring(2)
            ).substring(0, 42);
            await connection.execute(
                'INSERT INTO token (token, idUser, expireAt) VALUES (?, ?, ?)',
                [token, user[0].idUser, expireAt.toISOString()]
            );

            await connection.end();

            return { token, expireAt: expireAt.toISOString() };
        }


        if (rows[0].expireAt.toISOString() < new Date().toISOString()) {

            // Ajouter 1 mois à la date d'expiration
            const expireAt = new Date();
            expireAt.setMonth(expireAt.getMonth() + 1);

            // Mettre à jour la date d'expiration
            await connection.execute(
                'UPDATE token SET expireAt = ? WHERE token = ?',
                [expireAt.toISOString(), rows[0].token]
            );

            await connection.end();

            // Retourner le token mis à jour
            return { token: rows[0].token, expireAt: expireAt.toISOString() };
        } else {

            await connection.end();
            return rows[0];  // Retourne le premier résultat ou null si aucun résultat n'est trouvé
        }

    } catch (error) {
        await connection.end();
        throw error;
    }
}
