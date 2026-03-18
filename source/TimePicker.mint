/* A time picker component for selecting hours and minutes. */
component Ui.TimePicker {
  /* The change event handler. */
  property onChange : Function(Time, Promise(Void)) = Promise.never1

  /* The language to use for time formatting. */
  property language : Time.Format.Language = Time.Format.ENGLISH

  /* The position of the dropdown. */
  property position : Ui.Position = Ui.Position.BottomRight

  /* The size of the picker. */
  property size : Ui.Size = Ui.Size.Inherit

  /* The current value (as `Time`). */
  property value : Time = Time.now()

  /* Whether or not the picker is disabled. */
  property disabled : Bool = false

  /* Whether or not the picker is invalid. */
  property invalid : Bool = false

  /* The offset of the dropdown from the input. */
  property offset : Number = 5

  /* The formatter for the time in the input. */
  property formatter = Time.format

  /* The format for the time in the input. */
  property format : String = "%H:%M"

  /* The step in minutes for the minute selector. */
  property step : Number = 1

  style label {
    text-overflow: ellipsis;
    white-space: nowrap;
    overflow: hidden;
  }

  /* Styles for the time panel container. */
  style panel {
    font-family: var(--font-family);
    grid-template-columns: 1fr 1fr;
    grid-gap: 0.25em;
    display: grid;
    padding: 0.5em;
  }

  /* Styles for a column of time values. */
  style column {
    scrollbar-width: thin;
    overflow-y: auto;
    max-height: 15em;
  }

  /* Styles for the column header. */
  style columnHeader {
    text-transform: uppercase;
    text-align: center;
    font-weight: bold;
    font-size: 0.74em;
    padding: 0.5em 0;
    opacity: 0.5;
  }

  /* Styles for a time cell. */
  style cell {
    border-radius: 0.25em;
    text-align: center;
    line-height: 2em;
    cursor: pointer;

    &:hover {
      background: var(--primary-color);
      color: var(--primary-text);
    }
  }

  /* Styles for a selected time cell. */
  style cellSelected {
    border-radius: 0.25em;
    text-align: center;
    line-height: 2em;
    cursor: pointer;

    background: var(--primary-color);
    color: var(--primary-text);
  }

  /* Returns the current hour from the value. */
  get currentHour : Number {
    `#{value}.getHours()`
  }

  /* Returns the current minute from the value. */
  get currentMinute : Number {
    `#{value}.getMinutes()`
  }

  /* Handles clicking on an hour cell. */
  fun handleHourClick (hour : Number) : Promise(Void) {
    onChange(`new Date(#{value}.getFullYear(), #{value}.getMonth(), #{value}.getDate(), #{hour}, #{value}.getMinutes(), #{value}.getSeconds())`)
  }

  /* Handles clicking on a minute cell. */
  fun handleMinuteClick (minute : Number) : Promise(Void) {
    onChange(`new Date(#{value}.getFullYear(), #{value}.getMonth(), #{value}.getDate(), #{value}.getHours(), #{minute}, #{value}.getSeconds())`)
  }

  /* Handles the keydown event. */
  fun handleKeyDown (event : Html.Event) {
    case event.keyCode {
      37 =>
        onChange(`new Date(#{value}.getFullYear(), #{value}.getMonth(), #{value}.getDate(), #{value}.getHours(), #{value}.getMinutes() - #{step}, #{value}.getSeconds())`)

      38 =>
        {
          Html.Event.preventDefault(event)

          onChange(`new Date(#{value}.getFullYear(), #{value}.getMonth(), #{value}.getDate(), #{value}.getHours() - 1, #{value}.getMinutes(), #{value}.getSeconds())`)
        }

      39 =>
        onChange(`new Date(#{value}.getFullYear(), #{value}.getMonth(), #{value}.getDate(), #{value}.getHours(), #{value}.getMinutes() + #{step}, #{value}.getSeconds())`)

      40 =>
        {
          Html.Event.preventDefault(event)

          onChange(`new Date(#{value}.getFullYear(), #{value}.getMonth(), #{value}.getDate(), #{value}.getHours() + 1, #{value}.getMinutes(), #{value}.getSeconds())`)
        }

      => next { }
    }
  }

  /* Renders the time picker. */
  fun render : Html {
    let hours =
      Array.range(0, 23)

    let minutes =
      Array.range(0, 59)
      |> Array.select(
        (m : Number) { Math.remainder(m, step) == 0 })

    let panel =
      <Ui.AvoidFocus disableCursor={false}>
        <div::panel>
          <div>
            <div::columnHeader>"Hr"</div>

            <div::column>
              {
                for hour of hours {
                  if hour == currentHour {
                    <div::cellSelected onClick={(e : Html.Event) { handleHourClick(hour) }}>
                      Number.toString(hour)
                      |> String.padStart("0", 2)
                    </div>
                  } else {
                    <div::cell onClick={(e : Html.Event) { handleHourClick(hour) }}>
                      Number.toString(hour)
                      |> String.padStart("0", 2)
                    </div>
                  }
                }
              }
            </div>
          </div>

          <div>
            <div::columnHeader>"Min"</div>

            <div::column>
              {
                for minute of minutes {
                  if minute == currentMinute {
                    <div::cellSelected onClick={(e : Html.Event) { handleMinuteClick(minute) }}>
                      Number.toString(minute)
                      |> String.padStart("0", 2)
                    </div>
                  } else {
                    <div::cell onClick={(e : Html.Event) { handleMinuteClick(minute) }}>
                      Number.toString(minute)
                      |> String.padStart("0", 2)
                    </div>
                  }
                }
              }
            </div>
          </div>
        </div>
      </Ui.AvoidFocus>

    let label =
      Maybe.Just(<div::label>formatter(value, language, format)</div>)

    <Ui.Picker as picker
      icon={Ui.Icons.CLOCK}
      onKeyDown={handleKeyDown}
      matchWidth={false}
      disabled={disabled}
      invalid={invalid}
      position={position}
      offset={offset}
      panel={panel}
      label={label}
      size={size}
    />
  }
}
