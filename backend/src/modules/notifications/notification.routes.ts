import { Router } from 'express';
import { authMiddleware } from '../../middleware/authMiddleware';
import { listNotifications, unreadCount } from './notification.controller';

export const notificationRouter = Router();

notificationRouter.use(authMiddleware);
notificationRouter.get('/my-notifications', listNotifications);
notificationRouter.get('/unread-count', unreadCount);

