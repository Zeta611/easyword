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
            <CardTitle className="text-2xl">
              죄송합니다, 문제가 발생했어요
            </CardTitle>
          </CardHeader>
          <CardContent>
            {params?.error ? (
              <p className="text-muted-foreground text-sm">
                에러 코드: {params.error}
              </p>
            ) : (
              <p className="text-muted-foreground text-sm">
                알 수 없는 에러가 발생했어요
              </p>
            )}
          </CardContent>
        </Card>
      </div>
    </div>
  );
}
