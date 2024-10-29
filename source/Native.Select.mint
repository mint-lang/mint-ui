/* A select component using the native `select` element. */
component Ui.Native.Select {
  /* The change event handler. */
  property onChange : Function(String, Promise(Void)) = Promise.never1

  /* The size of the select. */
  property size : Ui.Size = Ui.Size.Inherit

  /* The items to show. */
  property items : Array(Ui.ListItem) = []

  /* The placeholder to show when there is no value selected. */
  property placeholder : String = ""

  /* The key of the current selected element. */
  property value : String = ""

  /* Whether or not the select is invalid. */
  property invalid : Bool = false

  /* Whether or not the select is disabled. */
  property disabled : Bool = false

  /* A variable for tracking the focused state. */
  state focused : Bool = false

  /* Styles for the element. */
  style element {
    font-size: #{Ui.Size.toString(size)};
    font-family: var(--font-family);
    line-height: 1;

    border-radius: 0.375em;
    padding: 0 0.625em;
    height: 2.75em;

    box-sizing: border-box;
    position: relative;
    user-select: none;
    outline: none;

    align-items: center;
    display: grid;

    if disabled {
      filter: saturate(0) brightness(0.8) contrast(0.5);
      cursor: not-allowed;
      user-select: none;
    } else {
      cursor: pointer;
    }

    if invalid {
      border: 0.0625em solid var(--input-invalid-border);
      background: var(--input-invalid-color);
      color: var(--input-invalid-text);
    } else if focused {
      border: 0.0625em solid var(--input-focus-border);
      background: var(--input-focus-color);
      color: var(--input-focus-text);
    } else {
      border: 0.0625em solid var(--input-border);
      background: var(--input-color);
      color: var(--input-text);
    }
  }

  /* Styles for the placeholder. */
  style placeholder {
    user-select: none;
    opacity: 0.5;
  }

  /* Styles for the select. */
  style select {
    position: absolute;
    cursor: pointer;
    width: 100%;
    min-height: 100%;
    z-index: 1;
    opacity: 0;
    bottom: 0;
    right: 0;
    left: 0;
    top: 0;

    if disabled {
      pointer-events: none;
    }
  }

  /* Styles for the grid. */
  style grid {
    grid-template-columns: 1fr min-content;
    align-items: center;
    grid-gap: 0.625em;
    display: grid;
  }

  /* The change event handler. */
  fun handleChange (event : Html.Event) {
    event.target
    |> Dom.getValue
    |> onChange
  }

  /* The focus event handler. */
  fun handleFocus {
    next { focused: true }
  }

  /* The blur event handler. */
  fun handleBlur {
    next { focused: false }
  }

  /* Renders the select. */
  fun render : Html {
    let label =
      items
      |> Array.find((item : Ui.ListItem) { Ui.ListItem.key(item) == value })
      |> Maybe.map((item : Ui.ListItem) { <div>Ui.ListItem.content(item)</div> })
      |> Maybe.withDefault(<div::placeholder>placeholder</div>)

    let grid =
      <div::grid>
        label

        <Ui.Icon icon={Ui.Icons.CHEVRON_DOWN}/>
      </div>

    <div::element as element>
      <select::select
        onChange={handleChange}
        onFocus={handleFocus}
        onBlur={handleBlur}
        disabled={disabled}
        value={value}
      >
        for item of items {
          case item {
            Divider => <option disabled={true} label="─────────────"/>
            Item(_, content, key) => <option value={key}>content</option>
          }
        }
      </select>

      grid
    </div>
  }
}
