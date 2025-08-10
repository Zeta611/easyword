import type { Metadata } from "next";
import { Source_Code_Pro, Hahmlet } from "next/font/google";
import Image from "next/image";
import { SpeedInsights } from "@vercel/speed-insights/next";
import { Analytics } from "@vercel/analytics/next";
import NavBar from "@/components/NavBar";
import { SearchDialogProvider } from "@/components/SearchDialogProvider";
import QueryProvider from "@/app/providers";
import { LoginDialogProvider } from "@/components/LoginDialogProvider";
import "@/app/globals.css";

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
        className={`${hahmlet.variable} ${sourceCodePro.variable} !bg-background font-serif antialiased`}
      >
        <QueryProvider>
          <SearchDialogProvider>
            <LoginDialogProvider>
              <div className="flex min-h-screen w-full flex-col px-4 sm:px-6 lg:px-8">
                <NavBar />
                <main className="flex-1">{children}</main>
                <footer className="mt-4 flex h-12 items-center justify-center gap-1">
                  <a
                    className="flex items-center gap-2 hover:underline hover:underline-offset-4"
                    href="https://kiise.or.kr"
                    target="_blank"
                    rel="noopener noreferrer"
                  >
                    <Image
                      aria-hidden
                      className="w-11 sm:w-auto"
                      src="/kiise.png"
                      alt="KIISE logo"
                      width={122}
                      height={25}
                    />
                    <p className="text-[10px] text-gray-500 sm:text-sm">
                      한국정보과학회 쉬운전문용어 제정위원회 지원을 받았습니다
                    </p>
                  </a>
                </footer>
              </div>
            </LoginDialogProvider>
          </SearchDialogProvider>
        </QueryProvider>
        <SpeedInsights />
        <Analytics />
      </body>
    </html>
  );
}
