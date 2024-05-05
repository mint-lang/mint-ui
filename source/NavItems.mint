component Ui.NavItems {
  /* The size of the component. */
  property size : Ui.Size = Ui.Size.Inherit

  /* The navigation items to display. */
  property items : Array(Ui.NavItem) = []

  /* Styles for the component. */
  style base {
    font-size: #{Ui.Size.toString(size)};
    align-content: start;
    grid-gap: 0.25em;
    display: grid;
  }

  fun render : Html {
    <div::base>
      for item of items {
        <Ui.NavItem item={item}/>
      }
    </div>
  }
}
