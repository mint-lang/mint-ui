/* A component which traps focus inside itself. */
component Ui.FocusTrap {
  /* The children to render. */
  property children : Array(Html) = []

  /* Handles the keydown event. */
  fun handleKeyDown (event : Html.Event) {
    if let Maybe::Just(element) = base {
      if event.keyCode == 9 {
        let target =
          Maybe::Just(event.target)

        let elements =
          Dom.getFocusableElements(element)

        let first =
          Array.first(elements)

        let last =
          Array.last(elements)

        if event.shiftKey && first == target {
          Html.Event.preventDefault(event)
          Dom.focus(last)
        } else if !event.shiftKey && last == target {
          Html.Event.preventDefault(event)
          Dom.focus(first)
        }
      }
    }
  }

  /* Renders the component. */
  fun render : Html {
    <div as base onKeyDown={handleKeyDown}>
      children
    </div>
  }
}
