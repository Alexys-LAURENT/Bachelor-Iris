"use server";

import mysql from 'mysql2/promise';

export async function updateUser(idUser: number, idManager: any, nom: string, prenom: string, email: string, metier: string, role: string) {

    const connection = await mysql.createConnection({
        host: process.env.MYSQL_HOST,
        user: process.env.MYSQL_USER,
        password: process.env.MYSQL_PASSWORD,
        database: process.env.MYSQL_DATABASE,
        port: parseInt(process.env.MYSQL_PORT as string)
    });


    try {
        const [rows] = await connection.execute(
            'UPDATE users SET idManager = ?, nom = ?, prenom = ?, email = ?, metier = ? WHERE idUser = ?',
            [idManager, nom, prenom, email, metier, idUser]
        );


        const [admin]: any[] = await connection.execute(
            'SELECT * FROM admins WHERE idAdmin = ?',
            [idUser]
        );

        if (admin.length > 0 && role === 'user') {
            await connection.execute(
                'DELETE FROM admins WHERE idAdmin = ?',
                [idUser]
            );
        } else if (admin.length === 0 && role === 'admin') {
            await connection.execute(
                'INSERT INTO admins (idAdmin, role) VALUES (?, "admin")',
                [idUser]
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