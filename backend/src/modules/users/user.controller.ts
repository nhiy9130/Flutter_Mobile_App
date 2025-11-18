import { Response } from 'express';
import { AuthenticatedRequest } from '../../middleware/authMiddleware';
import { getActiveSessions, getProfile, updateProfile } from './user.service';

export async function getMe(req: AuthenticatedRequest, res: Response) {
  const user = await getProfile(req.userId!);
  res.json(user);
}

export async function updateMe(req: AuthenticatedRequest, res: Response) {
  const user = await updateProfile(req.userId!, req.body);
  res.json(user);
}

export async function getSessions(req: AuthenticatedRequest, res: Response) {
  const sessions = await getActiveSessions(req.userId!);
  res.json(sessions);
}

