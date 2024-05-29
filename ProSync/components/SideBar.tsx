"use client"
import { useContext, useState } from 'react';
import ChatSphere from '@/public/ChatSphere.png'
import CloudNest from '@/public/CloudNest.png'
import HelpDesk from '@/public/HelpDesk.png'
import NoteFlow from '@/public/NoteFlow.png'
import HarmonyWorks from '@/public/HarmonyWorks.png'
import Image from 'next/image';
import { IFrameContext } from '@/context/IFrameContext';
import { Popover, PopoverTrigger, PopoverContent } from "@nextui-org/popover";
import { Switch } from "@nextui-org/switch";
import { changeTheme } from '@/utils/changeTheme';
import Link from 'next/link';
import { useRouter } from 'next/navigation';
import ModalChangePassword from './ModalChangePassword';

const SideBar = ({ userTheme, user }: { userTheme: any, user: any }) => {
  const { setUrl, token } = useContext(IFrameContext);
  const [theme, setTheme] = useState(userTheme);

  const router = useRouter();

  const openModalChangePassword = (user && user.mustChangePassword === 1);


  const handleDisconnect = () => {
    localStorage.removeItem('token');
    document.cookie = `token=;`;
    window.location.replace('/');
  }

  const handleThemeChange = async () => {
    setTheme(theme === 'dark' ? 'light' : 'dark');

    const html = document.querySelectorAll('html');

    const iframe = document.getElementById('iframe') as HTMLIFrameElement;

    if (theme === 'dark') {
      html?.forEach((element) => {
        element.classList.remove('dark');
        element.classList.add('light');
      });
    } else {
      html?.forEach((element) => {
        element.classList.remove('light');
        element.classList.add('dark');
      });
    }

    async function changeThemeBdd() {
      await changeTheme(theme);
    }

    await changeThemeBdd();

    if (iframe)
      iframe.src = iframe.src;
  }

  return user && token && token.token !== '' && token.expireAt > new Date().toISOString() || userTheme && Object.keys(userTheme).length > 0 ? (
    <div className="dark:bg-[#171d27] bg-[#f0f0f0] flex flex-row md:flex-col justify-between w-full h-14 md:h-full md:w-14 px-2 md:px-0 py-0 md:py-4">
      <nav className='flex flex-row md:flex-col gap-10 items-center'>
        <Image
          src={HarmonyWorks.src} alt='HarmonyWorks' width={300} height={300} className='w-10 h-10' />
        <div className={`flex flex-row md:flex-col items-center gap-2 ${user.role === 'admin' ? 'divide-x md:divide-x-0 divide-y-0 md:divide-y divide-[#B8B8B8]' : ''} h-full w-full`}>
          <div className='flex flex-rox md:flex-col gap-4 overflow-auto no-scrollbar w-full h-full items-center'>
            <Image src={HelpDesk.src} alt='HelpDesk' width={300} height={300} className='w-10 h-10 cursor-pointer hover:scale-105 transition-all duration-300'
              onClick={() => { router.push('/'); setUrl(`https://helpdesk.projets-al.site/?token=${token.token}`) }} />
            <Image src={ChatSphere.src}
              onClick={() => { router.push('/'); setUrl(`https://chatsphere.projets-al.site/?token=${token.token}`) }}
              alt='ChatSphere' width={300} height={300} className='w-10 h-10 cursor-pointer hover:scale-105 transition-all duration-300' />
            <Image src={NoteFlow.src}
              onClick={() => { router.push('/'); setUrl(`https://noteflow.projets-al.site/index.jsp?token=${token.token}`) }}
              alt='NoteFlow' width={300} height={300} className='w-10 h-10 cursor-pointer hover:scale-105 transition-all duration-300' />
            <Image src={CloudNest.src}
              onClick={() => { router.push('/'); setUrl(`https://cloudnestapp.bubbleapps.io/version-test?token=${token.token}`) }}
              alt='CloudNest' width={300} height={300} className='w-10 h-10 cursor-pointer hover:scale-105 transition-all duration-300' />
          </div>
          {user.role === 'admin' && (
            <div className="pt-0 md:pt-2 pl-2 md:pl-0">
              <Link href='/admin'>
                <button className='w-10 h-10 cursor-pointer hover:scale-105 transition-all duration-300 bg-black rounded-md p-1'>
                  <svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" strokeWidth={1.5} stroke="currentColor" className="">
                    <path strokeLinecap="round" strokeLinejoin="round" d="M16.5 10.5V6.75a4.5 4.5 0 1 0-9 0v3.75m-.75 11.25h10.5a2.25 2.25 0 0 0 2.25-2.25v-6.75a2.25 2.25 0 0 0-2.25-2.25H6.75a2.25 2.25 0 0 0-2.25 2.25v6.75a2.25 2.25 0 0 0 2.25 2.25Z" />
                  </svg>
                </button>
              </Link>
            </div>
          )}
        </div>

      </nav>

      <div className='flex flex-row md:flex-col gap-10 items-center'>
        <Popover placement="top">
          <PopoverTrigger>
            <svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" strokeWidth={1.5} stroke="currentColor" className='w-10 h-10 cursor-pointer hover:scale-105 transition-all duration-300 text-black dark:text-white'>
              <path strokeLinecap="round" strokeLinejoin="round" d="M15.75 6a3.75 3.75 0 1 1-7.5 0 3.75 3.75 0 0 1 7.5 0ZM4.501 20.118a7.5 7.5 0 0 1 14.998 0A17.933 17.933 0 0 1 12 21.75c-2.676 0-5.216-.584-7.499-1.632Z" />
            </svg>
          </PopoverTrigger>
          <PopoverContent className='min-w-[200px]'>
            <div className='flex flex-col gap-2 p-2 w-full'>
              <div className="flex justify-between items-center">
                <span className='text-black dark:text-white'>Mode sombre</span>
                <Switch classNames={{ wrapper: 'mr-0' }} isSelected={theme === 'dark'} onChange={() => { handleThemeChange() }} />
              </div>
              <button onClick={handleDisconnect} className='w-full bg-red-500 text-white rounded-md p-2'>Déconnexion</button>
            </div>
          </PopoverContent>
        </Popover>
      </div>

      <ModalChangePassword idUser={user.idUser} isOpen={openModalChangePassword} />
    </div>
  ) : (
    null
  );
};

export default SideBar;