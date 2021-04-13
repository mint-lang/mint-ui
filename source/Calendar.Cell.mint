/* This is a cell of the calendar component. */
component Ui.Calendar.Cell {
  /* The click event. */
  property onClick : Function(Time, Promise(Never, Void)) = Promise.never1

  /* The size of the component. */
  property size : Ui.Size = Ui.Size::Inherit

  /* Whether or not the cell is selected. */
  property selected : Bool = false

  /* Whether or not the component is disabled. */
  property disabled : Bool = false

  /* Whether or not the cell is active (selectable). */
  property active : Bool = false

  /* The day. */
  property day : Time

  /* Styles for the cell. */
  style base {
    font-size: #{Ui.Size.toString(size)};
    border-radius: 0.25em;

    justify-content: center;
    align-items: center;
    display: flex;

    cursor: pointer;
    height: 2em;
    width: 2em;

    if (active) {
      opacity: 1;
    } else {
      opacity: 0.2;
    }

    if (disabled) {
      pointer-events: none;
    }

    &:hover {
      background: var(--primary-color);
      color: var(--primary-text);
    }

    if (selected) {
      background: var(--primary-color);
      color: var(--primary-text);
    }
  }

  /* The click event handler. */
  fun handleClick (event : Html.Event) : Promise(Never, Void) {
    onClick(day)
  }

  /* Renders the component. */
  fun render : Html {
    <div::base
      title={Time.format("yyyy-MM-dd", day)}
      onClick={handleClick}>

      <{ Time.format("dd", day) }>

    </div>
  }
}
