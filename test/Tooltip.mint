suite "Ui.Tooltip" {
  test "renders children" {
    <Ui.Tooltip content="Hint">
      <span id="child">"Hello"</span>
    </Ui.Tooltip>
    |> Test.Html.start()
    |> Test.Html.assertTextOf("#child", "Hello")
  }

  test "renders tooltip text" {
    <Ui.Tooltip content="Hint"/>
    |> Test.Html.start()
    |> Test.Html.assertElementExists("div[role='tooltip']")
  }

  test "does not render tooltip when content is empty" {
    <Ui.Tooltip content=""/>
    |> Test.Html.start()
    |> Test.Html.assertElementNotExists("div[role='tooltip']")
  }
}
