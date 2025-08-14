export const metadata = {
  title: "쉬운 번역팁 | 쉬운 전문용어",
  description: "쉬운 전문용어 프로젝트의 번역 팁을 소개합니다.",
};

export default function TipsPage() {
  return (
    <div className="mx-auto flex w-full max-w-3xl flex-col gap-6">
      <header className="flex flex-col gap-1">
        <h1 className="text-3xl font-bold">쉬운 번역팁</h1>
      </header>

      <section className="flex flex-col gap-3">
        <ul className="list-disc pl-6 leading-7">
          <li>
            <strong>non-XX</strong>: {"'비XX'"} 대신에 간혹 {"'XX 외'"}가 좋을
            때도 있음 (예: non-functional NN ⇒ 비기능NN (X), 기능외NN (O))
          </li>
          <li>
            <strong>engineering</strong>: 학문으로서 공학이 아니라면 분석, 파악,
            방법 (예: reverse engineering ⇒ 거꾸로 분석하기)
          </li>
          <li>
            <strong>integrated</strong>: 통합도 괜찮지만 가끔 종합이 어울릴 때도
            (예: IDE ⇒ 종합개발환경, {"'종합선물세트'"}에서)
          </li>
          <li>
            <strong>XX-guided-YY</strong>: XX로 배우는 YY (예:
            counter-example-guided ⇒ 반례로 배우는 …)
          </li>
          <li>
            <strong>logic</strong>: 논리가 아니라 절차를 이야기할 때도 있음 (예:
            business logic ⇒ 업무처리절차)
          </li>
          <li>
            말을 만들수도 있음 (예: iff ⇒ 이면이, FIFO/LIFO ⇒ 먼저먼저/나중먼저,
            coverage ⇒ 덮이 ({"'깊이'"}, {"'넓이'"} 같이))
          </li>
          <li>
            우리말에 풍부한 의성/의태어를 활용할 수 있음 (예: curried function ⇒
            야금야금 함수)
          </li>
          <li>전문용어는 띄어쓰기 안해도 좋음 (국립국어원)</li>
        </ul>
      </section>
    </div>
  );
}
