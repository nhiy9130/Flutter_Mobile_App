import { Request, Response } from 'express';
import { loginUser, refreshToken, registerUser } from './auth.service';
import { AuthenticatedRequest } from '../../middleware/authMiddleware';

export async function register(req: Request, res: Response) {
  const { email, password, name, role } = req.body;
  const result = await registerUser({ email, password, name, role });
  res.json(result);
}

export async function login(req: Request, res: Response) {
  const { email, password } = req.body;
  const result = await loginUser({ email, password });
  res.json(result);
}

export async function refresh(req: AuthenticatedRequest, res: Response) {
  if (!req.userId) {
    return res.status(401).json({ message: 'Thiếu userId' });
  }
  const result = await refreshToken(req.userId);
  res.json(result);
}

export async function logout(_req: AuthenticatedRequest, res: Response) {
  res.json({ success: true });
}

