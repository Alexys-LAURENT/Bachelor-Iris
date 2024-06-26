import type { Metadata } from "next";
import { Inter } from "next/font/google";
import "./globals.css";
import SideBar from "@/components/SideBar";
import { IFrameProvider } from "@/context/IFrameContext";
import { getUserTheme } from "@/utils/getUserTheme";
import { NextUIProvider } from "@nextui-org/system";
import { getUser } from "@/utils/getUser";

const inter = Inter({ subsets: ["latin"] });

export const metadata: Metadata = {
  title: "Create Next App",
  description: "Generated by create next app",
};


export default async function RootLayout({
  children,
}: Readonly<{
  children: React.ReactNode;
}>) {

  const userTheme = await getUserTheme();
  const user = await getUser() as any[] || [];

  return (
    <html lang="en" className={`${userTheme}`}>
      <IFrameProvider>
        <body className={`h-[100svh] w-screen flex flex-col-reverse md:flex-row ${inter.className}`}>
          <NextUIProvider className="w-full h-full flex flex-col-reverse md:flex-row">
            <SideBar userTheme={userTheme} user={user[0]} />
            {children}
          </NextUIProvider>
        </body>
      </IFrameProvider>
    </html>
  );
}
