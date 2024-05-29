"use server";

import mysql from 'mysql2/promise';

export async function deleteUser(idUser: number) {

    const connection = await mysql.createConnection({
        host: process.env.MYSQL_HOST,
        user: process.env.MYSQL_USER,
        password: process.env.MYSQL_PASSWORD,
        database: process.env.MYSQL_DATABASE,
        port: parseInt(process.env.MYSQL_PORT as string)
    });


    try {
        const [rows] = await connection.execute(
            'DELETE FROM users WHERE idUser = ?',
            [idUser]
        );

        await connection.end();

        return true;

    }

    catch (error) {
        await connection.end();
        throw error;
    }

}