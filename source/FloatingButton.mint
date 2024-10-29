/* A floating action button (FAB) represents the primary action of a screen. */
component Ui.FloatingButton {
  /* The click event handler. */
  property onClick : Function(Html.Event, Promise(Void)) = Promise.never1

  /* The size of the button. */
  property size : Ui.Size = Ui.Size.Em(3)

  /* The type of the button. */
  property type : String = "primary"

  /* The icon of the button. */
  property icon : Html

  /* The styles for the button. */
  style base {
    -webkit-tap-highlight-color: rgba(0,0,0,0);
    -webkit-touch-callout: none;
    -webkit-appearance: none;
    appearance: none;

    box-shadow: 0 0 0.2em rgba(0,0,0,0.25);
    border-radius: 50%;
    padding: 0;
    border: 0;
    margin: 0;

    cursor: pointer;
    outline: none;

    font-size: #{Ui.Size.toString(size)};
    height: 1em;
    width: 1em;

    justify-content: center;
    align-items: center;
    display: flex;

    case type {
      "secondary" =>
        background: var(--secondary-color);
        color: var(--secondary-text);

      "warning" =>
        background: var(--warning-color);
        color: var(--warning-text);

      "success" =>
        background: var(--success-color);
        color: var(--success-text);

      "primary" =>
        background: var(--primary-color);
        color: var(--primary-text);

      "danger" =>
        background: var(--danger-color);
        color: var(--danger-text);

      "faded" =>
        background: var(--faded-color);
        color: var(--faded-text);

      =>
    }

    &:focus::before {
      content: "";

      border-radius: 50%;
      position: absolute;
      bottom: 0.1875rem;
      right: 0.1875rem;
      left: 0.1875rem;
      top: 0.1875rem;

      case type {
        "secondary" => border: 0.125rem solid var(--secondary-focus-ring);
        "success" => border: 0.125rem solid var(--success-focus-ring);
        "warning" => border: 0.125rem solid var(--warning-focus-ring);
        "primary" => border: 0.125rem solid var(--primary-focus-ring);
        "danger" => border: 0.125rem solid var(--danger-focus-ring);
        "faded" => border: 0.125rem solid var(--faded-focus-ring);
        =>
      }
    }

    &:hover, &:focus {
      filter: brightness(0.8) contrast(1.5);
    }
  }

  /* Renders the button. */
  fun render : Html {
    <button::base onClick={onClick}>
      <Ui.Icon size={Ui.Size.Em(0.5)} icon={icon}/>
    </button>
  }
}
