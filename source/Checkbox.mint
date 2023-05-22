/* A simple checkbox component. */
component Ui.Checkbox {
  /* The handler for the change event. */
  property onChange : Function(Bool, Promise(Void)) = Promise.never1

  /* The size of the checkbox. */
  property size : Ui.Size = Ui.Size::Inherit

  /* Whether or not the checkbox is disabled. */
  property disabled : Bool = false

  /* Whether or not the checkbox is checked. */
  property checked : Bool = false

  style base {
    -webkit-tap-highlight-color: rgba(0,0,0,0);
    -webkit-touch-callout: none;

    justify-content: center;
    display: inline-flex;
    align-items: center;

    position: relative;
    cursor: pointer;
    outline: none;
    padding: 0;
    border: 0;

    font-size: #{Ui.Size.toString(size)};

    border: 0.0625em solid var(--input-border);
    border-radius: 0.375em;
    height: 2.125em;
    width: 2.125em;

    if checked {
      background-color: var(--primary-color);
      border-color: var(--primary-color);
      color: var(--primary-text);
    } else {
      background-color: var(--input-color);
      border-color: var(--input-border);
      color: var(--input-text);
    }

    &::-moz-focus-inner {
      border: 0;
    }

    &:focus {
      if checked {
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
      filter: saturate(0) brightness(0.8) contrast(0.5);
      cursor: not-allowed;
    }
  }

  /* Toggles the checkbox. */
  fun toggle : Promise(Void) {
    onChange(!checked)
  }

  /* Focuses the checkbox. */
  fun focus : Promise(Void) {
    Dom.focus(checkbox)
  }

  /* Renders the checkbox. */
  fun render : Html {
    <button::base as checkbox
      aria-checked={Bool.toString(checked)}
      disabled={disabled}
      onClick={toggle}
      role="checkbox">

      <Ui.Icon
        icon={Ui.Icons:CHECK}
        opacity={
          if checked {
            1
          } else {
            0.25
          }
        }/>

    </button>
  }
}
