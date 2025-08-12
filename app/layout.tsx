import type { Metadata } from "next";
import { Source_Code_Pro, IBM_Plex_Sans_KR } from "next/font/google";
import Image from "next/image";
import { SpeedInsights } from "@vercel/speed-insights/next";
import { Analytics } from "@vercel/analytics/next";
import { ReactQueryDevtools } from "@tanstack/react-query-devtools";
import NavBar from "@/components/navigation/NavBar";
import { SearchDialogProvider } from "@/components/dialogs/SearchDialogProvider";
import QueryProvider from "@/app/_providers/QueryProvider";
import { LoginDialogProvider } from "@/components/auth/LoginDialogProvider";
import "@/app/globals.css";

const ibmPlexSansKR = IBM_Plex_Sans_KR({
  weight: ["400", "500", "600", "700"],
  subsets: ["latin"],
  display: "swap",
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
        className={`${ibmPlexSansKR.className} ${sourceCodePro.variable} !bg-background font-sans antialiased`}
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
                    <p className="text-muted-foreground line-clamp-1 text-[10px] sm:text-sm">
                      한국정보과학회 쉬운전문용어 제정위원회 지원을 받았습니다
                    </p>
                  </a>
                </footer>
              </div>
            </LoginDialogProvider>
          </SearchDialogProvider>
          <ReactQueryDevtools initialIsOpen={false} />
        </QueryProvider>
        <SpeedInsights />
        <Analytics />
      </body>
    </html>
  );
}
