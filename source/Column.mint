/* A column of items which are separated by a gap (uses Ui.Container). */
component Ui.Column {
  /* The size of the component. */
  property size : Ui.Size = Ui.Size::Inherit

  /* The gap between the items. */
  property gap : Ui.Size = Ui.Size::Em(0.5)

  /* The items to render. */
  property children : Array(Html) = []

  /* Where to justify the content. */
  property justify : String = "stretch"

  /* Where to align the items. */
  property align : String = "stretch"

  /* Renders the component. */
  fun render : Html {
    <Ui.Container
      orientation="vertical"
      justify={justify}
      align={align}
      size={size}
      gap={gap}>

      children

    </Ui.Container>
  }
}
