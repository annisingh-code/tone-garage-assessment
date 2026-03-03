/**
 * Checks if a given ID is a valid number.
 * Accepts 'any' type to prevent Express TypeScript parameter errors,
 * but strictly validates that the input is a valid string number.
 */
export const isValidId = (id: any): boolean => {
  // Agar id nahi hai, ya string nahi hai (jaise array ya object aa gaya), toh false
  if (!id || typeof id !== "string") return false;

  // Ab safely check karo ki string ek number hai ya nahi
  return !isNaN(Number(id));
};
