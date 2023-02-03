@react.component
let make = () => {
  <div className="overflow-x-auto">
    <table className="table w-full">
      <tbody>
        <tr className="active">
          <th className="w-10">
            <label>
              <input type_="radio" name="radio" className="radio radio-primary" />
            </label>
          </th>
          <td>
            {"시험 단어"->React.string}
            <br />
            <progress className="progress progress-primary w-full" value="99" max="100" />
          </td>
          <th className="w-10"> {"99%"->React.string} </th>
        </tr>
        <tr>
          <th>
            <label>
              <input type_="radio" name="radio" className="radio radio-primary" />
            </label>
          </th>
          <td>
            {"연습 단어"->React.string}
            <br />
            <progress className="progress progress-primary w-full" value="1" max="100" />
          </td>
          <th> {"1%"->React.string} </th>
        </tr>
      </tbody>
    </table>
  </div>
}
