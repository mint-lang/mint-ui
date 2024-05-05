/* A row of items which are separated by a gap (uses Ui.Container). */
component Ui.Row {
  /* The size of the component. */
  property size : Ui.Size = Ui.Size.Inherit

  /* The gap between the items. */
  property gap : Ui.Size = Ui.Size.Em(0.5)

  /* The items to render. */
  property children : Array(Html) = []

  /* Where to justify the items. */
  property justify : String = "stretch"

  /* Where to align the items. */
  property align : String = "stretch"

  /* Renders the component. */
  fun render : Html {
    <Ui.Container
      orientation="horizontal"
      justify={justify}
      align={align}
      size={size}
      gap={gap}>

      children

    </Ui.Container>
  }
}
