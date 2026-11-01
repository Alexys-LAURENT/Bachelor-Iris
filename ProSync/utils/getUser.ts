"use server";

import mysql from 'mysql2/promise';
import { cookies } from 'next/headers';

export async function getUser() {
    const token = cookies().get('token')?.value;
    if (!token) {
        return console.error('No token found');
    }

    const tokenObject = JSON.parse(token);

    const connection = await mysql.createConnection({
        host: process.env.MYSQL_HOST,
        user: process.env.MYSQL_USER,
        password: process.env.MYSQL_PASSWORD,
        database: process.env.MYSQL_DATABASE,
        port: parseInt(process.env.MYSQL_PORT as string)
    });


    try {
        const [rows] = await connection.execute(
            'SELECT u.* FROM users u, token t WHERE t.token = ? AND t.idUser = u.idUser',
            [tokenObject.token]
        ) as any[];

        if (rows.length === 0) {
            return null;
        }

        const [mustChangePassword]: any[] = await connection.execute(
            'SELECT IF(hashedPass = "defaultPass123", 1, 0) AS mustChangePassword FROM users WHERE idUser = ?',
            [rows[0].idUser]
        );

        // if idUser in admins table, add a key role with the value 'admin' else 'user'
        const [admin]: any[] = await connection.execute(
            'SELECT * FROM admins WHERE idAdmin = ?',
            [rows[0].idUser]
        );

        if (admin.length > 0) {
            rows[0].role = 'admin';
        } else {
            rows[0].role = 'user';
        }

        const userWithKey = (rows as any[]).map((user: any) => {
            return { ...user, key: user.idUser, mustChangePassword: mustChangePassword[0].mustChangePassword };
        });

        await connection.end();

        return userWithKey;
    }
    catch (error) {
        await connection.end();
        throw error;
    }
}