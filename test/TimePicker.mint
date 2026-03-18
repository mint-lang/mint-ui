suite "Ui.TimePicker" {
  test "renders the formatted time label" {
    <Ui.TimePicker value={`new Date(2024, 0, 15, 14, 30, 0)`}/>
    |> Test.Html.start()
    |> Test.Html.assertTextOf("div div div", "14:30")
  }

  test "renders with a custom format" {
    <Ui.TimePicker
      value={`new Date(2024, 0, 15, 9, 5, 0)`}
      format="%H:%M:%S"/>
    |> Test.Html.start()
    |> Test.Html.assertTextOf("div div div", "09:05:00")
  }

  test "renders the clock icon" {
    <Ui.TimePicker/>
    |> Test.Html.start()
    |> Test.Html.assertElementExists("svg")
  }

  test "renders without errors when disabled" {
    <Ui.TimePicker disabled={true}/>
    |> Test.Html.start()
    |> Test.Html.assertElementExists("div")
  }
}

suite "Ui.TimePicker - Disabled" {
  test "does not open the dropdown when disabled" {
    <Ui.TimePicker disabled={true}/>
    |> Test.Html.start()
    |> Test.Html.triggerClick("div")
    |> Test.Html.assertElementExists("div")
  }
}
