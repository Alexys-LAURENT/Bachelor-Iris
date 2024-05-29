"use server";

import mysql from 'mysql2/promise';

export async function updatePassword(idUser: number, password: string) {

    const connection = await mysql.createConnection({
        host: process.env.MYSQL_HOST,
        user: process.env.MYSQL_USER,
        password: process.env.MYSQL_PASSWORD,
        database: process.env.MYSQL_DATABASE,
        port: parseInt(process.env.MYSQL_PORT as string)
    });

    try {
        await connection.execute(
            'UPDATE users SET hashedPass = ? WHERE idUser = ?',
            [password, idUser]
        );

        await connection.end();
    }
    catch (error) {
        await connection.end();
        throw error;
    }

}