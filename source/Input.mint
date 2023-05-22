/* A component for getting user input. */
component Ui.Input {
  /* The event handler for the icons click event. */
  property onIconClick : Function(Html.Event, Promise(Void)) = Promise.never1

  /* The `mousedown` event handler. */
  property onMouseDown : Function(Html.Event, Promise(Void)) = Promise.never1

  /* The `mouseup` event handler. */
  property onMouseUp : Function(Html.Event, Promise(Void)) = Promise.never1

  /* The `keydown` event handler. */
  property onKeyDown : Function(Html.Event, Promise(Void)) = Promise.never1

  /* The `keyup` event handler. */
  property onKeyUp : Function(Html.Event, Promise(Void)) = Promise.never1

  /* The `change` event handler. */
  property onChange : Function(String, Promise(Void)) = Promise.never1

  /* The event handler when the user tabs out of the input. */
  property onTabOut : Function(Promise(Void)) = Promise.never

  /* The event handler when the user tabs into the input. */
  property onTabIn : Function(Promise(Void)) = Promise.never

  /* The `focus` event handler. */
  property onFocus : Function(Promise(Void)) = Promise.never

  /* The `blur` event handler. */
  property onBlur : Function(Promise(Void)) = Promise.never

  /* The size of the input. */
  property size : Ui.Size = Ui.Size::Inherit

  /* Whether or not the icon is interactive. */
  property iconInteractive : Bool = false

  /* The placeholder to show. */
  property placeholder : String = ""

  /* The number of milliseconds to delay the `onChange` event. */
  property inputDelay : Number = 0

  /* Whether or not the input is disabled. */
  property disabled : Bool = false

  /* Whether or not the input is invalid. */
  property invalid : Bool = false

  /* The type of the input, should be either `text` or `email`. */
  property type : String = "text"

  /* The value of the input. */
  property value : String = ""

  /* The content for the icon. */
  property icon : Html = <></>

  /* The ID of the datalist element to connect to this input. */
  property list : String = ""

  /* The current value of the input. */
  state currentValue : Maybe(String) = Maybe::Nothing

  /* The ID of the last timeout. */
  state timeoutId : Number = 0

  use Providers.TabFocus {
    onTabOut: onTabOut,
    onTabIn: onTabIn,
    element: input
  }

  /* The styles for the base. */
  style base {
    font-size: #{Ui.Size.toString(size)};
    display: inline-block;
    position: relative;
    width: 100%;

    if disabled {
      filter: saturate(0) brightness(0.8) contrast(0.5);
      cursor: not-allowed;
    }
  }

  /* The styles for the input. */
  style input {
    font-family: var(--font-family);
    font-size: inherit;
    line-height: 1em;

    border: 0.0625em solid var(--input-border);
    background: var(--input-color);
    color: var(--input-text);

    border-radius: 0.375em;
    padding: 0 0.875em;
    height: 2.75em;

    box-sizing: border-box;
    box-shadow: none;
    outline: none;
    width: 100%;

    /* This gets rid of the autofill. */
    filter: none;

    if showIcon {
      padding-right: 2.125em;
    }

    &:focus {
      if invalid {
        border-color: var(--input-invalid-border);
        background: var(--input-invalid-color);
        color: var(--input-invalid-text);
      } else {
        border-color: var(--input-focus-border);
        background: var(--input-focus-color);
        color: var(--input-focus-text);
      }
    }

    if invalid {
      border-color: var(--input-invalid-border);
      background: var(--input-invalid-color);
      color: var(--input-invalid-text);
    } else {
      border-color: var(--input-border);
      background: var(--input-color);
      color: var(--input-text);
    }

    &:disabled {
      cursor: not-allowed;
    }
  }

  /* The styles for the icon. */
  style icon {
    top: calc(50% - 0.5em);
    right: 0.6875em;

    position: absolute;
    cursor: pointer;
    display: grid;

    if iconInteractive && !disabled {
      pointer-events: auto;
    } else {
      pointer-events: none;
    }

    if invalid {
      color: var(--input-invalid-text);
    } else {
      color: var(--input-text);
    }

    &:hover {
      color: var(--primary-color);
    }
  }

  /* Whether to show the icon or not. */
  get showIcon : Bool {
    Html.isNotEmpty(icon)
  }

  /* Focuses the input. */
  fun focus : Promise(Void) {
    Dom.focus(input)
  }

  /* Handles the `input` and `change` events. */
  fun handleChange (event : Html.Event) {
    if inputDelay == 0 {
      next { currentValue: Maybe::Nothing }
      onChange(Dom.getValue(event.target))
    } else {
      let {nextId, nextValue, promise} =
        Ui.inputDelayHandler(timeoutId, inputDelay, event)

      next
        {
          currentValue: Maybe::Just(nextValue),
          timeoutId: nextId
        }

      {
        /* Await the promise here. */
        await promise

        let actualValue =
          Maybe.withDefault(currentValue, value)

        await next { currentValue: Maybe::Nothing }

        onChange(actualValue)
      }
    }
  }

  /* Renders the input. */
  fun render : Html {
    <div::base>
      <input::input as input
        onMouseDown={onMouseDown}
        onChange={handleChange}
        onInput={handleChange}
        onMouseUp={onMouseUp}
        onKeyDown={onKeyDown}
        onFocus={onFocus}
        onKeyUp={onKeyUp}
        onBlur={onBlur}
        value={Maybe.withDefault(currentValue, value)}
        placeholder={placeholder}
        disabled={disabled}
        list={list}
        type={type}/>

      if showIcon {
        <div::icon onClick={onIconClick}>
          <Ui.Icon icon={icon}/>
        </div>
      }
    </div>
  }
}
