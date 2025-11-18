import { NextFunction, Request, Response } from 'express';
import { verifyAccessToken } from '../modules/shared/utils/token';
import { UserRole } from '../modules/shared/types/user';

export interface AuthenticatedRequest extends Request {
  userId?: string;
  role?: UserRole;
}

export function authMiddleware(req: AuthenticatedRequest, res: Response, next: NextFunction) {
  const header = req.headers.authorization;
  if (!header) {
    return res.status(401).json({ message: 'Thiếu token' });
  }

  const token = header.replace('Bearer ', '');

  try {
    const payload = verifyAccessToken<{ sub: string; role: UserRole }>(token);
    req.userId = payload.sub;
    req.role = payload.role;
    next();
  } catch (error) {
    return res.status(401).json({ message: 'Token không hợp lệ' });
  }
}

