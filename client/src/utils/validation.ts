export const validateEmail = (email: string): boolean => {
    const re = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
    return re.test(email);
};

export const validatePasswordLength = (password: string, minLength: number = 10): boolean => {
    return password.length >= minLength;
};