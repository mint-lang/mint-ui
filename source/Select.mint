/* A select component. */
component Ui.Select {
  /* The change event handler. */
  property onChange : Function(String, Promise(Void)) = Promise.never1

  /* The position of the dropdown. */
  property position : Ui.Position = Ui.Position.BottomRight

  /* The size of the select. */
  property size : Ui.Size = Ui.Size.Inherit

  /* The items to show. */
  property items : Array(Ui.ListItem) = []

  /* Whether or not the dropdown should match the width of the input. */
  property matchWidth : Bool = false

  /* The placeholder to show when there is no value selected. */
  property placeholder : String = ""

  /* Whether or not the select is disabled. */
  property disabled : Bool = false

  /* Whether or not the select is invalid. */
  property invalid : Bool = false

  /* The key of the current selected element. */
  property value : String = ""

  /* The offset of the dropdown from the input. */
  property offset : Number = 5

  /* Handles the keydown event. */
  fun handleKeyDown (event : Html.Event) {
    if let Maybe.Just(item) = list {
      item.handleKeyDown(event)
    }
  }

  /* Handles the click event. */
  fun handleClickSelect (value : String) : Promise(Void) {
    await onChange(value)

    if let Maybe.Just(item) = picker {
      item.hideDropdown()
    }
  }

  /* Renders the select. */
  fun render : Html {
    let panel =
      <Ui.InteractiveList as list
        onClickSelect={handleClickSelect}
        onSelect={onChange}
        interactive={false}
        size={size}
        selected={
          Set.empty()
          |> Set.add(value)
        }
        items={items}
      />

    let label =
      items
      |> Array.find(
        (item : Ui.ListItem) : Bool { Ui.ListItem.key(item) == value })
      |> Maybe.map((item : Ui.ListItem) { <div>Ui.ListItem.content(item)</div> })

    <Ui.Picker as picker
      icon={Ui.Icons.CHEVRON_DOWN}
      onKeyDown={handleKeyDown}
      placeholder={placeholder}
      matchWidth={matchWidth}
      disabled={disabled}
      position={position}
      invalid={invalid}
      offset={offset}
      panel={panel}
      label={label}
      size={size}
    />
  }
}
