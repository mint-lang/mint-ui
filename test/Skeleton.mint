suite "Ui.Skeleton" {
  test "renders without errors" {
    <Ui.Skeleton/>
    |> Test.Html.start()
    |> Test.Html.assertElementExists("div")
  }

  test "is hidden from accessibility tree" {
    <Ui.Skeleton/>
    |> Test.Html.start()
    |> Test.Html.assertElementExists("div[aria-hidden='true']")
  }
}
