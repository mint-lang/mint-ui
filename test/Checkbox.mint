suite "Ui.Checkbox" {
  test "triggers change event" {
    try {
      handler =
        (event : Bool) { Promise.never() }
        |> Test.Context.spyOn

      with Test.Html {
        <Ui.Checkbox onChange={handler}/>
        |> start()
        |> triggerClick("button")
        |> Test.Context.assertFunctionCalled(handler)
      }
    }
  }
}

suite "Ui.Checkbox - Disabled" {
  test "does not trigger change event" {
    with Test.Html {
      try {
        handler =
          (event : Bool) { Promise.never() }
          |> Test.Context.spyOn

        with Test.Html {
          <Ui.Checkbox
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
