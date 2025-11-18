import express from 'express';
import cors from 'cors';
import { config } from 'dotenv';
import { authRouter } from './modules/auth/auth.routes';
import { userRouter } from './modules/users/user.routes';
import { courseRouter } from './modules/courses/course.routes';
import { adminRouter } from './modules/admin/admin.routes';
import { notificationRouter } from './modules/notifications/notification.routes';
import { errorHandler } from './middleware/errorHandler';

config();

const app = express();

app.use(cors());
app.use(express.json());

app.get('/health', (_req, res) => {
  res.json({ status: 'ok' });
});

app.use('/api/v1/auth', authRouter);
app.use('/api/v1/users', userRouter);
app.use('/api/v1/courses', courseRouter);
app.use('/api/v1/admin', adminRouter);
app.use('/api/v1/notifications', notificationRouter);

app.use(errorHandler);

const port = process.env.PORT ?? 3000;
app.listen(port, () => {
  console.log(`✅ Backend chạy tại http://localhost:${port}`);
});

