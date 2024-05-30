import mysql from 'mysql2/promise';
import { cookies } from 'next/headers';

export async function getUserTheme() {
    const token = cookies().get('token')?.value;
    if (!token) {
        return console.error('No token found');
    }

    const tokenObject = JSON.parse(token);

    try {
        const connection = await mysql.createConnection({
            host: process.env.MYSQL_HOST,
            user: process.env.MYSQL_USER,
            password: process.env.MYSQL_PASSWORD,
            database: process.env.MYSQL_DATABASE,
            port: parseInt(process.env.MYSQL_PORT as string)
        });

        const [rows] = await connection.execute(
            'SELECT theme FROM users u, token t WHERE u.idUser = t.idUser AND t.token = ?',
            [tokenObject.token]
        );

        await connection.end();

        if ((rows as any[]).length === 0) {
            return null;
        }

        const result = rows as any[];

        return result[0].theme;

    } catch (error) {
        if (error instanceof Error) {
            console.error(error)
        }
    }
}
