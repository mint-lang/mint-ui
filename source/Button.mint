/*
Simple button component with a label and icons before or after the label.

It works in two modes:
- as a button, the `onClick` event needs to be handled
- as a link if the `href` property is not empty
*/
component Ui.Button {
  /* The mouse down event handler. */
  property onMouseDown : Function(Html.Event, Promise(Void)) = Promise.never1

  /* The mouse up event handler. */
  property onMouseUp : Function(Html.Event, Promise(Void)) = Promise.never1

  /* The click event handler. */
  property onClick : Function(Html.Event, Promise(Void)) = Promise.never1

  /* Where to align the text in case the button is wide. */
  property align : String = "center"

  /* The type of the button. */
  property type : String = "primary"

  /* The target window of the URL. */
  property target : String = ""

  /* The label of the button. */
  property label : String = ""

  /* The href of the button. */
  property href : String = ""

  /* Whether or not to break the words. */
  property breakWords : Bool = false

  /* Whether or not the button is disabled. */
  property disabled : Bool = false

  /* Whether or not make the text use ellipsis in case it overflows. */
  property ellipsis : Bool = true

  /* The icon before the label. */
  property iconBefore : Html = <></>

  /* The icon after the label. */
  property iconAfter : Html = <></>

  /* The size of the button. */
  property size : Ui.Size = Ui.Size::Inherit

  /* Styles for the button. */
  style styles {
    -webkit-tap-highlight-color: rgba(0,0,0,0);
    -webkit-touch-callout: none;
    -webkit-appearance: none;
    appearance: none;

    border-radius: 0.375em;
    display: inline-block;

    font-size: #{Ui.Size.toString(size)};
    font-family: var(--font-family);
    font-weight: bold;

    box-sizing: border-box;
    text-decoration: none;
    user-select: none;

    position: relative;
    cursor: pointer;
    outline: none;
    padding: 0;
    margin: 0;
    border: 0;

    case (type) {
      "warning" =>
        background-color: var(--warning-color);
        color: var(--warning-text);

      "success" =>
        background-color: var(--success-color);
        color: var(--success-text);

      "primary" =>
        background-color: var(--primary-color);
        color: var(--primary-text);

      "danger" =>
        background-color: var(--danger-color);
        color: var(--danger-text);

      "secondary" =>
        background-color: var(--secondary-color);
        color: var(--secondary-text);

      "faded" =>
        background-color: var(--faded-color);
        color: var(--faded-text);

      =>
    }

    &::-moz-focus-inner {
      border: 0;
    }

    &:focus::before {
      content: "";

      border-radius: 0.25em;
      position: absolute;
      bottom: 0.1875em;
      right: 0.1875em;
      left: 0.1875em;
      top: 0.1875em;

      case (type) {
        "secondary" => border: 0.125em solid var(--secondary-focus-ring);
        "success" => border: 0.125em solid var(--success-focus-ring);
        "warning" => border: 0.125em solid var(--warning-focus-ring);
        "primary" => border: 0.125em solid var(--primary-focus-ring);
        "danger" => border: 0.125em solid var(--danger-focus-ring);
        "faded" => border: 0.125em solid var(--faded-focus-ring);
        =>
      }
    }

    &:hover,
    &:focus {
      case (type) {
        "secondary" => background-color: var(--secondary-hover);
        "warning" => background-color: var(--warning-hover);
        "success" => background-color: var(--success-hover);
        "primary" => background-color: var(--primary-hover);
        "danger" => background-color: var(--danger-hover);
        "faded" => background-color: var(--faded-hover);
        =>
      }
    }

    &:disabled {
      filter: saturate(0) brightness(0.8) contrast(0.5);
      cursor: not-allowed;
    }
  }

  /* Styles for the container. */
  style container {
    justify-content: #{align};
    align-items: center;
    display: flex;

    box-sizing: border-box;
    padding: 0.75em 1.25em;
  }

  /* Styles for the label. */
  style label {
    padding-bottom: 0.05em;
    line-height: 1.2;

    if (breakWords) {
      word-break: break-word;
    } else if (ellipsis) {
      text-overflow: ellipsis;
      white-space: nowrap;
      overflow: hidden;
    } else {
      white-space: nowrap;
    }
  }

  /* Focuses the button. */
  fun focus : Promise(Void) {
    [button, anchor]
    |> Maybe.oneOf()
    |> Dom.focus()
  }

  /* Renders the button. */
  fun render : Html {
    let content =
      <div::container>
        <Ui.Container
          gap={Ui.Size::Em(0.625)}
          justify="start">

          if (Html.isNotEmpty(iconBefore)) {
            <Ui.Icon icon={iconBefore}/>
          }

          if (String.isNotBlank(label)) {
            <div::label>
              <{ label }>
            </div>
          }

          if (Html.isNotEmpty(iconAfter)) {
            <Ui.Icon icon={iconAfter}/>
          }

        </Ui.Container>
      </div>

    let mouseDownHandler =
      Ui.disabledHandler(disabled, onMouseDown)

    let mouseUpHandler =
      Ui.disabledHandler(disabled, onMouseUp)

    let clickHandler =
      Ui.disabledHandler(disabled, onClick)

    if (String.isNotBlank(href) && !disabled) {
      <a::styles as anchor
        onMouseDown={mouseDownHandler}
        onMouseUp={mouseUpHandler}
        onClick={clickHandler}
        target={target}
        href={href}>

        <{ content }>

      </a>
    } else {
      <button::styles as button
        onMouseDown={mouseDownHandler}
        onMouseUp={mouseUpHandler}
        onClick={clickHandler}
        disabled={disabled}>

        <{ content }>

      </button>
    }
  }
}
