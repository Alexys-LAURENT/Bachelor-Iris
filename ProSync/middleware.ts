// middleware.js
import { NextResponse } from 'next/server';

export function middleware(req: any) {
    const token = req.cookies.get('token');
    if (!token || token.value === '') {
        req.nextUrl.searchParams.set('token', '');
    }
    req.nextUrl.searchParams.set('token', token);



    if (req.nextUrl.pathname === '/admin' && token.value === '') {
        return NextResponse.redirect(new URL('/', req.url));
    }

    return NextResponse.next();
}
