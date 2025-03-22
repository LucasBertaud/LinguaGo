export const sanitize = (text: string): string => {
  return text
    .toLowerCase()
    .replace(/[.,!?;:'"’]/g, "")
    .trim();
};
