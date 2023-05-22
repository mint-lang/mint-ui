/* A layout to display content centered. */
component Ui.Layout.Centered {
  connect Ui exposing { mobile }

  /* The maximum with of the content. */
  property maxContentWidth : String = "auto"

  /* The children to display. */
  property children : Array(Html) = []

  /* The styles for the page. */
  style base {
    grid-template-columns: minmax(0, #{maxContentWidth});
    place-content: center;
    display: grid;

    if mobile {
      padding: 2em 1em;
    } else {
      padding: 2em;
    }
  }

  /* Renders the page. */
  fun render : Html {
    <div::base as base>
      <{ children }>
    </div>
  }
}
