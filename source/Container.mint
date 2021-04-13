/* A container where the items are separated by a gap. */
component Ui.Container {
  /* The orientation of the grid, either `horizontal` or `vertical`. */
  property orientation : String = "horizontal"

  /* Where to justify the content. */
  property justify : String = "stretch"

  /* Where to align the items. */
  property align : String = "center"

  /* The size of the grid. */
  property size : Ui.Size = Ui.Size::Inherit

  /* The gap between the children. */
  property gap : Ui.Size = Ui.Size::Em(0.5)

  /* The children to render. */
  property children : Array(Html) = []

  /* Styles for the base element. */
  style base {
    font-size: #{Ui.Size.toString(size)};
    grid-gap: #{Ui.Size.toString(gap)};
    display: grid;

    if (orientation == "horizontal") {
      justify-content: #{justify};
      grid-auto-flow: column;
      align-items: #{align};
    } else {
      align-content: #{justify};
      justify-items: #{align};
    }
  }

  /* Renders the component. */
  fun render : Html {
    <div::base>
      <{ children }>
    </div>
  }
}
