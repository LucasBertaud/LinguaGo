export const validateEmail = (email: string): boolean => {
    const re = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
    return re.test(email);
};

export const validatePasswordLength = (password: string, minLength = 10): boolean => {
    return password.length >= minLength;
};

export function validatePasswordComplexity(password: string): boolean {
    // Vérification de la présence d'une majuscule, d'un chiffre et d'un caractère spécial
    const regex = /^(?=.*[A-Z])(?=.*\d)(?=.*[!@#$%^&*(),.?":{}|<>]).{10,}$/;
    return regex.test(password);
}