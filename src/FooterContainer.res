@react.component
let make = (~children: React.element) => {
  <div className="flex flex-col min-h-screen">
    <div className="flex-grow"> children </div>
    <footer className="footer bg-base-300 text-base-content p-4 gap-1 items-center">
      <a href="https://kiise.or.kr" target="_blank" rel="noreferrer noopener">
        <img className="object-contain h-10" src="/kiise.png" alt="KIISE" />
      </a>
      <p className="align-middle">
        {"한국정보과학회 쉬운전문용어 제정위원회 지원을 받았습니다."->React.string}
      </p>
    </footer>
  </div>
}
