/* A component which traps focus inside itself. */
component Ui.FocusTrap {
  /* The children to render. */
  property children : Array(Html) = []

  /* Handles the keydown event. */
  fun handleKeyDown (event : Html.Event) {
    case (base) {
      Maybe::Just element =>
        if (event.keyCode == 9) {
          try {
            target =
              Maybe::Just(event.target)

            elements =
              Dom.getFocusableElements(element)

            first =
              Array.first(elements)

            last =
              Array.last(elements)

            if (event.shiftKey && first == target) {
              try {
                Html.Event.preventDefault(event)
                Dom.focus(last)
              }
            } else if (!event.shiftKey && last == target) {
              try {
                Html.Event.preventDefault(event)
                Dom.focus(first)
              }
            } else {
              next {  }
            }
          }
        } else {
          next {  }
        }

      => next {  }
    }
  }

  /* Renders the component. */
  fun render : Html {
    <div as base onKeyDown={handleKeyDown}>
      <{ children }>
    </div>
  }
}
