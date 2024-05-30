"use client"
import { Button } from "@nextui-org/button";
import { Modal, ModalContent, ModalHeader, ModalBody, ModalFooter } from "@nextui-org/modal";
import { Input } from "@nextui-org/input";
import { useEffect, useState } from "react";
import { Select, SelectSection, SelectItem } from "@nextui-org/select";
import { updateUser } from "@/utils/updateUser";
import { useRouter } from "next/navigation";
import { deleteUser } from "@/utils/deleteUser";
import { updatePassword } from "@/utils/updatePassword";



const ModalChangePassword = ({ idUser, isOpen }: { idUser: any, isOpen: boolean }) => {

    const [modalKey, setModalKey] = useState(Math.random());

    const [password, setPassword] = useState('');

    const router = useRouter();

    useEffect(() => {
        if (isOpen) {
            setModalKey(Math.random());
        }
    }, [isOpen]);

    const handleChangePassword = async () => {
        if (password.length < 8) {
            return alert('Le mot de passe doit contenir au moins 8 caractères');
        }
        await updatePassword(idUser, password);
        localStorage.removeItem('token');
        document.cookie = `token=;`;
        router.refresh();
    }

    return (
        <Modal hideCloseButton isDismissable={false} key={modalKey} isOpen={isOpen} size="lg" className="text-black dark:text-white">
            <ModalContent>
                {(onClose) => (
                    <>
                        <ModalHeader className="flex flex-col gap-1">Modifier votre mot de passe</ModalHeader>
                        <ModalBody>
                            <Input type="password" label="Nouveau mot de passe" value={password} onChange={(e) => setPassword(e.target.value)} />
                        </ModalBody>
                        <ModalFooter>
                            <Button color="primary" onPress={handleChangePassword}>
                                Modifier
                            </Button>
                        </ModalFooter>
                    </>
                )}
            </ModalContent>
        </Modal>
    );
};

export default ModalChangePassword;