import { Response } from 'express';
import { AuthenticatedRequest } from '../../middleware/authMiddleware';
import {
  enrollCourse,
  getCourse,
  getCourseSections,
  getEnrolledCourses,
  listCourses,
  unenrollCourse,
} from './course.service';

export async function getAllCourses(_req: AuthenticatedRequest, res: Response) {
  const data = await listCourses();
  res.json(data);
}

export async function getMyCourses(req: AuthenticatedRequest, res: Response) {
  const data = await getEnrolledCourses(req.userId!);
  res.json(data);
}

export async function getCourseById(req: AuthenticatedRequest, res: Response) {
  const course = await getCourse(req.params.courseId);
  res.json(course);
}

export async function getSections(req: AuthenticatedRequest, res: Response) {
  const sections = await getCourseSections(req.params.courseId);
  res.json(sections);
}

export async function enroll(req: AuthenticatedRequest, res: Response) {
  const result = await enrollCourse(req.userId!, req.params.courseId);
  res.json(result);
}

export async function unenroll(req: AuthenticatedRequest, res: Response) {
  const result = await unenrollCourse(req.userId!, req.params.courseId);
  res.json(result);
}

