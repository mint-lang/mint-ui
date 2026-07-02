suite "Ui.Separator" {
  test "renders a horizontal separator by default" {
    <Ui.Separator/>
    |> Test.Html.start()
    |> Test.Html.assertElementExists("hr")
  }

  test "renders a vertical separator" {
    <Ui.Separator vertical={true}/>
    |> Test.Html.start()
    |> Test.Html.assertElementExists("hr")
  }
}
