import { commonErrorMessages } from './commonErrors';

export const errorMessages = {
  ...commonErrorMessages,
  invalidPseudo: 'Le pseudo est requis.',
  registerFailed: 'L\'inscription a échoué. Veuillez réessayer.',
  emailTaken: 'Un utilisateur avec cet email existe déjà.',
};