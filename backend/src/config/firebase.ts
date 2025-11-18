import admin from 'firebase-admin';
import { config } from 'dotenv';

config();

const privateKey = process.env.FIREBASE_PRIVATE_KEY?.replace(/\\n/g, '\n');

if (!process.env.FIREBASE_PROJECT_ID || !process.env.FIREBASE_CLIENT_EMAIL || !privateKey) {
  throw new Error('Thiếu thông tin FIREBASE_* trong file .env');
}

if (!admin.apps.length) {
  admin.initializeApp({
    credential: admin.credential.cert({
      projectId: process.env.FIREBASE_PROJECT_ID,
      clientEmail: process.env.FIREBASE_CLIENT_EMAIL,
      privateKey,
    }),
    databaseURL: process.env.FIREBASE_DATABASE_URL,
  });
}

export const firestore = admin.firestore();
export const auth = admin.auth();

