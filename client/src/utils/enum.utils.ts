export function getEnumKeyByValue<T extends Record<string, string>>(enumObj: T, value: string): string | undefined {
    return Object.entries(enumObj).find(([_, v]) => v === value)?.[0];
}