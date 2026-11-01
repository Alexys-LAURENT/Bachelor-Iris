"use client"
import { Button } from "@nextui-org/button";
import { Modal, ModalContent, ModalHeader, ModalBody, ModalFooter } from "@nextui-org/modal";
import { Input } from "@nextui-org/input";
import { useEffect, useState } from "react";
import { Select, SelectSection, SelectItem } from "@nextui-org/select";
import { updateUser } from "@/utils/updateUser";
import { useRouter } from "next/navigation";
import { createUser } from "@/utils/createUser";



const ModalCreate = ({ idEntreprise, managers, isOpen, onClose }: { idEntreprise: any, managers: any[], isOpen: boolean, onClose: () => void }) => {

    const [idManager, setIdManager] = useState('');
    const [nom, setNom] = useState('');
    const [prenom, setPrenom] = useState('');
    const [email, setEmail] = useState('');
    const [metier, setMetier] = useState('');
    const [role, setRole] = useState('');

    const [modalKey, setModalKey] = useState(Math.random());

    const router = useRouter();

    useEffect(() => {
        if (isOpen) {
            setModalKey(Math.random());
        }
    }, [isOpen]);

    const handleCreateUser = async () => {
        await createUser(idEntreprise, (idManager || null), nom, prenom, email, metier, 'light', 'Hors ligne', role);
        setIdManager('');
        setNom('');
        setPrenom('');
        setEmail('');
        setMetier('');
        setRole('');
        onClose();
        router.refresh();
    }

    return (
        <Modal key={modalKey} isOpen={isOpen} onClose={onClose} className="text-black dark:text-white">
            <ModalContent>
                {(onClose) => (
                    <>
                        <ModalHeader className="flex flex-col gap-1">Modification</ModalHeader>
                        <ModalBody>
                            <Select
                                size='sm'
                                label="Manager"
                                value={idManager}
                                onChange={(e) => setIdManager(e.target.value)}
                                defaultSelectedKeys={idManager?.toString() || ''}
                                classNames={{ listboxWrapper: 'text-black dark:text-white' }}
                            >
                                <SelectSection>
                                    {managers.map((manager) => (
                                        <SelectItem textValue={manager.prenom + ' ' + manager.nom}
                                            key={manager.idManager} value={manager.idManager}>{manager.prenom} {manager.nom}</SelectItem>
                                    ))}
                                </SelectSection>
                            </Select>
                            <Input
                                size='sm'
                                placeholder="Prénom"
                                label="Prénom"
                                value={prenom}
                                onChange={(e) => setPrenom(e.target.value)}
                            />
                            <Input
                                size='sm'
                                placeholder="Nom"
                                label="Nom"
                                value={nom}
                                onChange={(e) => setNom(e.target.value)}
                            />
                            <Input
                                size='sm'
                                placeholder="Email"
                                label="Email"
                                value={email}
                                onChange={(e) => setEmail(e.target.value)}
                            />
                            <Input
                                size='sm'
                                placeholder="Métier"
                                label="Métier"
                                value={metier}
                                onChange={(e) => setMetier(e.target.value)}
                            />
                            <Select
                                size='sm'
                                label="Role"
                                value={role}
                                onChange={(e) => setRole(e.target.value)}
                                defaultSelectedKeys={[role]}
                                classNames={{ listboxWrapper: 'text-black dark:text-white' }}
                            >
                                <SelectSection>
                                    <SelectItem key={'admin'} value="admin">Admin</SelectItem>
                                    <SelectItem key={'user'} value="user">User</SelectItem>
                                </SelectSection>
                            </Select>
                        </ModalBody>
                        <ModalFooter>
                            <Button color="danger" variant="light" onPress={onClose}>
                                Annuler
                            </Button>
                            <Button color="primary" onPress={handleCreateUser}>
                                Créer
                            </Button>
                        </ModalFooter>
                    </>
                )}
            </ModalContent>
        </Modal>
    );
};

export default ModalCreate;