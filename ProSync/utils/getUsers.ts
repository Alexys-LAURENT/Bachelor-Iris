"use server";

import mysql from 'mysql2/promise';

export async function getUsers(idEntreprise: number) {

    const connection = await mysql.createConnection({
        host: process.env.MYSQL_HOST,
        user: process.env.MYSQL_USER,
        password: process.env.MYSQL_PASSWORD,
        database: process.env.MYSQL_DATABASE,
        port: parseInt(process.env.MYSQL_PORT as string)
    });


    try {
        const [rows] = await connection.execute(
            'SELECT * FROM users WHERE idEntreprise = ?',
            [idEntreprise]
        ) as any[];

        // for each user, add a Entreprise key with the value 'nom' from entreprises table
        for (let i = 0; i < rows.length; i++) {
            const [entreprise]: any[] = await connection.execute(
                'SELECT nom FROM entreprises WHERE idEntreprise = ?',
                [rows[i].idEntreprise]
            );
            rows[i].Entreprise = entreprise?.[0]?.nom ?? 'N/A';

            const [admin]: any[] = await connection.execute(
                'SELECT * FROM admins WHERE idAdmin = ?',
                [rows[i].idUser]
            );

            if (admin.length > 0) {
                rows[i].role = 'admin';
            } else {
                rows[i].role = 'user';
            }
        }

        const usersWithKey = (rows as any[]).map((user: any) => {
            return { ...user, key: user.idUser };
        });

        await connection.end();

        return usersWithKey;
    }
    catch (error) {
        await connection.end();
        throw error;
    }
}