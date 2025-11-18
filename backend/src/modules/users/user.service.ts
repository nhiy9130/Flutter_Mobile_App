import { firestore } from '../../config/firebase';
import { UserProfile } from '../shared/types/user';

const usersCollection = firestore.collection('users');

export async function getProfile(userId: string): Promise<UserProfile> {
  const doc = await usersCollection.doc(userId).get();
  if (!doc.exists) {
    throw { status: 404, message: 'Không tìm thấy người dùng' };
  }
  const data = doc.data()!;
  return {
    id: doc.id,
    email: data.email,
    name: data.name,
    role: data.role,
    avatarUrl: data.avatarUrl,
    createdAt: data.createdAt,
    updatedAt: data.updatedAt,
  };
}

export async function updateProfile(userId: string, payload: Partial<UserProfile>) {
  const now = new Date().toISOString();
  await usersCollection.doc(userId).update({
    ...payload,
    updatedAt: now,
  });
  return getProfile(userId);
}

export async function getActiveSessions(_userId: string) {
  return [
    {
      id: 'current',
      device: 'Web Browser',
      lastActive: new Date().toISOString(),
      current: true,
    },
  ];
}

