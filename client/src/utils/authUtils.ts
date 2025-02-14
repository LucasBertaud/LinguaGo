import jwtDecode from 'jwt-decode';
import Cookies from 'js-cookie';

interface DecodedToken {
  exp: number;
  [key: string]: any;
}

export function decodeToken(token: string): DecodedToken {
  return jwtDecode<DecodedToken>(token);
}

export function isTokenExpired(token: string): boolean {
  const decoded = decodeToken(token);
  const now = Date.now() / 1000;
  return decoded.exp < now;
}

export function clearCookies() {
  Cookies.remove('access');
  Cookies.remove('refresh');
}