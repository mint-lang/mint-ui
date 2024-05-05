/* A response grid component. */
component Ui.Grid {
  connect Ui exposing { mobile }

  /* The minimum width of a column on mobile. */
  property mobileWidth : Ui.Size = Ui.Size.Em(20)

  /* The minimum width of a column. */
  property width : Ui.Size = Ui.Size.Em(15)

  /* The size of the component. */
  property size : Ui.Size = Ui.Size.Inherit

  /* The gap between the children. */
  property gap : Ui.Size = Ui.Size.Em(1)

  /* The children to render. */
  property children : Array(Html) = []

  /* The styles for the grid. */
  style base {
    grid-template-columns: repeat(auto-fit, minmax(#{Ui.Size.toString(columnWidth)}, 1fr));
    grid-gap: #{Ui.Size.toString(gap)};
    display: grid;

    font-size: #{Ui.Size.toString(size)};
  }

  get columnWidth : Ui.Size {
    if mobile {
      mobileWidth
    } else {
      width
    }
  }

  /* Renders the grid. */
  fun render : Html {
    <div::base>
      children
    </div>
  }
}
