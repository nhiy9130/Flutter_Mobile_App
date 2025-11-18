import { firestore } from '../../config/firebase';

const settingsDoc = firestore.collection('admin_settings').doc('default');

const DEFAULT_SETTINGS = {
  maintenanceMode: false,
  supportEmail: 'support@example.com',
  welcomeMessage: 'Chào mừng đến với hệ thống LMS của bạn',
};

export async function getAdminSettings() {
  const doc = await settingsDoc.get();
  if (!doc.exists) {
    await settingsDoc.set(DEFAULT_SETTINGS);
    return { id: 'default', ...DEFAULT_SETTINGS };
  }
  return { id: doc.id, ...doc.data() };
}

