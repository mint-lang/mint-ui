suite "Ui.Checkbox" {
  test "triggers change event" {
    let handler =
      (event : Bool) { Promise.never() }
      |> Test.Context.spyOn

    <Ui.Checkbox onChange={handler}/>
    |> Test.Html.start()
    |> Test.Html.triggerClick("button")
    |> Test.Context.assertFunctionCalled(handler)
  }
}

suite "Ui.Checkbox - Disabled" {
  test "does not trigger change event" {
    let handler =
      (event : Bool) { Promise.never() }
      |> Test.Context.spyOn

    <Ui.Checkbox onChange={handler} disabled={true}/>
    |> Test.Html.start()
    |> Test.Html.triggerClick("button")
    |> Test.Context.assertFunctionNotCalled(handler)
  }
}
