import { Router } from 'express';
import { authMiddleware } from '../../middleware/authMiddleware';
import {
  enroll,
  getAllCourses,
  getCourseById,
  getMyCourses,
  getSections,
  unenroll,
} from './course.controller';

export const courseRouter = Router();

courseRouter.use(authMiddleware);
courseRouter.get('/', getAllCourses);
courseRouter.get('/enrolled', getMyCourses);
courseRouter.get('/:courseId', getCourseById);
courseRouter.get('/:courseId/sections', getSections);
courseRouter.post('/:courseId/enroll', enroll);
courseRouter.post('/:courseId/unenroll', unenroll);

