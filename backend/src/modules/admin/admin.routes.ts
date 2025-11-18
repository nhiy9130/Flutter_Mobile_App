import { Router } from 'express';
import { getSettings } from './admin.controller';

export const adminRouter = Router();

adminRouter.get('/settings', getSettings);

