/* A simple calendar component where the days can be selected. */
component Ui.Calendar {
  /* The month change event handler. */
  property onMonthChange : Function(Time, Promise(Never, Void)) = Promise.never1

  /* The change event handler. */
  property onChange : Function(Time, Promise(Never, Void)) = Promise.never1

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
    justify-content: space-between;
    white-space: nowrap;
    display: flex;
    line-height: 1;
  }

  /* Event handler for the cell click. */
  fun handleCellClick (day : Time) : Promise(Never, Void) {
    if (changeMonthOnSelect && Time.month(day) != Time.month(month)) {
      sequence {
        onMonthChange(Time.startOf("month", day))
        onChange(day)
      }
    } else {
      onChange(day)
    }
  }

  /* Event handler for the chevron left icon click. */
  fun handleChevronLeftClick (event : Html.Event) : Promise(Never, Void) {
    onMonthChange(Time.startOf("month", Time.previousMonth(month)))
  }

  /* Event handler for the chevron right icon click. */
  fun handleChevronRightClick (event : Html.Event) : Promise(Never, Void) {
    onMonthChange(Time.startOf("month", Time.nextMonth(month)))
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
          <{ Time.format("MMMM - yyyy", month) }>
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
            Time.range(Time.startOf("week", day), Time.endOf("week", day))

          for (day of range) {
            <div::dayName>
              <{ Time.format("eee", day) }>
            </div>
          }
        }
      </div>

      <div::table>
        try {
          startDate =
            month
            |> Time.startOf("month")
            |> Time.startOf("week")

          endDate =
            month
            |> Time.endOf("month")
            |> Time.endOf("week")

          days =
            Time.range(startDate, endDate)

          range =
            Time.endOf("month", month)
            |> Time.range(Time.startOf("month", month))

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
            <Ui.Calendar.Cell
              active={Array.any((item : Time) : Bool { cell == item }, range)}
              onClick={handleCellClick}
              selected={day == cell}
              day={cell}/>
          }
        }
      </div>
    </div>
  }
}
