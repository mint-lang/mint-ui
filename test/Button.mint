suite "Ui.Button" {
  test "renders the label" {
    <Ui.Button label="Hello"/>
    |> Test.Html.start()
    |> Test.Html.assertTextOf("button", "Hello")
  }

  test "handles click events" {
    let handler =
      (event : Html.Event) { Promise.never() }
      |> Test.Context.spyOn()

    <Ui.Button onClick={handler}/>
    |> Test.Html.start()
    |> Test.Html.triggerClick("button")
    |> Test.Context.assertFunctionCalled(handler)
  }

  test "handles mouse down events" {
    let handler =
      (event : Html.Event) { Promise.never() }
      |> Test.Context.spyOn()

    <Ui.Button onMouseDown={handler}/>
    |> Test.Html.start()
    |> Test.Html.triggerMouseDown("button")
    |> Test.Context.assertFunctionCalled(handler)
  }

  test "handles mouse up events" {
    let handler =
      (event : Html.Event) { Promise.never() }
      |> Test.Context.spyOn

    <Ui.Button onMouseUp={handler}/>
    |> Test.Html.start()
    |> Test.Html.triggerMouseUp("button")
    |> Test.Context.assertFunctionCalled(handler)
  }
}

suite "Ui.Button - Disabled" {
  test "always renders as button" {
    <Ui.Button
      disabled={true}
      label="Hello"
      href="/"/>
    |> Test.Html.start()
    |> Test.Html.assertTextOf("button", "Hello")
  }

  test "doesn't handle click events" {
    let handler =
      (event : Html.Event) { Promise.never() }
      |> Test.Context.spyOn

    <Ui.Button
      onClick={handler}
      disabled={true}/>
    |> Test.Html.start()
    |> Test.Html.triggerClick("button")
    |> Test.Context.assertFunctionNotCalled(handler)
  }

  test "doesn't handle mouse down events" {
    let handler =
      (event : Html.Event) { Promise.never() }
      |> Test.Context.spyOn

    <Ui.Button
      onMouseDown={handler}
      disabled={true}/>
    |> Test.Html.start()
    |> Test.Html.triggerMouseDown("button")
    |> Test.Context.assertFunctionNotCalled(handler)
  }

  test "doesn't handle mouse up events" {
    let handler =
      (event : Html.Event) { Promise.never() }
      |> Test.Context.spyOn

    <Ui.Button
      onMouseUp={handler}
      disabled={true}/>
    |> Test.Html.start()
    |> Test.Html.triggerMouseUp("button")
    |> Test.Context.assertFunctionNotCalled(handler)
  }
}
