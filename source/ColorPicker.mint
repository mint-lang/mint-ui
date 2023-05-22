/* A color picker component. */
component Ui.ColorPicker {
  connect Ui exposing { darkMode }

  /* The change event handler. */
  property onChange : Function(Color, Promise(Void)) = Promise.never1

  /* The position of the dropdown. */
  property position : Ui.Position = Ui.Position::BottomRight

  /* The current value (as `Color`). */
  property value : Color = Color::HEX("000000FF")

  /* The size of the picker. */
  property size : Ui.Size = Ui.Size::Inherit

  /* Whether or not the picker is disabled. */
  property disabled : Bool = false

  /* Whether or not the picker is invalid. */
  property invalid : Bool = false

  /* The offset of the dropdown from the input. */
  property offset : Number = 5

  style rect {
    border-radius: 0.25em;
    height: 1.25em;
    width: 2.5em;

    background: linear-gradient(#{Color.toCSSHex(value)}, #{Color.toCSSHex(value)}),
                linear-gradient(45deg, var(--checker-color-1) 25%, transparent 25%, transparent 75%, var(--checker-color-1) 75%, var(--checker-color-1)),
                linear-gradient(45deg, var(--checker-color-1) 25%, transparent 25%, transparent 75%, var(--checker-color-1) 75%, var(--checker-color-1));

    background-position: 0 0, 0.625em 0.625em;
    background-color: var(--checker-color-2);
    background-size: 1.25em 1.25em;

    if darkMode {
      border: 0.0625em solid rgba(0,0,0,0.30);
    } else {
      border: 0.0625em solid rgba(0,0,0,0.15);
    }
  }

  style base {
    font-family: monospace;

    grid-template-columns: 1fr auto;
    align-items: center;
    grid-gap: 1em;
    display: grid;
  }

  /* Renders the date picker. */
  fun render : Html {
    let panel =
      <Ui.AvoidFocus disableCursor={false}>
        <Ui.ColorPanel
          onChange={onChange}
          embedded={true}
          value={value}
          size={size}/>
      </Ui.AvoidFocus>

    let label =
      Maybe::Just(
        <div::base>
          <span>
            <{ Color.toCSSHex(value) }>
          </span>

          <div::rect/>
        </div>)

    <Ui.Picker as picker
      matchWidth={false}
      disabled={disabled}
      position={position}
      invalid={invalid}
      offset={offset}
      panel={panel}
      label={label}
      icon={<></>}
      size={size}/>
  }
}
