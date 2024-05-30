"use client"

import LoginForm from "@/components/LoginForm";
import { IFrameContext } from "@/context/IFrameContext";
import { useContext, useEffect } from "react";

const Page = () => {
  const { url, token, loading } = useContext(IFrameContext);

  if (loading) {
    return (
      <div className='w-full h-full flex justify-center items-center bg-white dark:bg-[#0d1117]'>
        <h1 className='text-2xl text-black'>
          <svg className="animate-spin h-12 w-12 text-black dark:text-white" xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24">
            <circle className="opacity-25" cx="12" cy="12" r="10" stroke="currentColor" strokeWidth="4"></circle>
            <path className="opacity-75" fill="currentColor" d="M4 12a8 8 0 018-8V0C5.373 0 0 5.373 0 12h4zm2 5.291A7.962 7.962 0 014 12H0c0 3.042 1.135 5.824 3 7.938l3-2.647z"></path>
          </svg>
        </h1>
      </div>
    );
  }

  return (
    <div className='w-full h-full bg-white'>
      {url && token.token !== '' && token.expireAt > new Date().toISOString() ?
        <iframe id="iframe" allow="keyboard-map" className='w-full h-full' src={url} frameBorder="0"></iframe>
        :
        token.token && token.expireAt > new Date().toISOString() && !url ?
          <div className='w-full h-full flex justify-center items-center bg-white dark:bg-[#0d1117]'>
            <h1 className='text-2xl text-black dark:text-white'>
              Veuillez sélectionner une application
            </h1>
          </div >
          :
          <LoginForm />
      }
    </div >
  );
};

export default Page;