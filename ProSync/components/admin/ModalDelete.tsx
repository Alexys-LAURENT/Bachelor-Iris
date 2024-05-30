"use client"
import { Button } from "@nextui-org/button";
import { Modal, ModalContent, ModalHeader, ModalBody, ModalFooter } from "@nextui-org/modal";
import { Input } from "@nextui-org/input";
import { useEffect, useState } from "react";
import { Select, SelectSection, SelectItem } from "@nextui-org/select";
import { updateUser } from "@/utils/updateUser";
import { useRouter } from "next/navigation";
import { deleteUser } from "@/utils/deleteUser";



const ModalDelete = ({ idUser, isOpen, onClose }: { idUser: any, isOpen: boolean, onClose: () => void }) => {

    const [modalKey, setModalKey] = useState(Math.random());

    const router = useRouter();

    useEffect(() => {
        if (isOpen) {
            setModalKey(Math.random());
        }
    }, [isOpen]);

    const handleDeleteUser = async () => {
        await deleteUser(idUser);
        onClose();
        router.refresh();
    }

    return (
        <Modal key={modalKey} isOpen={isOpen} onClose={onClose} size="lg" className="text-black dark:text-white">
            <ModalContent>
                {(onClose) => (
                    <>
                        <ModalHeader className="flex flex-col gap-1">Suppression</ModalHeader>
                        <ModalBody>
                            <p className="text-lg">Etes-vous sûr de vouloir supprimer cet utilisateur ?</p>
                            <p className="text-xs text-red-500">Attention, cette action est irréversible.</p>
                        </ModalBody>
                        <ModalFooter>
                            <Button color="danger" variant="light" onPress={onClose}>
                                Annuler
                            </Button>
                            <Button color="primary" onPress={handleDeleteUser}>
                                Supprimer
                            </Button>
                        </ModalFooter>
                    </>
                )}
            </ModalContent>
        </Modal>
    );
};

export default ModalDelete;