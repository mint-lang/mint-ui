/* A date picker component. */
component Ui.DatePicker {
  /* The change event handler. */
  property onChange : Function(Time, Promise(Never, Void)) = Promise.never1

  /* The position of the dropdown. */
  property position : Ui.Position = Ui.Position::BottomRight

  /* The size of the select. */
  property size : Ui.Size = Ui.Size::Inherit

  /* The current value (as `Time`). */
  property value : Time = Time.today()

  /* Whether or not the select is disabled. */
  property disabled : Bool = false

  /* Whether or not the select is invalid. */
  property invalid : Bool = false

  /* The offset of the dropdown from the input. */
  property offset : Number = 5

  /* A variable for tracking the current month. */
  state month : Maybe(Time) = Maybe::Nothing

  style label {
    text-overflow: ellipsis;
    white-space: nowrap;
    overflow: hidden;
  }

  /* Handles the keydown event. */
  fun handleKeyDown (event : Html.Event) {
    case (event.keyCode) {
      37 => onChange(`new Date(#{value}.getFullYear(), #{value}.getMonth(), #{value}.getDate() - 1)`)

      38 =>
        try {
          Html.Event.preventDefault(event)
          onChange(`new Date(#{value}.getFullYear(), #{value}.getMonth(), #{value}.getDate() - 1)`)
        }

      39 => onChange(`new Date(#{value}.getFullYear(), #{value}.getMonth(), #{value}.getDate() + 1)`)

      40 =>
        try {
          Html.Event.preventDefault(event)
          onChange(`new Date(#{value}.getFullYear(), #{value}.getMonth(), #{value}.getDate() + 1)`)
        }

      => next { }
    }
  }

  /* Handles the month change event. */
  fun handleMonthChange (value : Time) {
    next { month = Maybe::Just(value) }
  }

  /* Renders the date picker. */
  fun render : Html {
    try {
      panel =
        <Ui.AvoidFocus disableCursor={false}>
          <Ui.Calendar as calendar
            month={Maybe.withDefault(value, month)}
            onMonthChange={handleMonthChange}
            changeMonthOnSelect={true}
            onChange={onChange}
            embedded={true}
            day={value}
            size={size}/>
        </Ui.AvoidFocus>

      label =
        Maybe::Just(
          <div::label>
            <{ Time.format("yyyy-MM-dd", value) }>
          </div>)

      <Ui.Picker as picker
        icon={Ui.Icons:CALENDAR}
        onKeyDown={handleKeyDown}
        matchWidth={false}
        disabled={disabled}
        invalid={invalid}
        position={position}
        offset={offset}
        panel={panel}
        label={label}
        size={size}/>
    }
  }
}
