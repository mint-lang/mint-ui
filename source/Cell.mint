/* Component for rendering a `Ui.Cell` enum. */
component Ui.Cell {
  connect Ui exposing { mobile }

  /* The size of the cell. */
  property size : Ui.Size = Ui.Size.Inherit

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

    if mobile || breakSpaces {
      white-space: break-spaces;
    }
  }

  /* Renders the cell. */
  fun render : Html {
    <div::base>
      case cell {
        Number(value) => <>Number.toString(value)</>
        String(value) => <>value</>
        Html(value) => value

        Code(breakSpaces, code) => <code::code(breakSpaces)>code</code>

        HtmlItems(items, breakOnMobile) =>
          if mobile && breakOnMobile {
            <Ui.Column>items</Ui.Column>
          } else {
            <Ui.Row justify="start">items</Ui.Row>
          }
      }
    </div>
  }
}
