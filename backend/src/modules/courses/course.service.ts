import { firestore } from '../../config/firebase';

const coursesCollection = firestore.collection('courses');
const sectionsCollection = firestore.collection('sections');
const lessonsCollection = firestore.collection('lessons');
const enrollmentsCollection = firestore.collection('enrollments');

export async function listCourses() {
  const snapshot = await coursesCollection.get();
  return snapshot.docs.map((doc) => ({ id: doc.id, ...doc.data() }));
}

export async function getCourse(courseId: string) {
  const doc = await coursesCollection.doc(courseId).get();
  if (!doc.exists) {
    throw { status: 404, message: 'Không tìm thấy khóa học' };
  }
  return { id: doc.id, ...doc.data() };
}

export async function getEnrolledCourses(userId: string) {
  const enrollmentSnapshot = await enrollmentsCollection.where('userId', '==', userId).get();
  const courseIds = enrollmentSnapshot.docs.map((d) => d.data().courseId);
  if (!courseIds.length) return [];
  const courses = await coursesCollection.where(firestore.FieldPath.documentId(), 'in', courseIds).get();
  return courses.docs.map((doc) => ({ id: doc.id, ...doc.data() }));
}

export async function enrollCourse(userId: string, courseId: string) {
  await enrollmentsCollection.add({
    userId,
    courseId,
    createdAt: new Date().toISOString(),
  });
  return { success: true };
}

export async function unenrollCourse(userId: string, courseId: string) {
  const snapshot = await enrollmentsCollection
    .where('userId', '==', userId)
    .where('courseId', '==', courseId)
    .limit(1)
    .get();
  if (!snapshot.empty) {
    await snapshot.docs[0].ref.delete();
  }
  return { success: true };
}

export async function getCourseSections(courseId: string) {
  const sections = await sectionsCollection.where('courseId', '==', courseId).get();
  const result = [];
  for (const section of sections.docs) {
    const lessons = await lessonsCollection.where('sectionId', '==', section.id).get();
    result.push({
      id: section.id,
      ...section.data(),
      lessons: lessons.docs.map((doc) => ({ id: doc.id, ...doc.data() })),
    });
  }
  return result;
}

