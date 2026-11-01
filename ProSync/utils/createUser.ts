"use server";

import mysql from 'mysql2/promise';

export async function createUser(idEntreprise: number, idManager: any, nom: string, prenom: string, email: string, metier: string, theme: string, status: string, role: string) {

    const connection = await mysql.createConnection({
        host: process.env.MYSQL_HOST,
        user: process.env.MYSQL_USER,
        password: process.env.MYSQL_PASSWORD,
        database: process.env.MYSQL_DATABASE,
        port: parseInt(process.env.MYSQL_PORT as string)
    });


    try {
        const [rows] = await connection.execute(
            'INSERT INTO users (idEntreprise, idManager, nom, prenom, email, metier, theme, statut, hashedPass) VALUES (?, ?, ?, ?, ?, ?, ?, ?)',
            [idEntreprise, idManager, nom, prenom, email, metier, theme, status, 'defaultPass123']
        );

        const [user]: any[] = await connection.execute(
            'SELECT idUser FROM users WHERE email = ?',
            [email]
        );

        if (role === 'admin') {
            await connection.execute(
                'INSERT INTO admins (idAdmin, role) VALUES (?, "admin")',
                [user[0].idUser]
            );
        }

        await connection.end();

        return true;

    }

    catch (error) {
        await connection.end();
        throw error;
    }

}