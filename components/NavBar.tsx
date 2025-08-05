"use client";

import Link from "next/link";
import { useState, useEffect } from "react";
import NavBarAvatar from "./NavBarAvatar";
import { cn } from "@/lib/utils";

export default function NavBar() {
  const [isVisible, setIsVisible] = useState(true);
  const [lastScrollY, setLastScrollY] = useState(0);

  // Hide "컴퓨터과학/컴퓨터공학" when scrolling down
  useEffect(() => {
    const handleScroll = () => {
      const currentScrollY = window.scrollY;

      if (currentScrollY > lastScrollY && currentScrollY > 50) {
        setIsVisible(false);
      } else if (currentScrollY < lastScrollY) {
        setIsVisible(true);
      }

      setLastScrollY(currentScrollY);
    };

    window.addEventListener("scroll", handleScroll, { passive: true });

    return () => {
      window.removeEventListener("scroll", handleScroll);
    };
  }, [lastScrollY]);

  return (
    <nav className="sticky top-0 z-50">
      <div className="flex h-24 items-center justify-between">
        <Link href="/">
          <div className="flex flex-col items-center gap-1">
            <span className="rounded-sm bg-black px-3 py-2 text-xl font-black text-white transition-all ease-in-out hover:rounded-3xl hover:text-lg">
              쉬운 전문용어
            </span>
            <span
              className={cn(
                "text-sm font-bold transition-colors duration-300",
                isVisible ? "text-gray-900" : "text-transparent",
              )}
            >
              컴퓨터과학/컴퓨터공학
            </span>
          </div>
        </Link>
        <div className="flex items-center gap-2"></div>
        <div className="flex items-center gap-2">
          <NavBarAvatar />
        </div>
      </div>
    </nav>
  );
}
