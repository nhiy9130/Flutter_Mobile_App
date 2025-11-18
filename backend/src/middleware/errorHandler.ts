import { NextFunction, Request, Response } from 'express';

// eslint-disable-next-line @typescript-eslint/no-explicit-any
export function errorHandler(err: any, _req: Request, res: Response, _next: NextFunction) {
  console.error('[API ERROR]', err);
  if (res.headersSent) {
    return;
  }

  const status = err.status ?? 500;
  const message = err.message ?? 'Lỗi hệ thống';

  res.status(status).json({ message });
}

