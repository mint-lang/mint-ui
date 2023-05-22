/*
A circular progress bar displaying progress as a circle
and the percentage and the actual values as text.
*/
component Ui.CircularProgress {
  /* The function to format the number into a string. */
  property format : Function(Number, String) = Number.toString

  /* The size of the component. */
  property size : Ui.Size = Ui.Size::Inherit

  /* The thickness of the bar. */
  property thickness : Number = 0.3125

  /* The current value. */
  property current : Number = 0

  /* The width of the component. */
  property width : Number = 12

  /* The maximum value. */
  property max : Number = 100

  /* Styles for the base element. */
  style base {
    font-size: #{Ui.Size.toString(size)};
    display: inline-grid;
    height: #{width}em;
    width: #{width}em;

    > * {
      height: inherit;
      width: inherit;

      grid-column: 1;
      grid-row: 1;
    }
  }

  /* Styles for the circles. */
  style circle-common {
    stroke-width: #{Math.clamp(0, width / 2, thickness)}em;
    fill: transparent;

    r: #{Math.max(width / 4, radius - thickness / 2)}em;
    cy: #{radius}em;
    cx: #{radius}em;
  }

  /* Styles for the progress circle. */
  style circle {
    stroke-dashoffset: #{circumfence - percent * circumfence}em;
    stroke-dasharray: #{circumfence}em #{circumfence}em;
    stroke: var(--primary-color);

    transform-origin: 50% 50%;
    transform: rotate(-90deg);
  }

  /* Styles for the background circle. */
  style circle-background {
    stroke: var(--background-color);
  }

  /* Styles for the text. */
  style text {
    justify-content: center;
    flex-direction: column;
    align-items: center;
    display: flex;
  }

  /* Styles for the percentage. */
  style percent {
    position: relative;
    font-size: 2em;

    &::after {
      position: absolute;
      right: -0.9em;
      top: 0.3em;

      font-weight: 500;
      font-size: 0.5em;
      content: "%";
    }
  }

  /* Styles for the values. */
  style values {
    font-size: 0.875em;
    opacity: 0.7;
  }

  /* Returns the current percentage. */
  get percent : Number {
    if max == 0 {
      0
    } else {
      Math.clamp(0, 1, current / max)
    }
  }

  /* Returns the radius of the circle. */
  get radius : Number {
    width / 2
  }

  /* Returns the circumfence of the circle. */
  get circumfence : Number {
    Math.max(width / 2, width - thickness) * `Math.PI`
  }

  /* Renders the component. */
  fun render : Html {
    <div::base>
      <svg>
        <circle::circle-common::circle-background/>
        <circle::circle-common::circle/>
      </svg>

      <div::text>
        <div::percent>"#{Math.round(percent * 100)}"</div>
        <div::values>"#{format(current)}/#{format(max)}"</div>
      </div>
    </div>
  }
}
