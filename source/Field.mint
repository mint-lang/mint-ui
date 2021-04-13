/* A form field component. */
component Ui.Field {
  /* The error message. */
  property error : Maybe(String) = Maybe::Nothing

  /* The orientation either `vertical` or `horizontal`. */
  property orientation : String = "vertical"

  /* The children to render. */
  property children : Array(Html) = []

  /* The label to display. */
  property label : String = ""

  /* The style for the base. */
  style base {
    text-align: left;
    display: grid;
  }

  /* The style for the control. */
  style control {
    case (orientation) {
      "horizontal" =>
        justify-content: start;
        grid-auto-flow: column;
        align-items: center;
        grid-gap: 0.5em;

      =>
        align-content: start;
        grid-gap: 0.5em;
    }

    display: grid;
  }

  /* The style for the error message. */
  style error {
    color: var(--danger-color);

    margin-top: 0.3125em;

    grid-auto-flow: column;
    justify-content: start;
    align-items: start;
    grid-gap: 0.5em;
    display: grid;

    font-family: var(--font-family);
    font-size: 0.875em;
    font-weight: bold;

    > *:first-child {
      position: relative;
      top: 0.25em;
    }
  }

  /* The style for the label. */
  style label {
    font-family: var(--font-family);
    color: var(--content-text);

    font-size: 0.875em;
    font-weight: bold;

    white-space: nowrap;
    line-height: 1;

    flex: 0 0 auto;
  }

  fun render : Html {
    <div::base>
      <div::control>
        case (orientation) {
          "horizontal" =>
            <{
              <div>
                <{ children }>
              </div>

              <div::label>
                <{ label }>
              </div>
            }>

          =>
            <{
              <div::label>
                <{ label }>
              </div>

              <div>
                <{ children }>
              </div>
            }>
        }
      </div>

      case (error) {
        Maybe::Just message =>
          <div::error>
            <Ui.Icon icon={Ui.Icons:ALERT}/>
            <{ message }>
          </div>

        => <{  }>
      }
    </div>
  }
}
