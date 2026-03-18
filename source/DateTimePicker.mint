/* A combined date and time picker component. */
component Ui.DateTimePicker {
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

  /* The format for the date and time in the input. */
  property format : String = "%Y-%m-%d %H:%M"

  /* The step in minutes for the minute selector. */
  property step : Number = 1

  /* Whether or not to show the timezone in the label. */
  property showTimezone : Bool = false

  /* A variable for tracking the current month. */
  state month : Maybe(Time) = Maybe.Nothing

  style label {
    text-overflow: ellipsis;
    white-space: nowrap;
    overflow: hidden;
  }

  /* Styles for the panel container. */
  style panel {
    font-family: var(--font-family);
    display: grid;
    grid-gap: 0;
  }

  /* Styles for the separator between date and time sections. */
  style separator {
    border-top: 0.0625em solid var(--input-border);
  }

  /* Styles for the time section. */
  style timeSection {
    grid-template-columns: 1fr 1fr;
    grid-gap: 0.25em;
    display: grid;
    padding: 0.5em;
  }

  /* Styles for a column of time values. */
  style column {
    scrollbar-width: thin;
    overflow-y: auto;
    max-height: 10em;
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
  style cell (selected : Bool) {
    border-radius: 0.25em;
    text-align: center;
    line-height: 2em;
    cursor: pointer;

    if selected {
      background: var(--primary-color);
      color: var(--primary-text);
    }

    &:hover {
      background: var(--primary-color);
      color: var(--primary-text);
    }
  }

  /* Styles for the timezone display. */
  style timezone {
    font-size: 0.8em;
    opacity: 0.6;
    padding: 0.25em 0.5em;
    text-align: center;
    border-top: 0.0625em solid var(--input-border);
  }

  /* Returns the current UTC hour from the value. */
  get currentHour : Number {
    `#{value}.getUTCHours()`
  }

  /* Returns the current UTC minute from the value. */
  get currentMinute : Number {
    `#{value}.getUTCMinutes()`
  }

  /* Returns the timezone string of the current value. */
  get timezoneString : String {
    `(() => {
      try {
        return Intl.DateTimeFormat().resolvedOptions().timeZone
          + " (UTC" + (#{value}.getTimezoneOffset() <= 0 ? "+" : "-")
          + String(Math.abs(Math.floor(#{value}.getTimezoneOffset() / 60))).padStart(2, "0")
          + ":" + String(Math.abs(#{value}.getTimezoneOffset() % 60)).padStart(2, "0")
          + ")";
      } catch(e) {
        return "UTC" + (#{value}.getTimezoneOffset() <= 0 ? "+" : "-")
          + String(Math.abs(Math.floor(#{value}.getTimezoneOffset() / 60))).padStart(2, "0")
          + ":" + String(Math.abs(#{value}.getTimezoneOffset() % 60)).padStart(2, "0");
      }
    })()`
  }

  /* Handles the date change from the calendar, preserving the current UTC time. */
  fun handleDateChange (day : Time) : Promise(Void) {
    onChange(
      `(() => {
        var d = new Date(Date.UTC(
          #{day}.getUTCFullYear(), #{day}.getUTCMonth(), #{day}.getUTCDate(),
          #{value}.getUTCHours(), #{value}.getUTCMinutes(), #{value}.getUTCSeconds()));
        return d;
      })()`)
  }

  /* Handles clicking on an hour cell, reading the value from the data attribute. */
  fun handleHourSelect (event : Html.Event) : Promise(Void) {
    let hour =
      event.target
      |> Dom.getAttribute("data-value")
      |> Maybe.withDefault("0")
      |> Number.fromString()
      |> Maybe.withDefault(0)

    onChange(
      `(() => {
        var d = new Date(#{value}.getTime());
        d.setUTCHours(#{hour});
        return d;
      })()`)
  }

  /* Handles clicking on a minute cell, reading the value from the data attribute. */
  fun handleMinuteSelect (event : Html.Event) : Promise(Void) {
    let minute =
      event.target
      |> Dom.getAttribute("data-value")
      |> Maybe.withDefault("0")
      |> Number.fromString()
      |> Maybe.withDefault(0)

    onChange(
      `(() => {
        var d = new Date(#{value}.getTime());
        d.setUTCMinutes(#{minute});
        return d;
      })()`)
  }

  /* Handles the month change event. */
  fun handleMonthChange (value : Time) {
    next { month: Maybe.Just(value) }
  }

  /* Handles the keydown event. */
  fun handleKeyDown (event : Html.Event) {
    case event.keyCode {
      37 =>
        onChange(
          `(() => {
            var d = new Date(#{value}.getTime());
            d.setUTCDate(d.getUTCDate() - 1);
            return d;
          })()`)

      38 =>
        {
          Html.Event.preventDefault(event)

          onChange(
            `(() => {
              var d = new Date(#{value}.getTime());
              d.setUTCDate(d.getUTCDate() - 1);
              return d;
            })()`)
        }

      39 =>
        onChange(
          `(() => {
            var d = new Date(#{value}.getTime());
            d.setUTCDate(d.getUTCDate() + 1);
            return d;
          })()`)

      40 =>
        {
          Html.Event.preventDefault(event)

          onChange(
            `(() => {
              var d = new Date(#{value}.getTime());
              d.setUTCDate(d.getUTCDate() + 1);
              return d;
            })()`)
        }

      => next { }
    }
  }

  /* Renders the date time picker. */
  fun render : Html {
    let hours =
      Array.range(0, 23)

    let minutes =
      Array.range(0, 59)
      |> Array.select(
        (m : Number) : Bool { `#{m} % #{step} === 0` })

    let panel =
      <Ui.AvoidFocus disableCursor={false}>
        <div::panel>
          <Ui.Calendar as calendar
            month={Maybe.withDefault(month, value)}
            onMonthChange={handleMonthChange}
            changeMonthOnSelect={true}
            onChange={handleDateChange}
            embedded={true}
            day={value}
            size={size}
          />

          <div::separator/>

          <div::timeSection>
            <div>
              <div::columnHeader>"Hr"</div>

              <div::column>
                {
                  for hour of hours {
                    <div::cell(hour == currentHour)
                      data-value={Number.toString(hour)}
                      onClick={handleHourSelect}>

                      Number.toString(hour)
                      |> String.padStart("0", 2)
                    </div>
                  }
                }
              </div>
            </div>

            <div>
              <div::columnHeader>"Min"</div>

              <div::column>
                {
                  for minute of minutes {
                    <div::cell(minute == currentMinute)
                      data-value={Number.toString(minute)}
                      onClick={handleMinuteSelect}>

                      Number.toString(minute)
                      |> String.padStart("0", 2)
                    </div>
                  }
                }
              </div>
            </div>
          </div>

          if showTimezone {
            <div::timezone>timezoneString</div>
          }
        </div>
      </Ui.AvoidFocus>

    let formattedLabel =
      formatter(value, language, format)

    let labelText =
      if showTimezone {
        formattedLabel + " " + timezoneString
      } else {
        formattedLabel
      }

    let label =
      Maybe.Just(<div::label>labelText</div>)

    <Ui.Picker as picker
      icon={Ui.Icons.CALENDAR}
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
