suite "Ui.Toggle" {
  test "triggers change event" {
    try {
      handler =
        (event : Bool) { Promise.never() }
        |> Test.Context.spyOn

      with Test.Html {
        <Ui.Toggle onChange={handler}/>
        |> start()
        |> triggerClick("button")
        |> Test.Context.assertFunctionCalled(handler)
      }
    }
  }
}

suite "Ui.Toggle - Disabled" {
  test "does not trigger change event" {
    with Test.Html {
      try {
        handler =
          (event : Bool) { Promise.never() }
          |> Test.Context.spyOn

        with Test.Html {
          <Ui.Toggle
            onChange={handler}
            disabled={true}/>
          |> start()
          |> triggerClick("button")
          |> Test.Context.assertFunctionNotCalled(handler)
        }
      }
    }
  }
}
