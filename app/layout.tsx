import type { Metadata } from "next";
import { Noto_Sans_KR } from "next/font/google";
import Image from "next/image";
import "./globals.css";
import Nav from "@/components/Nav";

const notoSans = Noto_Sans_KR({
  variable: "--font-noto-sans",
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
        className={`${notoSans.variable} !bg-background h-screen w-screen px-4 font-sans antialiased sm:px-6 lg:px-8`}
      >
        <Nav />
        <main className="overflow-auto">{children}</main>
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
