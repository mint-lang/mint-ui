suite "Ui.Avatar" {
  test "renders initials fallback" {
    <Ui.Avatar initials="JD"/>
    |> Test.Html.start()
    |> Test.Html.assertTextOf("span", "JD")
  }

  test "renders image when src is provided" {
    <Ui.Avatar src="test.png" alt="Test"/>
    |> Test.Html.start()
    |> Test.Html.assertElementExists("img")
  }

  test "renders default icon when no src or initials" {
    <Ui.Avatar/>
    |> Test.Html.start()
    |> Test.Html.assertElementExists("svg")
  }
}
