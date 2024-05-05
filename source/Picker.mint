/* A base component for implementing custom pickers (date, select). */
component Ui.Picker {
  connect Ui exposing { mobile }

  /* A handler for the keydown event if the picker is open or focused. */
  property onKeyDown : Function(Html.Event, Promise(Void)) = Promise.never1

  /* A handler for the enter event, if it returns true the picker is closed. */
  property onEnter : Function(Html.Event, Bool) = (event : Html.Event) { true }

  /* The position of the dropdown. */
  property position : Ui.Position = Ui.Position.BottomRight

  /* The icon to display at the right side of the label. */
  property icon : Html = Ui.Icons.CHEVRON_DOWN

  /* The label to display if there is a value. */
  property label : Maybe(Html) = Maybe.Nothing

  /* The size of the picker. */
  property size : Ui.Size = Ui.Size.Inherit

  /* The placeholder to show when there is no value selected. */
  property placeholder : String = ""

  /* Whether or not the dropdown should match the width of the input. */
  property matchWidth : Bool = false

  /* Whether or not the picker is disabled. */
  property disabled : Bool = false

  /* Whether or not the picker is invalid. */
  property invalid : Bool = false

  /* The content of the dropdown. */
  property panel : Html = <></>

  /* The offset of the dropdown from the input. */
  property offset : Number = 5

  /* Whether or not the dropdown is shown. */
  state status : Ui.Picker.Status = Ui.Picker.Status.Idle

  use Providers.TabFocus {
    onTabOut: handleClose,
    onTabIn: handleTabIn,
    element: element
  }

  use Provider.OutsideClick {
    elements: [element, Maybe.flatten(Maybe.map(dropdown, (dropdown : Ui.Dropdown.Panel) { dropdown.base }))],
    clicks: handleClicks
  } when {
    (status == Ui.Picker.Status.Focused ||
      status == Ui.Picker.Status.Open) && !mobile
  }

  use Provider.Keyboard {
    ups: (event : Html.Event) { next { } },
    downs: handleKeyDown
  } when {
    status == Ui.Picker.Status.Focused ||
      status == Ui.Picker.Status.Open
  }

  /* Handles the up events. */
  fun handleClicks : Promise(Void) {
    next { status: Ui.Picker.Status.Idle }
  }

  /* Handler for the tab in event. */
  fun handleTabIn : Promise(Void) {
    next { status: Ui.Picker.Status.Focused }
  }

  /* Handler for the close event. */
  fun handleClose : Promise(Void) {
    next { status: Ui.Picker.Status.Idle }
  }

  /* Hides the dropdown. */
  fun hideDropdown : Promise(Void) {
    next { status: Ui.Picker.Status.Focused }
  }

  /* Shows the dropdown. */
  fun showDropdown : Promise(Void) {
    next { status: Ui.Picker.Status.Open }
  }

  /* Handler for the focus event (shows the dropdown). */
  fun handleFocus (event : Html.Event) : Promise(Void) {
    await next { status: Ui.Picker.Status.Focused }
    await Timer.nextFrame()
    next { status: Ui.Picker.Status.Open }
  }

  /*
  Handles the keydown event:
  - on ESCAPE key it hides the dropdown
  - on ENTER key it hides the dropdown if the handler returns true
  - on SPACE key it shows the dropdown
  */
  fun handleKeyDown (event : Html.Event) {
    case event.keyCode {
      Html.Event.ESCAPE =>
        hideDropdown()

      Html.Event.ENTER =>
        if onEnter(event) {
          hideDropdown()
        } else {
          next { }
        }

      Html.Event.SPACE =>
        {
          Html.Event.preventDefault(event)
          showDropdown()
        }

      => onKeyDown(event)
    }
  }

  /* Returns if the picker is open. */
  get open : Bool {
    status == Ui.Picker.Status.Open
  }

  /* Returns if the picker is focused. */
  get focused : Bool {
    status == Ui.Picker.Status.Focused ||
      status == Ui.Picker.Status.Open
  }

  /* The styles for the element. */
  style element {
    border: 0.0625em solid var(--input-border);
    background: var(--input-color);
    color: var(--input-text);

    border-radius: 0.375em;
    padding: 0 0.875em;
    height: 2.75em;

    font-size: #{Ui.Size.toString(size)};
    font-family: sans-serif;
    line-height: 1.25em;

    box-sizing: border-box;
    position: relative;
    user-select: none;
    outline: none;

    display: grid;

    if disabled {
      filter: saturate(0) brightness(0.8) contrast(0.5);
      cursor: not-allowed;
      user-select: none;
    } else {
      cursor: pointer;
    }

    if invalid {
      border-color: var(--input-invalid-border);
      background: var(--input-invalid-color);
      color: var(--input-invalid-text);
    } else if open || focused {
      border-color: var(--input-focus-border);
      background: var(--input-focus-color);
      color: var(--input-focus-text);
    } else {
      border-color: var(--input-border);
      background: var(--input-color);
      color: var(--input-text);
    }
  }

  /* The styles for the placeholder. */
  style placeholder {
    user-select: none;
    opacity: 0.5;
  }

  /* The styles for the grid. */
  style grid {
    align-items: center;
    grid-gap: 0.625em;
    display: grid;

    if Html.isNotEmpty(icon) {
      grid-template-columns: 1fr min-content;
    }
  }

  /* Renders the component. */
  fun render : Html {
    let content =
      <Ui.Dropdown.Panel as dropdown size={size}>
        panel
      </Ui.Dropdown.Panel>

    let grid =
      <div::grid>
        Maybe.withDefault(
          label,
          <div::placeholder>
            placeholder
          </div>)

        if Html.isNotEmpty(icon) {
          <Ui.Icon icon={icon}/>
        } else {
          <></>
        }
      </div>

    let html =
      if disabled {
        <div::element>
          grid
        </div>
      } else {
        <div::element as element
          onMouseUp={handleFocus}
          tabindex="0">

          grid

        </div>
      }

    /*
    The onClick handler is needed to focus the element when clicking
    into the dropdown so it not loses focus.
    */
    <Ui.Dropdown
      onClose={handleClose}
      closeOnOutsideClick={true}
      matchWidth={matchWidth}
      position={position}
      content={content}
      offset={offset}
      element={html}
      open={open}/>
  }
}
