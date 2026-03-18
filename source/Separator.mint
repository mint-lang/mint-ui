/* A visual divider to separate content, either horizontally or vertically. */
component Ui.Separator {
  /* The size of the separator. */
  property size : Ui.Size = Ui.Size.Inherit

  /* Whether or not the separator is vertical. */
  property vertical : Bool = false

  /* Styles for a horizontal separator. */
  style horizontal {
    font-size: #{Ui.Size.toString(size)};
    border: 0;

    border-top: 0.0625em solid var(--content-border);
    width: 100%;
    margin: 0;
  }

  /* Styles for a vertical separator. */
  style vertical {
    font-size: #{Ui.Size.toString(size)};
    border: 0;

    border-left: 0.0625em solid var(--content-border);
    align-self: stretch;
    min-height: 1em;
    margin: 0;
  }

  /* Renders the separator. */
  fun render : Html {
    if vertical {
      <hr::vertical role="separator" aria-orientation="vertical"/>
    } else {
      <hr::horizontal role="separator"/>
    }
  }
}
