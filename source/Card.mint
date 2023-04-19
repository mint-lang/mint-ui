/* A Card is used to display data in sematically grouped way. */
component Ui.Card {
  /* The click event handler. */
  property onClick : Maybe(Function(Html.Event, Promise(Void))) = Maybe::Nothing

  /* The minimum width of the card. */
  property minWidth : Ui.Size = Ui.Size::Px(0)

  /* The size of the component. */
  property size : Ui.Size = Ui.Size::Inherit

  /* The child elements. */
  property children : Array(Html) = []

  /* Whether or not to draw a border around the card. */
  property bordered : Bool = false

  /* Whether or not the card is active (has a highlighted border). */
  property active : Bool = false

  /* The target window of the URL. */
  property target : String = ""

  /* The URL to link the card to. */
  property href : String = ""

  /* Styles for the card. */
  style base {
    background: var(--content-color);
    color: var(--content-text);
    border-radius: 0.5em;

    flex-direction: column;
    display: flex;

    font-size: #{Ui.Size.toString(size)};
    text-decoration: none;

    min-width: #{Ui.Size.toString(minWidth)};
    outline: none;

    > *:first-child {
      border-top-right-radius: inherit;
      border-top-left-radius: inherit;
    }

    > *:last-child {
      border-bottom-right-radius: inherit;
      border-bottom-left-radius: inherit;
    }
  }

  /* Additional styles for the card if it has focus. */
  style focus {
    /* Removes the dotted focus ring in Firefox. */
    &::-moz-focus-inner {
      border: 0;
    }

    &:hover,
    &:focus {
      if (bordered) {
        border: 0.0625em solid var(--primary-color);

        box-shadow: 0 0 0 0.125em var(--primary-color),
                    0 0 0.625em var(--shadow-color);
      } else {
        box-shadow: 0 0 0 0.1875em var(--primary-color),
                    0 0 0.625em var(--shadow-color);
      }

      cursor: pointer;
    }
  }

  /* Reset for the buttons. */
  style button {
    font-size: inherit;
    text-align: left;
    color: inherit;

    appearance: none;
    background: none;
    display: block;
    outline: none;
    width: 100%;
    padding: 0;

    border: 0;
    border-radius: 0.5em;
  }

  /* Common styles. */
  style common {
    box-sizing: border-box;

    if (bordered) {
      border: 0.0625em solid var(--content-border);
    }

    if (active && bordered) {
      border: 0.0625em solid var(--primary-color);

      box-shadow: 0 0 0 0.125em var(--primary-color),
                  0 0 0.625em var(--shadow-color);
    } else if (active) {
      box-shadow: 0 0 0 0.1875em var(--primary-color),
                  0 0 0.625em var(--shadow-color);
    } else {
      box-shadow: 0 0 0.625em var(--shadow-color);
    }
  }

  /* Renders the card. */
  fun render : Html {
    if (String.isBlank(href)) {
      case (onClick) {
        Maybe::Just(handler) =>
          <button::common::button::focus onClick={handler}>
            <div::base>
              <{ children }>
            </div>
          </button>

        Maybe::Nothing =>
          <a::common::base>
            <{ children }>
          </a>
      }
    } else {
      <a::common::base::focus
        onDragStart={Html.Event.preventDefault}
        target={target}
        href={href}>

        <{ children }>

      </a>
    }
  }
}
