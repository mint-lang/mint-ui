/* A simple calendar component where the days can be selected. */
component Ui.Calendar {
  /* The month change event handler. */
  property onMonthChange : Function(Time, Promise(Never, Void)) = Promise.never1

  /* The change event handler. */
  property onChange : Function(Time, Promise(Never, Void)) = Promise.never1

  /* The language to use for time formatting. */
  property language : Time.Format.Language = Time.Format:ENGLISH

  /* The days to highlight as selected. */
  property selectedDays : Set(Time) = Set.empty()

  /* Whether or not to trigger the `onMonthChange` event if clicking on a day in an other month. */
  property changeMonthOnSelect : Bool = false

  /* The size of the component. */
  property size : Ui.Size = Ui.Size::Inherit

  /* The month to display. */
  property month : Time = Time.today()

  /* The selected day. */
  property day : Time = Time.today()

  /* Whether or not the calender is embedded (in a picker for example). */
  property embedded : Bool = false

  /* Whether or not the component is disabled. */
  property disabled : Bool = false

  /* Whether or not the component is readonly. */
  property readonly : Bool = false

  /* Styles for the base. */
  style base {
    -moz-user-select: none;
    user-select: none;

    font-size: #{Ui.Size.toString(size)};
    font-family: var(--font-family);

    grid-gap: 1em;
    display: grid;

    if (!embedded) {
      border: 0.0625em solid var(--input-border);
      background: var(--input-color);
      color: var(--input-text);
      border-radius: 0.375em;
      padding: 0.75em 1.25em;
    }

    if (disabled) {
      filter: saturate(0) brightness(0.8) contrast(0.5);
      cursor: not-allowed;
      user-select: none;
    }
  }

  /* Style for the table. */
  style table {
    grid-template-columns: repeat(7, 1fr);
    justify-items: center;
    align-items: center;
    grid-gap: 0.3125em;
    display: grid;
    width: 100%;

    if (disabled) {
      pointer-events: none;
    }
  }

  /* Style for the header. */
  style header {
    align-items: center;
    line-height: 2;
    display: flex;
  }

  /* Style for the text. */
  style text {
    text-align: center;
    font-weight: bold;
    flex: 1;
  }

  /* Style for the day name. */
  style dayName {
    text-transform: uppercase;
    text-align: center;
    font-weight: bold;
    font-size: 0.74em;
    opacity: 0.5;
    width: 2em;
  }

  /* Style for the day names. */
  style dayNames {
    justify-content: space-around;
    white-space: nowrap;
    display: flex;
    line-height: 1;
  }

  /* Event handler for the cell click. */
  fun handleCellClick (day : Time) : Promise(Never, Void) {
    if (changeMonthOnSelect && Time.month(day) != Time.month(month)) {
      sequence {
        onMonthChange(Time.atBeginningOfMonth(day))
        onChange(day)
      }
    } else {
      onChange(day)
    }
  }

  /* Event handler for the chevron left icon click. */
  fun handleChevronLeftClick (event : Html.Event) : Promise(Never, Void) {
    onMonthChange(Time.atBeginningOfMonth(Time.previousMonth(month)))
  }

  /* Event handler for the chevron right icon click. */
  fun handleChevronRightClick (event : Html.Event) : Promise(Never, Void) {
    onMonthChange(Time.atBeginningOfMonth(Time.nextMonth(month)))
  }

  /* Renders the component. */
  fun render : Html {
    <div::base>
      <div::header>
        <Ui.Icon
          onClick={handleChevronLeftClick}
          icon={Ui.Icons:CHEVRON_LEFT}
          disabled={disabled}
          interactive={true}/>

        <div::text>
          <{ Time.format(language, "%B - %Y", month) }>
        </div>

        <Ui.Icon
          onClick={handleChevronRightClick}
          icon={Ui.Icons:CHEVRON_RIGHT}
          disabled={disabled}
          interactive={true}/>
      </div>

      <div::dayNames>
        try {
          range =
            Time.range(Time.atBeginningOfWeek(day), Time.atEndOfWeek(day))

          for (day of range) {
            <div::dayName>
              <{ Time.format(language, "%a", day) }>
            </div>
          }
        }
      </div>

      <div::table>
        try {
          startDate =
            month
            |> Time.atBeginningOfMonth
            |> Time.atBeginningOfWeek

          endDate =
            month
            |> Time.atEndOfMonth
            |> Time.atEndOfWeek

          days =
            Time.range(startDate, endDate)

          range =
            month
            |> Time.atEndOfMonth
            |> Time.range(Time.atBeginningOfMonth(month))

          actualDays =
            case (Array.size(days)) {
              28 =>
                Time.range(
                  Time.previousWeek(startDate),
                  Time.nextWeek(endDate))

              35 =>
                Time.range(
                  startDate,
                  Time.nextWeek(endDate))

              => days
            }

          for (cell of actualDays) {
            try {
              normalizedDay =
                Time.atBeginningOfDay(day)

              normalizedCell =
                Time.atBeginningOfDay(cell)

              normalizedDays =
                Set.map(Time.atBeginningOfDay, selectedDays)

              selected =
                if (Set.size(normalizedDays) == 0) {
                  normalizedDay == normalizedCell
                } else {
                  Set.has(normalizedCell, normalizedDays)
                }

              <Ui.Calendar.Cell
                active={Array.any((item : Time) : Bool { normalizedCell == item }, range)}
                onClick={handleCellClick}
                day={normalizedCell}
                selected={selected}
                readonly={readonly}/>
            }
          }
        }
      </div>
    </div>
  }
}
