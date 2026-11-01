import mysql from 'mysql2/promise';
import { cookies } from 'next/headers';

export async function getManagers() {
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
            // get all managers with corresponding nom and prenom from users table where the idUser for idManager is in the same entreprise as the user
            'SELECT m.*, u.nom, u.prenom FROM managers m JOIN users u ON m.idManager = u.idUser WHERE m.idManager IN (SELECT idUser FROM users WHERE idEntreprise = (SELECT idEntreprise FROM users WHERE idUser = (SELECT idUser FROM token WHERE token = ?)))',
            [tokenObject.token]
        ) as any[];

        const managersWithKey = (rows as any[]).map((manager: any) => {
            return { ...manager, key: manager.idManager };
        });

        await connection.end();

        return managersWithKey;

    }
    catch (error) {
        await connection.end();
        throw error;
    }

}