export type UserRole = 'ADMIN' | 'TEACHER' | 'STUDENT';

export interface UserProfile {
  id: string;
  email: string;
  name: string;
  role: UserRole;
  avatarUrl?: string;
  createdAt: string;
  updatedAt: string;
}

