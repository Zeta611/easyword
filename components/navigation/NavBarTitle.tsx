"use client";

import Link from "next/link";
import { useState, useEffect } from "react";

export default function NavBarTitle() {
  // Hide "컴퓨터과학/컴퓨터공학" when scrolling down
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
    return () => window.removeEventListener("scroll", handleScroll);
  }, [lastScrollY]);

  return (
    <Link href="/">
      <div className="flex flex-col items-center gap-1">
        <span className="bg-primary text-primary-foreground rounded-sm px-3 py-2 text-xl font-bold transition-all ease-in-out hover:rounded-3xl hover:text-lg">
          쉬운 전문용어
        </span>
        <span
          className={`text-sm font-bold transition-colors duration-300 ${
            isVisible ? "text-foreground" : "text-transparent"
          }`}
        >
          컴퓨터과학/컴퓨터공학
        </span>
      </div>
    </Link>
  );
}
