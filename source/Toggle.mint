/* A toggle component. */
component Ui.Toggle {
  /* The change event handler. */
  property onChange : Function(Bool, Promise(Void)) = Promise.never1

  /* The size of the component. */
  property size : Ui.Size = Ui.Size::Inherit

  /* The width of the component. */
  property width : Ui.Size = Ui.Size::Em(5.5)

  /* The label for the false position. */
  property offLabel : String = "OFF"

  /* The label for the true position. */
  property onLabel : String = "ON"

  /* Whether or not the toggle is disabled. */
  property disabled : Bool = false

  /* Whether or not the toggle is checked. */
  property checked : Bool = false

  /* Styles for the base element. */
  style base {
    -webkit-tap-highlight-color: rgba(0,0,0,0);
    -webkit-touch-callout: none;
    -webkit-appearance: none;
    appearance: none;

    if (checked) {
      background-color: var(--primary-color);
      border-color: var(--primary-color);
      color: var(--primary-text);
    } else {
      background-color: var(--input-color);
      border-color: var(--input-border);
      color: var(--input-text);
    }

    border-radius: 0.375em;
    border: 0.0625em solid;

    display: inline-flex;
    align-items: center;

    font-size: #{Ui.Size.toString(size)};
    font-family: var(--font-family);
    font-weight: bold;

    width: #{Ui.Size.toString(width)};
    height: 2.375em;

    position: relative;
    cursor: pointer;
    outline: none;
    padding: 0;

    &::-moz-focus-inner {
      border: 0;
    }

    &:focus {
      if (checked) {
        box-shadow: 0 0 0 0.125em var(--primary-focus-ring) inset;
        background-color: var(--primary-color);
        border-color: var(--primary-color);
        color: var(--primary-text);
      } else {
        background-color: var(--input-focus-color);
        border-color: var(--input-focus-border);
        color: var(--input-focus-text);
      }
    }

    &:disabled {
      filter: saturate(0) brightness(0.8);
      cursor: not-allowed;
    }
  }

  /* Style for the label. */
  style label (shown : Bool) {
    transition: opacity 120ms;
    text-align: center;
    font-size: 0.875em;
    width: 50%;

    if (shown) {
      opacity: 1;
    } else {
      opacity: 0;
    }
  }

  /* Styles for the overlay. */
  style overlay {
    background: var(--content-color);
    width: calc(50% - 0.5em);
    border-radius: 0.25em;
    position: absolute;
    bottom: 0.25em;
    top: 0.25em;

    transition: left 120ms;

    if (checked) {
      left: calc(100% / 2 + 0.25em);
    } else {
      left: 0.25em;
    }
  }

  /* Toggles the componnet. */
  fun toggle : Promise(Void) {
    onChange(!checked)
  }

  /* Renders the component. */
  fun render : Html {
    <button::base
      aria-checked={Bool.toString(checked)}
      disabled={disabled}
      onClick={toggle}
      role="checkbox">

      <div::label(checked) aria-hidden="true">
        <{ onLabel }>
      </div>

      <div::label(!checked) aria-hidden="true">
        <{ offLabel }>
      </div>

      <div::overlay aria-hidden="true"/>

    </button>
  }
}
