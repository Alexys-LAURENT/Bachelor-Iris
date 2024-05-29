"use client"
import React, { createContext, useState, useEffect } from 'react';
import { cookies } from 'next/headers';

interface Token {
  token: string;
  expireAt: string;
}

interface IFrameContextType {
  url: string;
  setUrl: (url: string) => void;
  token: Token;
  setToken: (token: Token) => void;
  loading: boolean;
}

export const IFrameContext = createContext<IFrameContextType>({
  url: '',
  setUrl: () => { },
  token: { token: '', expireAt: '' },
  setToken: () => { },
  loading: true,
});

export const IFrameProvider = ({ children }: { children: React.ReactNode }) => {
  const [url, setUrl] = useState('');
  const [token, setToken] = useState<Token>({ token: '', expireAt: '' });
  const [loading, setLoading] = useState(true);

  useEffect(() => {
    const localToken = localStorage.getItem('token');
    if (localToken) {
      const parsedToken = JSON.parse(localToken);
      setToken(parsedToken);
    }
    setLoading(false);
  }, []);

  return (
    <IFrameContext.Provider value={{ url, setUrl, token, setToken, loading }}>
      {children}
    </IFrameContext.Provider>
  );
};
