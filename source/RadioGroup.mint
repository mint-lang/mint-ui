/* A radio group component for selecting a single option from a list. */
component Ui.RadioGroup {
  /* The change event handler, called with the selected item key. */
  property onChange : Function(String, Promise(Void)) = Promise.never1

  /* The size of the radio group. */
  property size : Ui.Size = Ui.Size.Inherit

  /* The list of items to display. Each item is a tuple of (key, label). */
  property items : Array(Tuple(String, String)) = []

  /* The currently selected item key. */
  property value : String = ""

  /* Whether or not the radio group is disabled. */
  property disabled : Bool = false

  /* Whether or not the radio group is invalid. */
  property invalid : Bool = false

  /* Whether or not to layout the items horizontally. */
  property horizontal : Bool = false

  /* Styles for the radio group container. */
  style base {
    font-size: #{Ui.Size.toString(size)};
    font-family: var(--font-family);

    display: grid;
    grid-gap: 0.5em;

    if horizontal {
      grid-auto-flow: column;
      grid-auto-columns: max-content;
    }

    if disabled {
      filter: saturate(0) brightness(0.8) contrast(0.5);
      cursor: not-allowed;
      pointer-events: none;
    }
  }

  /* Styles for a radio item. */
  style item {
    align-items: center;
    grid-gap: 0.5em;
    display: grid;

    grid-template-columns: auto 1fr;
    cursor: pointer;

    if disabled {
      cursor: not-allowed;
    }
  }

  /* Styles for the radio circle (unchecked). */
  style radio {
    border: 0.125em solid var(--input-border);
    background: var(--input-color);

    box-sizing: border-box;
    border-radius: 50%;
    height: 1.25em;
    width: 1.25em;

    display: grid;
    place-items: center;

    if invalid {
      border-color: var(--input-invalid-border);
    }
  }

  /* Styles for the radio circle (checked). */
  style radioChecked {
    border: 0.125em solid var(--primary-color);
    background: var(--input-color);

    box-sizing: border-box;
    border-radius: 50%;
    height: 1.25em;
    width: 1.25em;

    display: grid;
    place-items: center;
  }

  /* Styles for the inner dot of a checked radio. */
  style dot {
    background: var(--primary-color);
    border-radius: 50%;
    height: 0.5em;
    width: 0.5em;
  }

  /* Styles for the label text. */
  style label {
    line-height: 1.4;
    color: var(--content-text);

    if invalid {
      color: var(--input-invalid-text);
    }
  }

  /* Handles clicking a radio item. */
  fun handleClick (key : String) : Promise(Void) {
    onChange(key)
  }

  /* Renders the radio group. */
  fun render : Html {
    <div::base role="radiogroup">
      {
        for item of items {
          let {key, label} =
            item

          let checked =
            key == value

          <div::item
            role="radio"
            aria-checked={Bool.toString(checked)}
            onClick={(e : Html.Event) { handleClick(key) }}>

            if checked {
              <div::radioChecked>
                <div::dot/>
              </div>
            } else {
              <div::radio/>
            }

            <span::label>label</span>
          </div>
        }
      }
    </div>
  }
}
