/* A simple slider component. */
component Ui.Slider {
  /* The drag end event handler. */
  property onDragEnd : Function(Number, Promise(Void)) = Promise.never1

  /* The change event handler. */
  property onChange : Function(Number, Promise(Void)) = Promise.never1

  /* The size of the slider. */
  property size : Ui.Size = Ui.Size.Inherit

  /* Whether or not the slider is disabled. */
  property disabled : Bool = false

  /* The maximum value for the slider. */
  property max : Number = 100

  /* The minimum value for the slider. */
  property min : Number = 0

  /* The current value of the slider. */
  property value : Number = 0

  /* The number that specifies the granularity that the value must adhere to. */
  property step : Number = 1

  /* Style for the slider. */
  style base {
    -webkit-appearance: none;
    box-sizing: border-box;

    font-size: #{Ui.Size.toString(size)};
    background: transparent;
    vertical-align: middle;
    cursor: pointer;
    width: 100%;
    padding: 0;
    margin: 0;

    &::-webkit-slider-thumb {
      -webkit-appearance: none;
      margin-top: -0.26875em;
    }

    &::-webkit-slider-thumb, &::-moz-range-thumb, &::-ms-thumb {
      background-color: var(--primary-color);
      box-sizing: border-box;
      border-radius: 0.2em;
      height: 1.125em;
      width: 0.85em;
      border: 0;
    }

    &:focus::-webkit-slider-thumb, &:focus::-moz-range-thumb, &:focus::-ms-thumb {
      background-color: var(--primary-color);
    }

    &::-webkit-slider-runnable-track, &::-moz-range-track, &::-ms-track {
      border: 0.0625em solid var(--input-border);
      background-color: var(--input-color);
      box-sizing: border-box;
      border-radius: 0.2em;
      height: 0.625em;

      /* This is the progress indicator. */
      background-image: linear-gradient(var(--primary-color), var(--primary-color));
      background-size: calc(#{(value - min) / (max - min) * 100}%) calc(100% - 0.25em);
      background-position-y: 0.125em;
      background-position-x: 0.125em;
      background-repeat: no-repeat;
    }

    &:focus::-webkit-slider-runnable-track, &:focus::-moz-range-track,
      &:focus::-ms-track {
      background-color: var(--input-focus-color);
      border-color: var(--input-focus-border);
      color: var(--input-focus-text);
    }

    &:focus {
      outline: none;
    }

    &::-moz-focus-outer {
      border: 0;
    }

    &:disabled {
      filter: saturate(0) brightness(0.8) contrast(0.5);
      cursor: not-allowed;
      user-select: none;
    }
  }

  /* The input event handler. */
  fun handleInput (event : Html.Event) : Promise(Void) {
    await event.target
    |> Dom.getValue()
    |> Number.fromString()
    |> Maybe.withDefault(0)
    |> onChange()

    /* This triggers a re-render so the silder is always in sync. */
    next { }
  }

  /* The input event handler. */
  fun handleChange (event : Html.Event) : Promise(Void) {
    await event.target
    |> Dom.getValue()
    |> Number.fromString()
    |> Maybe.withDefault(0)
    |> onDragEnd()

    /* This triggers a re-render so the silder is always in sync. */
    next { }
  }

  /* Renders the slider. */
  fun render : Html {
    <input::base
      value={Number.toString(value)}
      step={Number.toString(step)}
      max={Number.toString(max)}
      min={Number.toString(min)}
      onChange={handleChange}
      onInput={handleInput}
      disabled={disabled}
      type="range"
    />
  }
}
