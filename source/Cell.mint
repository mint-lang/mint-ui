/* Component for rendering a `Ui.Cell` enum. */
component Ui.Cell {
  connect Ui exposing { mobile }

  /* The size of the cell. */
  property size : Ui.Size = Ui.Size::Inherit

  /* The cell itself. */
  property cell : Ui.Cell

  /* Styles for the base. */
  style base {
    font-size: #{Ui.Size.toString(size)};
  }

  /* Styles for the code. */
  style code (breakSpaces : Bool) {
    border: 0.0625em solid var(--input-border);
    background: var(--input-color);
    color: var(--input-text);

    padding: 0.25em 0.45em 0;
    border-radius: 0.25em;
    display: inline-block;
    font-size: 0.875em;
    white-space: pre;
    word-break: normal;

    if (mobile || breakSpaces) {
      white-space: break-spaces;
    }
  }

  /* Renders the cell. */
  fun render : Html {
    <div::base>
      case (cell) {
        Ui.Cell::Number(value) => <{ Number.toString(value) }>
        Ui.Cell::String(value) => <{ value }>
        Ui.Cell::Html(value) => value

        Ui.Cell::Code(code, breakSpaces) =>
          <code::code(breakSpaces)>
            <{ code }>
          </code>

        Ui.Cell::HtmlItems(actions) =>
          <Ui.Container
            justify="start"
            gap={Ui.Size::Em(0.5)}>

            <{ actions }>

          </Ui.Container>
      }
    </div>
  }
}
