import bcrypt from 'bcryptjs';

const SALT_ROUNDS = 10;

export async function hashPassword(rawPassword: string): Promise<string> {
  return bcrypt.hash(rawPassword, SALT_ROUNDS);
}

export async function verifyPassword(rawPassword: string, hashed: string): Promise<boolean> {
  return bcrypt.compare(rawPassword, hashed);
}

