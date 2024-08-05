@react.component
let make = () => {
  <article className="px-6 py-12 max-w-xl mx-auto md:max-w-4xl prose">
    <h1> {"번역팁"->React.string} </h1>
    <ul>
      <li>
        {"non-XX : '비XX' 대신에 간혹 'XX 외'가 좋을 때도 있음 (예: non-functional 비기능(X) 기능외(O))"->React.string}
      </li>
      <li>
        {"engineering : 학문으로서 공학이 아니라면 분석, 파악, 방법 (예: reverse engineering)"->React.string}
      </li>
      <li>
        {"integrated : 통합도 괜찮지만 가끔 종합이 어울릴 때도 (예: IDE 종합개발환경, '종합선물세트'에서)"->React.string}
      </li>
      <li>
        {"XX-guided-YY : XX로 배우는 YY (예: counter-example-guided 반례로 배우는 …)"->React.string}
      </li>
      <li>
        {"logic : 논리가 아니라 절차를 이야기할 때도 있음 (예: business logic 업무처리절차)"->React.string}
      </li>
      <li> {"전문용어는 띄어쓰기 안해도 좋음 (국립국어원)"->React.string} </li>
    </ul>
  </article>
}
