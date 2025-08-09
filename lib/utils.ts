import { clsx, type ClassValue } from "clsx";
import { twMerge } from "tailwind-merge";

export function cn(...inputs: ClassValue[]) {
  return twMerge(clsx(inputs));
}

function getCode(c: string) {
  return c.charCodeAt(0);
}

function endsWithJong(korean: string) {
  const c = korean.charAt(korean.length - 1);
  if ("가" <= c && c <= "힣") {
    return (getCode(c) - getCode("가")) % 28 > 0;
  } else {
    return false;
  }
}

export function eulLeul(korean: string) {
  return korean + (endsWithJong(korean) ? "을" : "를");
}
