import { firestore } from '../../config/firebase';
import { hashPassword, verifyPassword } from '../shared/utils/password';
import { createAccessToken } from '../shared/utils/token';
import { UserProfile, UserRole } from '../shared/types/user';

interface RegisterPayload {
  email: string;
  password: string;
  name: string;
  role?: UserRole;
}

interface LoginPayload {
  email: string;
  password: string;
}

const usersCollection = firestore.collection('users');

export async function registerUser(payload: RegisterPayload) {
  const existing = await usersCollection.where('email', '==', payload.email).limit(1).get();
  if (!existing.empty) {
    throw { status: 400, message: 'Email đã tồn tại' };
  }

  const now = new Date().toISOString();
  const docRef = await usersCollection.add({
    email: payload.email,
    name: payload.name,
    role: payload.role ?? 'STUDENT',
    passwordHash: await hashPassword(payload.password),
    createdAt: now,
    updatedAt: now,
  });

  const token = createAccessToken({ sub: docRef.id, role: payload.role ?? 'STUDENT' });

  return { token, user: mapUser(docRef.id, payload.name, payload.email, payload.role ?? 'STUDENT', now, now) };
}

export async function loginUser(payload: LoginPayload) {
  const snapshot = await usersCollection.where('email', '==', payload.email).limit(1).get();
  if (snapshot.empty) {
    throw { status: 401, message: 'Sai email hoặc mật khẩu' };
  }

  const doc = snapshot.docs[0];
  const data = doc.data();

  const isValid = await verifyPassword(payload.password, data.passwordHash);
  if (!isValid) {
    throw { status: 401, message: 'Sai email hoặc mật khẩu' };
  }

  const token = createAccessToken({ sub: doc.id, role: data.role });

  return {
    token,
    user: mapUser(doc.id, data.name, data.email, data.role, data.createdAt, data.updatedAt),
  };
}

export async function refreshToken(userId: string) {
  const userDoc = await usersCollection.doc(userId).get();
  if (!userDoc.exists) {
    throw { status: 404, message: 'Không tìm thấy người dùng' };
  }

  const data = userDoc.data()!;
  const token = createAccessToken({ sub: userDoc.id, role: data.role });

  return {
    token,
    user: mapUser(userDoc.id, data.name, data.email, data.role, data.createdAt, data.updatedAt),
  };
}

function mapUser(id: string, name: string, email: string, role: UserRole, createdAt: string, updatedAt: string): UserProfile {
  return { id, name, email, role, createdAt, updatedAt };
}

