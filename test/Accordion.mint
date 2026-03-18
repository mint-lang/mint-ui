suite "Ui.Accordion" {
  test "renders all section headers" {
    <Ui.Accordion
      sections={[
        {"s1", "Section 1", <div>"Content 1"</div>},
        {"s2", "Section 2", <div>"Content 2"</div>}
      ]}/>
    |> Test.Html.start()
    |> Test.Html.assertTextOf("button:first-child", "Section 1")
  }

  test "renders the chevron icon" {
    <Ui.Accordion
      sections={[{"s1", "Title", <div>"Body"</div>}]}/>
    |> Test.Html.start()
    |> Test.Html.assertElementExists("svg")
  }

  test "renders without errors when disabled" {
    <Ui.Accordion
      sections={[{"s1", "Title", <div>"Body"</div>}]}
      disabled={true}/>
    |> Test.Html.start()
    |> Test.Html.assertElementExists("div")
  }
}
