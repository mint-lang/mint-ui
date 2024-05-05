/* A form field component. */
component Ui.Field {
  /* The error message. */
  property error : Maybe(String) = Maybe.Nothing

  /* The orientation. */
  property orientation : Ui.Field = Ui.Field.Vertical

  /* Whether or not the label is in a single line. */
  property singleLineLabel : Bool = true

  /* The children to render. */
  property children : Array(Html) = []

  /* The label to display. */
  property label : String = ""

  /* The style for the base. */
  style base {
    text-align: left;
  }

  /* The style for the control. */
  style control {
    case orientation {
      Ui.Field.HorizontalReverse =>
        flex-direction: row;
        align-items: center;

      Ui.Field.Horizontal =>
        flex-direction: row-reverse;
        align-items: center;

      Ui.Field.Vertical =>
        flex-direction: column;
    }

    display: flex;
  }

  /* The style for the error message. */
  style error {
    color: var(--danger-color);
    margin-top: 0.3125em;

    align-items: start;
    display: flex;

    font-family: var(--font-family);
    font-size: 0.875em;
    font-weight: bold;

    > *:first-child {
      position: relative;
      top: 0.25em;
    }
  }

  /* Style for the gap. */
  style gap {
    flex: 0 0 auto;
    height: 0.5em;
    width: 0.5em;
  }

  /* The style for the label. */
  style label {
    font-family: var(--font-family);
    color: var(--content-text);
    font-size: 0.875em;
    font-weight: bold;

    case orientation {
      Ui.Field.HorizontalReverse =>
        flex: 0 0 auto;

      Ui.Field.Horizontal =>
        flex: 1;

      Ui.Field.Vertical =>
        flex: 0 0 auto;
    }

    if singleLineLabel {
      white-space: nowrap;
      line-height: 1;
    }
  }

  /* Renders the component. */
  fun render : Html {
    <div::base>
      <div::control>
        <div::label>
          label
        </div>

        <div::gap/>

        <div>
          children
        </div>
      </div>

      if let Maybe.Just(message) = error {
        <div::error>
          <Ui.Icon icon={Ui.Icons.ALERT}/>
          <div::gap/>
          message
        </div>
      }
    </div>
  }
}
