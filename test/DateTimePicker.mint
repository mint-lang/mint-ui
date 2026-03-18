suite "Ui.DateTimePicker" {
  test "renders the formatted datetime label" {
    <Ui.DateTimePicker value={`new Date(2024, 0, 15, 14, 30, 0)`}/>
    |> Test.Html.start()
    |> Test.Html.assertTextOf("div div div", "2024-01-15 14:30")
  }

  test "renders with a custom format" {
    <Ui.DateTimePicker
      value={`new Date(2024, 5, 1, 9, 5, 0)`}
      format="%d/%m/%Y %H:%M"/>
    |> Test.Html.start()
    |> Test.Html.assertTextOf("div div div", "01/06/2024 09:05")
  }

  test "renders the calendar icon" {
    <Ui.DateTimePicker/>
    |> Test.Html.start()
    |> Test.Html.assertElementExists("svg")
  }

  test "renders without errors when disabled" {
    <Ui.DateTimePicker disabled={true}/>
    |> Test.Html.start()
    |> Test.Html.assertElementExists("div")
  }
}

suite "Ui.DateTimePicker - Disabled" {
  test "does not open the dropdown when disabled" {
    <Ui.DateTimePicker disabled={true}/>
    |> Test.Html.start()
    |> Test.Html.triggerClick("div")
    |> Test.Html.assertElementExists("div")
  }
}
