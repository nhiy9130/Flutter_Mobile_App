import { Request, Response } from 'express';
import { getAdminSettings } from './admin.service';

export async function getSettings(_req: Request, res: Response) {
  const settings = await getAdminSettings();
  res.json(settings);
}

