import { Response } from 'express';
import { AuthenticatedRequest } from '../../middleware/authMiddleware';
import { getMyNotifications, getUnreadCount } from './notification.service';

export async function listNotifications(req: AuthenticatedRequest, res: Response) {
  const data = await getMyNotifications(req.userId!);
  res.json(data);
}

export async function unreadCount(req: AuthenticatedRequest, res: Response) {
  const count = await getUnreadCount(req.userId!);
  res.json({ unread: count });
}

