import { Router } from 'express';
import { authMiddleware } from '../../middleware/authMiddleware';
import { getMe, getSessions, updateMe } from './user.controller';

export const userRouter = Router();

userRouter.use(authMiddleware);
userRouter.get('/profile', getMe);
userRouter.put('/profile', updateMe);
userRouter.get('/active-sessions', getSessions);

