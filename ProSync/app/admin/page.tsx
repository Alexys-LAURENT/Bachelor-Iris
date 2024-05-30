import TableUsers from '@/components/admin/TableUsers';
import { getManagers } from '@/utils/getManagers';
import { getUser } from '@/utils/getUser';
import { getUsers } from '@/utils/getUsers';
import { redirect } from 'next/navigation';

const page = async () => {

    const user = await getUser() as any[];
    const managers = await getManagers() as any[];

    if (user[0].role !== 'admin') {
        return redirect('/');
    }

    const users = await getUsers(user[0].idEntreprise);

    return (
        <div className='w-full h-full flex flex-col p-12 gap-6 bg-white dark:bg-black'>
            <TableUsers idEntreprise={user[0].idEntreprise} users={users} managers={managers} />
        </div>
    );
};

export default page;