suite "Ui.Toggle" {
  test "triggers change event" {
    let handler =
      (event : Bool) { Promise.never() }
      |> Test.Context.spyOn

    <Ui.Toggle onChange={handler}/>
    |> Test.Html.start()
    |> Test.Html.triggerClick("button")
    |> Test.Context.assertFunctionCalled(handler)
  }
}

suite "Ui.Toggle - Disabled" {
  test "does not trigger change event" {
    let handler =
      (event : Bool) { Promise.never() }
      |> Test.Context.spyOn

    <Ui.Toggle onChange={handler} disabled={true}/>
    |> Test.Html.start()
    |> Test.Html.triggerClick("button")
    |> Test.Context.assertFunctionNotCalled(handler)
  }
}
