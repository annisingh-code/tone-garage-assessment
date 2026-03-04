/**
 * Checks if a given ID is a valid number.
 * Accepts 'any' type to prevent Express TypeScript parameter errors,
 * but strictly validates that the input is a valid string number.
 */
export const isValidId = (id: any): boolean => {
 
  if (!id || typeof id !== "string") return false;

 
  return !isNaN(Number(id));
};
