"use server";

import mysql from 'mysql2/promise';
import { cookies } from 'next/headers';

export async function changeTheme(theme: string) {
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

    const newTheme = theme === 'dark' ? 'light' : 'dark';

    try {
        const [rows] = await connection.execute(
            'UPDATE users u, token t SET u.theme = ? WHERE u.idUser = t.idUser AND t.token = ?',
            [newTheme, tokenObject.token]
        );

        await connection.end();
    }
    catch (error) {
        await connection.end();
        throw error;
    }
}