/* A Card is used to display data in sematically grouped way. */
component Ui.Card {
  /* The minimum width of the card. */
  property minWidth : Ui.Size = Ui.Size::Px(0)

  /* The size of the component. */
  property size : Ui.Size = Ui.Size::Inherit

  /* The child elements. */
  property children : Array(Html) = []

  /* Whether or not to draw a border around the card. */
  property bordered : Bool = false

  /* The target window of the URL. */
  property target : String = ""

  /* The URL to link the card to. */
  property href : String = ""

  /* Styles for the card. */
  style base {
    box-shadow: 0 0 0.625em var(--shadow-color);
    background: var(--content-color);
    color: var(--content-text);
    border-radius: 0.5em;

    flex-direction: column;
    display: flex;

    font-size: #{Ui.Size.toString(size)};
    text-decoration: none;

    min-width: #{Ui.Size.toString(minWidth)};
    outline: none;

    if (bordered) {
      border: 0.0625em solid var(--content-border);
    }

    > *:first-child {
      border-top-right-radius: inherit;
      border-top-left-radius: inherit;
    }

    > *:last-child {
      border-bottom-right-radius: inherit;
      border-bottom-left-radius: inherit;
    }
  }

  /* Additional styles for the card if it's a link. */
  style link {
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

  /* Renders the card. */
  fun render : Html {
    if (String.isBlank(href)) {
      <a::base>
        <{ children }>
      </a>
    } else {
      <a::base::link
        onDragStart={Html.Event.preventDefault}
        target={target}
        href={href}>

        <{ children }>

      </a>
    }
  }
}
