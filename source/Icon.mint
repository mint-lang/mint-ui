/* A component to render SVG icons. */
component Ui.Icon {
  /* The click event handler. */
  property onClick : Function(Html.Event, Promise(Void)) = Promise.never1

  /* The size of the icon. */
  property size : Ui.Size = Ui.Size::Inherit

  /* Whether or not the icon can be interacted with. */
  property interactive : Bool = false

  /* Whether or not the icon is disabled. */
  property disabled : Bool = false

  /* The opacity of the icon. */
  property opacity : Number = 1

  /* The actual SVG icon. */
  property icon : Html = <></>

  /* If provided the icon will behave as an anchor to the specified URL. */
  property href : String = ""

  /* The styles for the icon. */
  style base {
    font-size: #{Ui.Size.toString(size)};
    justify-content: center;
    display: inline-flex;
    align-items: center;

    &:focus,
    &:hover {
      if actuallyInteractive {
        color: var(--primary-color);
      }
    }

    if disabled {
      cursor: not-allowed;
      opacity: 0.5;
    }

    svg {
      opacity: #{opacity};
      fill: currentColor;
      height: 1em;
      width: 1em;

      if actuallyInteractive {
        pointer-events: auto;
        cursor: pointer;
      } else {
        pointer-events: none;
        cursor: auto;
      }

      if disabled {
        pointer-events: none;
      }
    }
  }

  get actuallyInteractive {
    (interactive || String.isNotBlank(href)) && !disabled
  }

  /* The style for the link. */
  style link {
    color: inherit;
  }

  /* The style for the button. */
  style button {
    -webkit-tap-highlight-color: rgba(0,0,0,0);
    -webkit-touch-callout: none;
    -webkit-appearance: none;
    appearance: none;
    background: none;
    color: inherit;
    outline: 0;
    padding: 0;
    border: 0;
    margin: 0;
  }

  fun render : Html {
    if String.isNotBlank(href) {
      <a::base::link href={href}>
        <{ icon }>
      </a>
    } else if actuallyInteractive {
      <button::base::button onClick={Ui.disabledHandler(disabled, onClick)}>
        <{ icon }>
      </button>
    } else {
      <div::base onClick={Ui.disabledHandler(disabled, onClick)}>
        <{ icon }>
      </div>
    }
  }
}
