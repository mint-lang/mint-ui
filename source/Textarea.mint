/* A textarea component. */
component Ui.Textarea {
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

  /*
  The behavior of the textarea, can be:
    - `resize-horizontal`
    - `resize-vertical`
    - `resize-both`
    - `static`
    - `grow`
  */
  property behavior : String = "resize-both"

  /* The placeholder to display if the value is empty. */
  property placeholder : String = ""

  /* The number of milliseconds to delay the `onChange` event. */
  property inputDelay : Number = 0

  /* Whether or not the textarea is disabled. */
  property disabled : Bool = false

  /* Whether or not the textarea is invalid. */
  property invalid : Bool = false

  /* The value of the textarea. */
  property value : String = ""

  /* The size of the textarea. */
  property size : Ui.Size = Ui.Size::Inherit

  property rows : Number = 5

  /* The current value of the input. */
  state currentValue : Maybe(String) = Maybe::Nothing

  /* The ID of the last timeout. */
  state timeoutId : Number = 0

  use Providers.TabFocus {
    onTabOut: onTabOut,
    onTabIn: onTabIn,
    element: textarea
  }

  /* The common styles for the textarea and its mirror. */
  style common {
    border: 0.0625em solid var(--input-border);
    padding: 0.4375em 0.625em;
    box-sizing: border-box;
  }

  /* Styles for the textarea. */
  style textarea {
    background-color: var(--input-color);
    color: var(--input-text);
    border-radius: 0.375em;

    font-family: inherit;
    line-height: inherit;
    font-weight: inherit;
    font-size: inherit;
    color: inherit;
    outline: none;
    margin: 0;

    case (behavior) {
      "grow" =>
        position: absolute;
        overflow: hidden;
        height: 100%;
        width: 100%;
        left: 0;
        top: 0;

      =>
    }

    case (behavior) {
      "resize-horizontal" => resize: horizontal;
      "resize-vertical" => resize: vertical;
      "resize-both" => resize: both;
      => resize: none;
    }

    &:focus {
      if (invalid) {
        border-color: var(--input-invalid-border);
        background: var(--input-invalid-color);
        color: var(--input-invalid-text);
      } else {
        border-color: var(--input-focus-border);
        background: var(--input-focus-color);
        color: var(--input-focus-text);
      }
    }

    if (invalid) {
      border-color: var(--input-invalid-border);
      background: var(--input-invalid-color);
      color: var(--input-invalid-text);
    } else {
      border-color: var(--input-border);
      background: var(--input-color);
      color: var(--input-text);
    }

    &:disabled {
      filter: saturate(0) brightness(0.8) contrast(0.5);
      cursor: not-allowed;
      user-select: none;
    }
  }

  /* Styles for the mirror. */
  style mirror {
    word-break: break-word;
    word-wrap: break-word;
    white-space: pre-wrap;
    visibility: hidden;
    user-select: none;
    display: block;
  }

  /* Styles for the base. */
  style base {
    -webkit-tap-highlight-color: rgba(0,0,0,0);
    -webkit-touch-callout: none;

    font-size: #{Ui.Size.toString(size)};
    font-family: var(--font-family);

    min-height: 2.375em;
    line-height: 1.3em;

    word-break: break-word;
    word-wrap: break-word;
    position: relative;
    overflow: visible;

    display: inline-grid;
    position: relative;
    width: 100%;
  }

  /* Focuses the textarea. */
  fun focus : Promise(Void) {
    Dom.focus(textarea)
  }

  /* Handles the `input` and `change` events. */
  fun handleChange (event : Html.Event) {
    if (inputDelay == 0) {
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

  /* Renders the textarea. */
  fun render : Html {
    <div::base>
      case (behavior) {
        "grow" =>
          <div::common::mirror>
            <{
              {
                /* Get the value as lines. */
                let lines =
                  currentValue
                  |> Maybe.withDefault(value)
                  |> String.split("\n")

                /*
                We need to add an extra line because the mirror
                won't grow in an empty line.
                */
                let last =
                  Array.last(lines)
                  |> Maybe.map(
                    (item : String) {
                      if (String.isBlank(item)) {
                        <>
                          " "
                        </>
                      } else {
                        <></>
                      }
                    })
                  |> Maybe.withDefault(<></>)

                /* Map lines into spans separated by line breaks. */
                let spans =
                  lines
                  |> Array.map(
                    (line : String) : Html {
                      <span>
                        <{ line }>
                      </span>
                    })
                  |> Array.intersperse(<br/>)

                <>
                  <{ spans }>
                  <{ last }>
                </>
              }
            }>
          </div>

        => <></>
      }

      <textarea::common::textarea as textarea
        value={Maybe.withDefault(currentValue, value)}
        rows={Number.toString(rows)}
        placeholder={placeholder}
        onMouseDown={onMouseDown}
        onChange={handleChange}
        onInput={handleChange}
        onMouseUp={onMouseUp}
        onKeyDown={onKeyDown}
        disabled={disabled}
        onFocus={onFocus}
        onKeyUp={onKeyUp}
        onBlur={onBlur}/>
    </div>
  }
}
