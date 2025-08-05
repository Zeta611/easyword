import type { Metadata } from "next";
import { Source_Code_Pro, Hahmlet } from "next/font/google";
import Image from "next/image";
import "./globals.css";
import NavBar from "@/components/NavBar";

const hahmlet = Hahmlet({
  variable: "--font-serif",
  subsets: ["latin-ext"],
});

const sourceCodePro = Source_Code_Pro({
  variable: "--font-mono",
  subsets: ["latin"],
});

export const metadata: Metadata = {
  title: "쉬운 전문용어",
  description: "컴퓨터 분야 쉬운 전문용어 번역 플랫폼",
};

export default function RootLayout({
  children,
}: Readonly<{
  children: React.ReactNode;
}>) {
  return (
    <html lang="ko">
      <body
        className={`${hahmlet.variable} ${sourceCodePro.variable} !bg-background h-screen w-screen px-4 font-serif antialiased sm:px-6 lg:px-8`}
      >
        <NavBar />
        <main className="my-3 overflow-auto">{children}</main>
        <footer className="flex items-center justify-center gap-1 py-2">
          <a
            className="flex items-center gap-2 hover:underline hover:underline-offset-4"
            href="https://kiise.or.kr"
            target="_blank"
            rel="noopener noreferrer"
          >
            <Image
              aria-hidden
              src="/kiise.png"
              alt="KIISE logo"
              width={122}
              height={25}
            />
            한국정보과학회 쉬운전문용어 제정위원회 지원을 받았습니다.
          </a>
        </footer>
      </body>
    </html>
  );
}
