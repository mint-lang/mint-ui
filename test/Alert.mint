suite "Ui.Alert" {
  test "renders the title" {
    <Ui.Alert title="Heads up!" message="Something happened."/>
    |> Test.Html.start()
    |> Test.Html.assertElementExists("div[role='alert']")
  }

  test "renders the icon" {
    <Ui.Alert title="Info"/>
    |> Test.Html.start()
    |> Test.Html.assertElementExists("svg")
  }

  test "renders the close button when closeable" {
    <Ui.Alert title="Info" closeable={true}/>
    |> Test.Html.start()
    |> Test.Html.assertElementExists("button")
  }

  test "does not render close button by default" {
    <Ui.Alert title="Info"/>
    |> Test.Html.start()
    |> Test.Html.assertElementNotExists("button")
  }

  test "handles close event" {
    let handler =
      Promise.never
      |> Test.Context.spyOn()

    <Ui.Alert title="Info" closeable={true} onClose={handler}/>
    |> Test.Html.start()
    |> Test.Html.triggerClick("button")
    |> Test.Context.assertFunctionCalled(handler)
  }
}
