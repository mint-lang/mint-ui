/* A component for displaying a notification. */
component Ui.Notification {
  /* The content to display in the notification. */
  property content : Html = <{  }>

  /* The duration of the notification. */
  property duration : Number = 0

  /* A state for tracking the whether or not the notification is shown. */
  state shown : Bool = false

  /* Styles for the base element. */
  style base {
    height: #{height}px;
    overflow: visible;

    if (shown) {
      transition: transform 320ms;
      transform: translateX(0);
      margin-bottom: 10px;
    } else {
      transform: translateX(150%);
      margin-bottom: 0;

      transition: margin-bottom 320ms 200ms,
                  height 320ms 200ms,
                  transform 320ms;
    }
  }

  /* Styles for the content. */
  style content {
    box-shadow: 0 0 1em rgba(0, 0, 0, 0.2);
    background: rgba(25, 25, 25, 0.985);
    padding: 0.75em 1.5em 0.85em;
    border-radius: 0.5em;
    position: relative;
    overflow: hidden;
    cursor: pointer;
    display: block;

    font-family: var(--font-family);
    font-weight: 600;
    color: white;

    @media (max-width: 900px) {
      font-size: 0.875em;
    }

    &::before {
      animation: duration-notification linear both #{duration}ms;
      background: var(--primary-color);
      content: "";

      position: absolute;
      height: 0.1875em;
      display: block;
      left: 0;
      top: 0;
    }

    @keyframes duration-notification {
      0% {
        width: 100%;
      }

      100% {
        width: 0;
      }
    }
  }

  /* Returns the height of the component in pixels. */
  get height : Number {
    if (shown) {
      base
      |> Maybe.map(Dom.getDimensions)
      |> Maybe.map(.height)
      |> Maybe.withDefault(0)
    } else {
      0
    }
  }

  /* Runs when the component is mounted. */
  fun componentDidMount : Promise(Never, Void) {
    sequence {
      /* Wait for the next frame so the component is rendered off-screen. */
      Timer.nextFrame("")
      next { shown = true }

      /* Wait for the duration plus the transition duration and some extra. */
      Timer.timeout(duration, "")
      next { shown = false }
    }
  }

  /* The click event handler. */
  fun handleClick : Promise(Never, Void) {
    next { shown = false }
  }

  /* Renders the component. */
  fun render : Html {
    <div::base>
      <div::content as base onClick={handleClick}>
        <{ content }>
      </div>
    </div>
  }
}
