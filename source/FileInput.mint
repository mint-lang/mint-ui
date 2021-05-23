/* An input for selecting a file. */
component Ui.FileInput {
  /* The change event handler. */
  property onChange : Function(Maybe(File), Promise(Never, Void)) = Promise.never1

  /* The label for selecting a different file. */
  property selectAnotherLabel : String = "Click to select a different file."

  /* The initial label for selecting a file. */
  property selectLabel : String = "Select a file"

  /* The selected file. */
  property value : Maybe(File) = Maybe::Nothing

  /* The size of the input. */
  property size : Ui.Size = Ui.Size::Inherit

  /* The label for the clear action. */
  property clearLabel : String = "Clear"

  /* The content-type of the files the user can select. */
  property accept : String = "*"

  /* Styles for the root element. */
  style base {
    --file-input-border: var(--input-border);

    border: 0.0625em solid var(--input-border);
    background: var(--input-color);
    color: var(--input-text);
    border-radius: 0.375em;

    font-size: #{Ui.Size.toString(size)};
    font-family: var(--font-family);
    text-align: left;

    padding: 1em 1.25em;
    cursor: pointer;
    outline: none;
    width: 100%;

    &::-moz-focus-inner {
      border: 0;
    }

    &:hover,
    &:focus {
      --file-input-border: var(--input-focus-border);

      border-color: var(--input-focus-border);
      background: var(--input-focus-color);
      color: var(--input-focus-text);
    }
  }

  /* Style for the name of the file. */
  style name {
    margin-right: auto;
    max-height: 4em;

    -webkit-box-orient: vertical;
    -webkit-line-clamp: 3;
    display: -webkit-box;

    line-height: 1.25;
    font-weight: bold;

    word-break: break-word;
    overflow: hidden;
  }

  /* Style for the content-type and size fields. */
  style data {
    opacity: 0.75;
  }

  /* Styles for the fileds container. */
  style infos {
    border-bottom: 0.0625em solid var(--file-input-border);
    margin-bottom: 0.5em;
    padding-bottom: 1em;

    grid-template-columns: 1fr auto;
    grid-gap: 1em 0.5em;
    display: grid;

    > *:first-child {
      grid-column: span 2;
    }
  }

  /* Styles for the initial select label and icon. */
  style select {
    grid-auto-flow: column;
    align-items: center;
    grid-gap: 0.5em;
    display: grid;

    font-size: 1.125em;
    font-weight: 600;
  }

  /* Style for the select an other text and clear link. */
  style hint {
    font-size: 0.875em;
    opacity: 0.75;

    justify-content: space-between;
    grid-auto-flow: column;
    align-items: center;
    grid-gap: 1em;
    display: grid;

    > a {
      grid-auto-flow: column;
      align-items: center;
      grid-gap: 0.1em;
      display: grid;

      position: relative;
      cursor: pointer;

      &:hover {
        color: var(--primary-color);
      }

      &:hover::before {
        border-bottom: 0.0625em solid currentColor;
        position: absolute;
        bottom: 0.0625em;
        content: "";
        right: 0;
        left: 0;
      }
    }
  }

  /* Focuses the element. */
  fun focus : Promise(Never, Void) {
    Dom.focus(base)
  }

  /* Handles the clear event. */
  fun handleClear (event : Html.Event) : Promise(Never, Void) {
    try {
      Html.Event.preventDefault(event)
      Html.Event.stopPropagation(event)
      onChange(Maybe::Nothing)
    }
  }

  /* Handles the select event. */
  fun handleSelect (event : Html.Event) : Promise(Never, Void) {
    sequence {
      Html.Event.preventDefault(event)

      selected =
        File.select(accept)

      onChange(Maybe::Just(selected))
    }
  }

  /* Renders the component. */
  fun render : Html {
    <button::base as base onClick={handleSelect}>
      case (value) {
        Maybe::Just(file) =>
          <>
            <div::infos>
              <Ui.Field label="Name">
                <div::name>
                  <{ File.name(file) }>
                </div>
              </Ui.Field>

              <Ui.Field label="Content-Type">
                <div::data>
                  <{ File.mimeType(file) }>
                </div>
              </Ui.Field>

              <Ui.Field label="Size">
                <div::data>
                  <{ FileSize.format(File.size(file)) }>
                </div>
              </Ui.Field>
            </div>

            <div::hint>
              <{ selectAnotherLabel }>

              <a onClick={handleClear}>
                <{ clearLabel }>
                <Ui.Icon icon={Ui.Icons:X}/>
              </a>
            </div>
          </>

        Maybe::Nothing =>
          <div::select>
            <Ui.Icon icon={Ui.Icons:CLOUD_UPLOAD}/>
            <{ selectLabel }>
          </div>
      }
    </button>
  }
}
