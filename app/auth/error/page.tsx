import { Card, CardContent, CardHeader, CardTitle } from "@/components/ui/card";

export default async function Page({
  searchParams,
}: {
  searchParams: Promise<{ error: string }>;
}) {
  const params = await searchParams;

  return (
    <div className="flex w-full items-center justify-center p-6 md:p-10">
      <div className="w-full max-w-sm">
        <Card>
          <CardHeader>
            <CardTitle className="text-xl">로그인에 문제가 있었어요</CardTitle>
          </CardHeader>
          {params.error && (
            <CardContent>
              <p className="text-muted-foreground text-sm">
                에러 코드: {params.error}
              </p>
            </CardContent>
          )}
        </Card>
      </div>
    </div>
  );
}
