/*
This component makes possible to have arbitrary HTML content which behaves
like static content:

- Tab focus is disabled by adding `tabindex="-1"` to all child elements.
- Pointer focus is disabled with the `pointer-events: none` CSS.
- Firefox focus ring because of `tabindex` is removed with `outline: none !important` CSS.
- All elements are hidden from screen readers.
*/
component Ui.AvoidFocus {
  /* Whether or not to disable cursor events as well. */
  property disableCursor : Bool = true

  /* The child elements. */
  property children : Array(Html) = []

  /* We are using the mutation provider to update elements on the fly. */
  use Provider.Mutation { changes: update, element: base }

  /* Style for the base element. */
  style base {
    if disableCursor {
      pointer-events: none;
    }

    * {
      outline: none !important;
    }
  }

  /* Sets `tabindex="-1"` on all child elements. */
  fun update : Promise(Void) {
    if let Maybe.Just(element) = base {
      for element of Dom.getElementsBySelector(element, "*") {
        Dom.setAttribute(element, "tabindex", "-1")
      }

      next { }
    }
  }

  /* Renders the component. */
  fun render : Html {
    <div::base as base aria-hidden="true">children</div>
  }
}
