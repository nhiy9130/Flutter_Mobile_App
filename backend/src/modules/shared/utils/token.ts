import jwt from 'jsonwebtoken';

const DEFAULT_EXPIRATION = '2h';

export function createAccessToken(payload: Record<string, unknown>, expiresIn = DEFAULT_EXPIRATION): string {
  if (!process.env.JWT_SECRET) {
    throw new Error('Thiếu JWT_SECRET trong file .env');
  }
  return jwt.sign(payload, process.env.JWT_SECRET, { expiresIn });
}

export function verifyAccessToken<T>(token: string): T {
  if (!process.env.JWT_SECRET) {
    throw new Error('Thiếu JWT_SECRET trong file .env');
  }
  return jwt.verify(token, process.env.JWT_SECRET) as T;
}

