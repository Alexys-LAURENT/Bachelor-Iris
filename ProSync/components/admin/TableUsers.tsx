"use client"
import { Button } from "@nextui-org/button";
import { Table, TableHeader, TableBody, TableColumn, TableRow, TableCell, getKeyValue } from "@nextui-org/table";
import { useCallback, useState } from "react";
import ModalEdit from "./ModalEdit";
import ModalDelete from "./ModalDelete";
import { Input } from "@nextui-org/input";
import ModalCreate from "./ModalCreate";

const TableUsers = ({ idEntreprise, users, managers }: { idEntreprise: any, users: any[], managers: any[] }) => {

    const [filter, setFilter] = useState('');

    const [isCreating, setIsCreating] = useState(false);

    const [isEditing, setIsEditing] = useState(false);
    const [editedUser, setEditedUser] = useState({} as any);

    const [isDeleting, setIsDeleting] = useState(false);
    const [deletedUser, setDeletedUser] = useState<null | number>(null);

    const filteredUsers = users.map((user) => {
        return {
            ...user,
        };
    }).filter((user) => {
        return user.prenom.toLowerCase().includes(filter.toLowerCase()) ||
            user.nom.toLowerCase().includes(filter.toLowerCase()) ||
            user.email.toLowerCase().includes(filter.toLowerCase()) ||
            user.metier.toLowerCase().includes(filter.toLowerCase()) ||
            user.role.toLowerCase().includes(filter.toLowerCase());
    });

    const handleEdit = (user: any) => {
        setEditedUser(user)
        setIsEditing(true);
    };

    const handleDelete = (idUser: number) => {
        setDeletedUser(idUser);
        setIsDeleting(true);
    };

    const renderCell = useCallback((user: any, columnKey: any) => {
        const cellValue = user[columnKey];

        switch (columnKey) {
            case "actions":
                return (
                    <div className="flex gap-1">
                        <Button size="sm" variant="ghost" className="border-[#ee7c26] rounded-md" onClick={() => { handleEdit(user) }}>
                            <svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" strokeWidth={1.5} stroke="currentColor" className="size-6 text-black dark:text-white">
                                <path strokeLinecap="round" strokeLinejoin="round" d="m16.862 4.487 1.687-1.688a1.875 1.875 0 1 1 2.652 2.652L10.582 16.07a4.5 4.5 0 0 1-1.897 1.13L6 18l.8-2.685a4.5 4.5 0 0 1 1.13-1.897l8.932-8.931Zm0 0L19.5 7.125M18 14v4.75A2.25 2.25 0 0 1 15.75 21H5.25A2.25 2.25 0 0 1 3 18.75V8.25A2.25 2.25 0 0 1 5.25 6H10" />
                            </svg>
                        </Button>
                        <Button size="sm" variant="ghost" color="danger" className="rounded-md" onClick={() => { handleDelete(user.idUser) }}>
                            <svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" strokeWidth={1.5} stroke="currentColor" className="size-6 text-black dark:text-white">
                                <path strokeLinecap="round" strokeLinejoin="round" d="m14.74 9-.346 9m-4.788 0L9.26 9m9.968-3.21c.342.052.682.107 1.022.166m-1.022-.165L18.16 19.673a2.25 2.25 0 0 1-2.244 2.077H8.084a2.25 2.25 0 0 1-2.244-2.077L4.772 5.79m14.456 0a48.108 48.108 0 0 0-3.478-.397m-12 .562c.34-.059.68-.114 1.022-.165m0 0a48.11 48.11 0 0 1 3.478-.397m7.5 0v-.916c0-1.18-.91-2.164-2.09-2.201a51.964 51.964 0 0 0-3.32 0c-1.18.037-2.09 1.022-2.09 2.201v.916m7.5 0a48.667 48.667 0 0 0-7.5 0" />
                            </svg>
                        </Button>
                    </div>
                );
            case "idManager":
                const manager = managers.find((manager) => manager.idManager === cellValue);
                return manager ?
                    `${manager.prenom} ${manager.nom}` :
                    'N/A';
            default:
                return cellValue;
        }
    }, []);

    const columns = [
        { key: 'idUser', label: 'ID' },
        { key: 'idManager', label: 'Manager' },
        { key: 'prenom', label: 'Prénom' },
        { key: 'nom', label: 'Nom' },
        { key: 'email', label: 'Email' },
        { key: 'metier', label: 'Métier' },
        { key: 'role', label: 'Role' },
        { key: 'actions', label: 'Actions' }
    ];

    return (
        <>
            <h1 className='text-4xl font-bold text-black dark:text-white'>{filteredUsers.length} {filteredUsers.length > 1 ? 'Utilisateurs' : 'Utilisateur'}</h1>

            <div className='flex flex-row gap-4 justify-between items-center'>
                <Input size='sm' label='Rechercher un utilisateur' className='max-w-lg' value={filter} onChange={(e) => setFilter(e.target.value)} />
                <Button size='sm' className="bg-[#ee7c26]" onClick={() => setIsCreating(true)}>
                    <svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" strokeWidth={1.5} stroke="currentColor" className="size-5">
                        <path strokeLinecap="round" strokeLinejoin="round" d="M12 4.5v15m7.5-7.5h-15" />
                    </svg>
                </Button>
            </div>

            <Table isStriped className="w-full h-full overflow-auto text-black dark:text-white bg-white dark:bg-black" classNames={{ wrapper: 'bg-[#fcfcfc] dark:bg-[#18181b]' }}>
                <TableHeader columns={columns}>
                    {(column) => <TableColumn key={column.key}>{column.label}</TableColumn>}
                </TableHeader>
                <TableBody items={filteredUsers}>
                    {(item) => (
                        <TableRow key={`user-${item.idUser}`}>
                            {(columnKey) => <TableCell>{renderCell(item, columnKey) || 'N/A'}</TableCell>}
                        </TableRow>
                    )}
                </TableBody>
            </Table>

            <ModalEdit user={editedUser} managers={managers} isOpen={isEditing} onClose={() => setIsEditing(false)} />
            <ModalDelete idUser={deletedUser} isOpen={isDeleting} onClose={() => setIsDeleting(false)} />
            <ModalCreate idEntreprise={idEntreprise} isOpen={isCreating} onClose={() => setIsCreating(false)} managers={managers} />
        </>
    );
};

export default TableUsers;