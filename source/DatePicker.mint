/* A date picker component. */
component Ui.DatePicker {
  /* The change event handler. */
  property onChange : Function(Time, Promise(Void)) = Promise.never1

  /* The language to use for time formatting. */
  property language : Time.Format.Language = Time.Format.ENGLISH

  /* The position of the dropdown. */
  property position : Ui.Position = Ui.Position.BottomRight

  /* The size of the select. */
  property size : Ui.Size = Ui.Size.Inherit

  /* The current value (as `Time`). */
  property value : Time = Time.today()

  /* Whether or not the select is disabled. */
  property disabled : Bool = false

  /* Whether or not the select is invalid. */
  property invalid : Bool = false

  /* The offset of the dropdown from the input. */
  property offset : Number = 5

  /* The formatter for the time in the input. */
  property formatter = Time.format

  /* The format for the time in the input. */
  property format : String = "%Y-%m-%d"

  /* A variable for tracking the current month. */
  state month : Maybe(Time) = Maybe.Nothing

  style label {
    text-overflow: ellipsis;
    white-space: nowrap;
    overflow: hidden;
  }

  /* Handles the keydown event. */
  fun handleKeyDown (event : Html.Event) {
    case event.keyCode {
      37 =>
        onChange(
          `new Date(#{value}.getFullYear(), #{value}.getMonth(), #{value}.getDate() - 1)`)

      38 =>
        {
          Html.Event.preventDefault(event)

          onChange(
            `new Date(#{value}.getFullYear(), #{value}.getMonth(), #{value}.getDate() - 1)`)
        }

      39 =>
        onChange(
          `new Date(#{value}.getFullYear(), #{value}.getMonth(), #{value}.getDate() + 1)`)

      40 =>
        {
          Html.Event.preventDefault(event)

          onChange(
            `new Date(#{value}.getFullYear(), #{value}.getMonth(), #{value}.getDate() + 1)`)
        }

      => next { }
    }
  }

  /* Handles the month change event. */
  fun handleMonthChange (value : Time) {
    next { month: Maybe.Just(value) }
  }

  /* Renders the date picker. */
  fun render : Html {
    let panel =
      <Ui.AvoidFocus disableCursor={false}>
        <Ui.Calendar as calendar
          month={Maybe.withDefault(month, value)}
          onMonthChange={handleMonthChange}
          changeMonthOnSelect={true}
          onChange={onChange}
          embedded={true}
          day={value}
          size={size}
        />
      </Ui.AvoidFocus>

    let label =
      Maybe.Just(<div::label>formatter(value, language, format)</div>)

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
