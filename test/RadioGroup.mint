suite "Ui.RadioGroup" {
  test "renders all items" {
    <Ui.RadioGroup
      items={[{"a", "Option A"}, {"b", "Option B"}]}
      value="a"/>
    |> Test.Html.start()
    |> Test.Html.assertElementExists("div[role='radiogroup']")
  }

  test "handles change event" {
    let handler =
      (key : String) { Promise.never() }
      |> Test.Context.spyOn()

    <Ui.RadioGroup
      items={[{"a", "Option A"}, {"b", "Option B"}]}
      onChange={handler}
      value="a"/>
    |> Test.Html.start()
    |> Test.Html.triggerClick("div[role='radio']:last-child")
    |> Test.Context.assertFunctionCalled(handler)
  }
}

suite "Ui.RadioGroup - Disabled" {
  test "renders without errors when disabled" {
    <Ui.RadioGroup
      items={[{"a", "Option A"}]}
      disabled={true}
      value="a"/>
    |> Test.Html.start()
    |> Test.Html.assertElementExists("div[role='radiogroup']")
  }
}
