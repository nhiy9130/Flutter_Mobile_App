import { firestore } from '../../config/firebase';

const notificationsCollection = firestore.collection('notifications');

export async function getMyNotifications(userId: string) {
  const snapshot = await notificationsCollection.where('userId', '==', userId).get();
  if (snapshot.empty) {
    return [];
  }

  return snapshot.docs.map((doc) => ({ id: doc.id, ...doc.data() }));
}

export async function getUnreadCount(userId: string) {
  const snapshot = await notificationsCollection
    .where('userId', '==', userId)
    .where('read', '==', false)
    .get();
  return snapshot.size;
}

