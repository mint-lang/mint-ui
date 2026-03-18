suite "Ui.Badge" {
  test "renders the label" {
    <Ui.Badge label="New"/>
    |> Test.Html.start()
    |> Test.Html.assertTextOf("span", "New")
  }

  test "renders with a different label" {
    <Ui.Badge label="3"/>
    |> Test.Html.start()
    |> Test.Html.assertTextOf("span", "3")
  }
}
