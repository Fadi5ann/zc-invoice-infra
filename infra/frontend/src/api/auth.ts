import { ResponseSigninDto, ResponseSignupDto, SigninPayload, SignupPayload } from '@/types';
import axios from './axios';

const signIn = async (payload: SigninPayload): Promise<ResponseSigninDto> => {
  const response = await axios.post<ResponseSigninDto>('/auth/sign-in', payload);  // Remove public
  return response.data;
};

const signUp = async (payload: SignupPayload): Promise<ResponseSignupDto> => {
  const response = await axios.post('auth/register', payload);  // /register or /sign-up?
  return response.data;
};

const resetPassword = async (token: string, password: string): Promise<{ message: string }> => {
  const response = await axios.post<{ message: string }>(`/auth/register/${token}`, { // add /register
    password
  });
  return response.data;
};

export const auth = {
  signIn,
  signUp,
  resetPassword
};
