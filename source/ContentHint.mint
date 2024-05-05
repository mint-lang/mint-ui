/* A highlighted hint for some content. */
component Ui.ContentHint {
  connect Ui exposing { mobile }

  /* The size of the component. */
  property size : Ui.Size = Ui.Size.Inherit

  /* The children to display. */
  property children : Array(Html) = []

  /* The type. */
  property type : String = "primary"

  /* The icon to display. */
  property icon : Html = <></>

  /* The styles for the base. */
  style base {
    box-shadow: 0 0 0.625em var(--shadow-color);
    font-size: #{Ui.Size.toString(size)};
    border-radius: 0.5em;

    grid-template-columns: auto 1fr;
    align-items: center;
    display: grid;

    case type {
      "primary" =>
        background: var(--primary-light-color);
        color: var(--primary-light-text);

      "warning" =>
        background: var(--warning-light-color);
        color: var(--warning-light-text);

      "success" =>
        background: var(--success-light-color);
        color: var(--success-light-text);

      "danger" =>
        background: var(--danger-light-color);
        color: var(--danger-light-text);

      "secondary" =>
        background: var(--secondary-light-color);
        color: var(--secondary-light-text);

      "faded" =>
        background: var(--faded-light-color);
        color: var(--faded-light-text);

      =>
    }
  }

  /* The style for the icon. */
  style icon {
    border-radius: 0.25em 0 0 0.25em;
    align-self: stretch;

    align-items: center;
    display: grid;

    padding: 0.5em 0.75em;
    font-size: 2em;

    case type {
      "primary" =>
        background: var(--primary-color);
        color: var(--primary-text);

      "warning" =>
        background: var(--warning-color);
        color: var(--warning-text);

      "success" =>
        background: var(--success-color);
        color: var(--success-text);

      "danger" =>
        background: var(--danger-color);
        color: var(--danger-text);

      "secondary" =>
        background: var(--secondary-color);
        color: var(--secondary-text);

      "faded" =>
        background: var(--faded-color);
        color: var(--faded-text);

      =>
    }
  }

  /* Style for the content. */
  style content {
    line-height: 150%;
    padding: 1.25em;

    if mobile {
      padding: 0.75em;
    }
  }

  /* Renders the hint. */
  fun render : Html {
    <div::base>
      <div::icon>
        <Ui.Icon icon={icon}/>
      </div>

      <div::content>
        children
      </div>
    </div>
  }
}
