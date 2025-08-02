"use client";

import { cn } from "@/lib/utils";
import Link from "next/link";
import { useState, useEffect } from "react";

export default function Nav() {
  const [isVisible, setIsVisible] = useState(true);
  const [lastScrollY, setLastScrollY] = useState(0);

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
            <span className="rounded-sm bg-black px-3 py-2 text-xl font-medium text-white transition-all ease-in-out hover:rounded-3xl hover:text-lg">
              쉬운 전문용어
            </span>
            <span className={cn("text-xs font-bold duration-300 transition-colors", isVisible ? "text-gray-900" : "text-transparent")}>
              컴퓨터과학/컴퓨터공학
            </span>
          </div>
        </Link>
      </div >
    </nav >
  );
}
