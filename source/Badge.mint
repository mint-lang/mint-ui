/* A small status label for displaying tags, counts, or statuses. */
component Ui.Badge {
  /* The size of the badge. */
  property size : Ui.Size = Ui.Size.Inherit

  /* The label to display. */
  property label : String = ""

  /* The color of the badge (CSS color value). */
  property color : String = "var(--primary-color)"

  /* The text color of the badge (CSS color value). */
  property textColor : String = "var(--primary-text)"

  /* Styles for the badge. */
  style base {
    font-size: #{Ui.Size.toString(size)};
    font-family: var(--font-family);

    background: #{color};
    color: #{textColor};

    border-radius: 1em;
    padding: 0.125em 0.625em;

    display: inline-flex;
    align-items: center;

    line-height: 1.5em;
    font-weight: bold;
    font-size: 0.75em;

    white-space: nowrap;
    user-select: none;
  }

  /* Renders the badge. */
  fun render : Html {
    <span::base>label</span>
  }
}
