/* A control element to manipulate a color in the HSV space. */
component Ui.ColorPanel {
  connect Ui exposing { darkMode }

  /* The `change` event handler. */
  property onChange : Function(Color, Promise(Void)) = Promise.never1

  /* The `end` event handler. */
  property onEnd : Function(Promise(Void)) = Promise.never

  /* The value (color). */
  property value : Color = Color::HEX("000000FF")

  /* The size of the panel. */
  property size : Ui.Size = Ui.Size::Inherit

  /* Whether or not to embed the panel (remove border). */
  property embedded : Bool = false

  /* The state for storing the drag status. */
  state status : Ui.ColorPanel.Status = Ui.ColorPanel.Status::Idle

  /* State for the temporary saturation value. */
  state saturationString : Maybe(String) = Maybe::Nothing

  /* State for the temporary value value. */
  state valueString : Maybe(String) = Maybe::Nothing

  /* State for the temporary alpha value. */
  state alphaString : Maybe(String) = Maybe::Nothing

  /* State for the temporary hex value. */
  state hexString : Maybe(String) = Maybe::Nothing

  /* State for the temporary hue value. */
  state hueString : Maybe(String) = Maybe::Nothing

  /* The provider to track the pointer while dragging. */
  use Provider.Pointer {
    downs: Promise.never1,
    moves: moves,
    ups: ups
  } when {
    status != Ui.ColorPanel.Status::Idle
  }

  /* Styles for the panel itself. */
  style base {
    grid-template-areas: "rect hue" "alpha alpha";
    grid-template-columns: 13em 1em;
    grid-template-rows: 13em 1em;
    grid-gap: 1em;
    display: grid;
    width: 15em;

    font-size: #{Ui.Size.toString(size)};
    user-select: none;

    if embedded {
      padding: 0.25em;
    } else {
      border: 0.0625em solid var(--input-border);
      background-color: var(--input-color);
      border-radius: 0.375em;
      padding: 1em;
    }
  }

  /* Style for the value-saturation square. */
  style rect {
    background-image: linear-gradient(0deg, #000 0%, transparent 100%),
                      linear-gradient(90deg, #FFF 0%, rgba(0,0,0,0) 100%);

    background-color: hsl(#{Color.getHue(value)}, 100%, 50%);
    border: 0.0625em solid var(--input-border);
    background-clip: content-box;
    border-radius: 0.25em;
    position: relative;
    touch-action: none;
    grid-area: rect;
    cursor: move;
  }

  /* Style for the hue bar. */
  style hue {
    background: linear-gradient(to bottom, #F00 0%, #FF0 17%, #0F0 33%,#0FF 50%, #00F 67%, #F0F 83%, #F00 100%);
    background-clip: content-box;

    border: 0.0625em solid var(--input-border);
    border-radius: 0.25em;

    position: relative;
    cursor: row-resize;
    touch-action: none;
    grid-area: hue;
  }

  /* Style for the alpha bar. */
  style alpha {
    border: 0.0625em solid var(--input-border);
    border-radius: 0.25em;

    background-image: #{alphaGradient},
                      linear-gradient(45deg, #F5F5F5 25%, transparent 25%, transparent 75%, #F5F5F5 75%, #F5F5F5),
                      linear-gradient(45deg, #F5F5F5 25%, transparent 25%, transparent 75%, #F5F5F5 75%, #F5F5F5);

    background-position: 0 0, 0 0, 0.5em 0.5em;
    background-size: 100%, 1em 1em, 1em 1em;
    background-clip: content-box;
    background-color: #DDD;

    touch-action: none;
    position: relative;
    cursor: col-resize;
    grid-area: alpha;
  }

  /* Style for the inputs. */
  style inputs {
    grid-template-columns: 7em repeat(4, 1fr);
    grid-column: 1 / 3;
    grid-gap: 0.333em;
    display: grid;

    font-size: 0.75em;

    label {
      text-align: center;
    }

    input {
      font-family: monospace;
      font-size: 1.0875em;
      text-align: center;
      font-weight: bold;

      padding: 0.2em 0 0 0;

      if !embedded {
        background: var(--content-color);
      } else {
        background: var(--input-color);
      }
    }
  }

  /* Style for an input label. */
  style label {
    color: var(--input-text);
    margin-bottom: 0.15em;
    text-align: center;
    font-weight: bold;
  }

  /* Basic style of a handle. */
  style handle {
    background: rgba(102, 102, 102, 0.6);
    pointer-events: none;
    position: absolute;

    if darkMode {
      box-shadow: 0 0 0 0.125em rgba(255,255,255,0.75);
    } else {
      box-shadow: 0 0 0 0.125em rgba(0,0,0,0.45);
    }
  }

  /* Style for the value-saturation handle. */
  style rect-handle {
    transform: translate3d(0,0,0) translate(-50%,-50%);
    border-radius: 0.125em;
    height: 0.5em;
    width: 0.5em;

    left: #{Color.getSaturation(value)}%;
    top: #{100 - Color.getValue(value)}%;
  }

  /* Style for the hue handle. */
  style hue-handle {
    transform: translate3d(0,0,0) translateY(-50%);
    top: #{Color.getHue(value) / 360 * 100}%;
    border-radius: 0.125em;
    right: -0.125em;
    left: -0.125em;
    height: 0.4em;
  }

  /* Style for the alpha handle. */
  style alpha-handle {
    transform: translate3d(0,0,0) translateX(-50%);
    left: #{Color.getAlpha(value)}%;
    border-radius: 0.125em;
    bottom: -0.125em;
    top: -0.125em;
    width: 0.4em;
  }

  /* The computed value for the alpha gradient. */
  get alphaGradient : String {
    let color =
      value
      |> Color.setAlpha(100)
      |> Color.toCSSRGBA()

    "linear-gradient(90deg, transparent, " + color + ")"
  }

  /* The pointer up event handler. */
  fun ups (event : Html.Event) : Promise(Void) {
    await next { status: Ui.ColorPanel.Status::Idle }
    onEnd()
  }

  /* The pointer move event handler. */
  fun moves (event : Html.Event) : Promise(Void) {
    case status {
      Ui.ColorPanel.Status::ValueSaturationDragging(element) =>
        {
          let dimensions =
            Dom.getDimensions(element)

          let saturation =
            (event.pageX - `window.pageXOffset` - dimensions.left) / dimensions.width
            |> Math.clamp(0, 1)

          let val =
            (event.pageY - `window.pageYOffset` - dimensions.top) / dimensions.height
            |> Math.clamp(0, 1)

          let nextValue =
            value
            |> Color.setSaturation(saturation * 100)
            |> Color.setValue((1 - val) * 100)

          onChange(nextValue)
        }

      Ui.ColorPanel.Status::HueDragging(element) =>
        {
          let dimensions =
            Dom.getDimensions(element)

          let hue =
            (event.pageY - `window.pageYOffset` - dimensions.top) / dimensions.height
            |> Math.clamp(0, 1)

          let nextValue =
            value
            |> Color.setHue(hue * 360)

          onChange(nextValue)
        }

      Ui.ColorPanel.Status::AlphaDragging(element) =>
        {
          let dimensions =
            Dom.getDimensions(element)

          let alpha =
            (event.pageX - `window.pageXOffset` - dimensions.left) / dimensions.width
            |> Math.clamp(0, 1)

          let nextValue =
            value
            |> Color.setAlpha(Math.round(alpha * 100))

          onChange(nextValue)
        }

      Ui.ColorPanel.Status::Idle =>
        next { }
    }
  }

  /* The pointer down event handler on the value-saturation square. */
  fun handleRectPointerDown (event : Html.Event) : Promise(Void) {
    Html.Event.preventDefault(event)
    next { status: Ui.ColorPanel.Status::ValueSaturationDragging(event.target) }
  }

  /* The pointer down event handler on the hue bar. */
  fun handleHuePointerDown (event : Html.Event) : Promise(Void) {
    Html.Event.preventDefault(event)
    next { status: Ui.ColorPanel.Status::HueDragging(event.target) }
  }

  /* The pointer down event handler on the alpha bar. */
  fun handleAlphaPointerDown (event : Html.Event) : Promise(Void) {
    Html.Event.preventDefault(event)
    next { status: Ui.ColorPanel.Status::AlphaDragging(event.target) }
  }

  /* The change event handler for the hue input. */
  fun handleHue (raw : String) : Promise(Void) {
    next { hueString: Maybe::Just(raw) }
  }

  /* The blur event handler for the hue input. */
  fun updateHue : Promise(Void) {
    let newHue =
      hueString
      |> Maybe.map(Number.fromString)
      |> Maybe.flatten
      |> Maybe.withDefault(0)

    let newValue =
      Color.setHue(value, newHue)

    await next { hueString: Maybe::Nothing }
    onChange(newValue)
  }

  /* The change event handler for the value input. */
  fun handleValue (raw : String) : Promise(Void) {
    next { valueString: Maybe::Just(raw) }
  }

  /* The blur event handler for the value input. */
  fun updateValue : Promise(Void) {
    let newValue =
      valueString
      |> Maybe.map(Number.fromString)
      |> Maybe.flatten
      |> Maybe.withDefault(0)

    let nextValue =
      Color.setValue(value, newValue)

    await next { valueString: Maybe::Nothing }
    onChange(nextValue)
  }

  /* The change event handler for the saturation input. */
  fun handleSaturation (raw : String) : Promise(Void) {
    next { saturationString: Maybe::Just(raw) }
  }

  /* The blur event handler for the saturation input. */
  fun updateSaturation : Promise(Void) {
    let saturation =
      saturationString
      |> Maybe.map(Number.fromString)
      |> Maybe.flatten
      |> Maybe.withDefault(0)

    let newValue =
      Color.setSaturation(value, saturation)

    await next { saturationString: Maybe::Nothing }
    onChange(newValue)
  }

  /* The change event handler for the alpha input. */
  fun handleAlpha (raw : String) : Promise(Void) {
    next { alphaString: Maybe::Just(raw) }
  }

  /* The change event handler for the alpha input. */
  fun updateAlpha : Promise(Void) {
    let alpha =
      alphaString
      |> Maybe.map(Number.fromString)
      |> Maybe.flatten
      |> Maybe.withDefault(0)

    let newValue =
      Color.setAlpha(value, alpha)

    await next { alphaString: Maybe::Nothing }
    onChange(newValue)
  }

  /* The change event handler for the hex input. */
  fun handleHex (raw : String) : Promise(Void) {
    next { hexString: Maybe::Just(raw) }
  }

  /* The blur event handler for the hex input. */
  fun updateHex : Promise(Void) {
    let newValue =
      hexString
      |> Maybe.map(Color.fromHEX)
      |> Maybe.flatten
      |> Maybe.withDefault(value)

    await next { hexString: Maybe::Nothing }
    onChange(newValue)
  }

  /* Renders the panel. */
  fun render : Html {
    <div::base>
      <div::alpha as alphaElement onPointerDown={handleAlphaPointerDown}>
        <div::handle::alpha-handle/>
      </div>

      <div::rect as rectElement onPointerDown={handleRectPointerDown}>
        <div::handle::rect-handle/>
      </div>

      <div::hue as hueElement onPointerDown={handleHuePointerDown}>
        <div::handle::hue-handle/>
      </div>

      <div::inputs>
        <div>
          <div::label>"HEX"</div>

          <Ui.Input
            value={hexString or Color.toCSSHex(value)}
            onChange={handleHex}
            onBlur={updateHex}/>
        </div>

        <div>
          <div::label>"H"</div>

          <Ui.Input
            value={hueString or Number.toString(Math.round(Color.getHue(value)))}
            onChange={handleHue}
            onBlur={updateHue}/>
        </div>

        <div>
          <div::label>"S"</div>

          <Ui.Input
            value={saturationString or Number.toString(Math.round(Color.getSaturation(value)))}
            onChange={handleSaturation}
            onBlur={updateSaturation}/>
        </div>

        <div>
          <div::label>"V"</div>

          <Ui.Input
            value={valueString or Number.toString(Math.round(Color.getValue(value)))}
            onChange={handleValue}
            onBlur={updateValue}/>
        </div>

        <div>
          <div::label>"A"</div>

          <Ui.Input
            value={alphaString or Number.toString(Color.getAlpha(value))}
            onChange={handleAlpha}
            onBlur={updateAlpha}/>
        </div>
      </div>
    </div>
  }
}
