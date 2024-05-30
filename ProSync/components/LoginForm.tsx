import { verifConn } from '@/utils/verifConn';
import React, { useState } from 'react';
import { cookies } from 'next/headers';

const LoginForm = () => {
    const [email, setEmail] = useState('');
    const [password, setPassword] = useState('');

    const handleVerifConn = async (e: React.FormEvent) => {
        e.preventDefault();
        try {
            const token = await verifConn(email, password);
            if (token) {
                localStorage.setItem('token', JSON.stringify(token));
                document.cookie = `token=${JSON.stringify(token)}`;
            }
        } catch (error) {
            console.error('Error verifying connection:', error);
        }

        window.location.reload();
    }

    return (
        <div className='w-full h-full flex justify-center items-center'>
            <form className='bg-white w-full h-full flex flex-col gap-4 justify-center items-center p-4' onSubmit={handleVerifConn}>
                <input type='text' id='email' name='email' placeholder='Email' className='w-full max-w-xl h-10 border-2 border-gray-300 rounded-md pl-2 text-black' value={email} onChange={(e) => setEmail(e.target.value)} />
                <input type='password' id='mdp' name='mdp' placeholder='Password' className='w-full max-w-xl h-10 border-2 border-gray-300 rounded-md pl-2 text-black' value={password} onChange={(e) => setPassword(e.target.value)} />
                <button type='submit' className='w-full max-w-xl h-10 bg-blue-500 text-white rounded-md'>Connexion</button>
            </form>
        </div>
    );
};

export default LoginForm;
