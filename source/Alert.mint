/* A status message component for displaying alerts. */
component Ui.Alert {
  /* The close event handler. If provided, a close button is shown. */
  property onClose : Function(Promise(Void)) = Promise.never

  /* The severity level of the alert. */
  property level : Ui.Alert.Level = Ui.Alert.Level.Info

  /* The size of the alert. */
  property size : Ui.Size = Ui.Size.Inherit

  /* The title of the alert. */
  property title : String = ""

  /* The message body of the alert. */
  property message : String = ""

  /* Whether or not the close button is shown. */
  property closeable : Bool = false

  /* Styles for the alert container. */
  style base {
    font-size: #{Ui.Size.toString(size)};
    font-family: var(--font-family);

    border-radius: 0.375em;
    padding: 0.75em 1em;

    display: grid;
    grid-template-columns: auto 1fr auto;
    align-items: start;
    grid-gap: 0.625em;

    case level {
      Ui.Alert.Level.Info =>
        {
          background: var(--primary-light-color);
          color: var(--primary-light-text);
          border: 0.0625em solid var(--primary-color);
        }

      Ui.Alert.Level.Success =>
        {
          background: var(--success-light-color);
          color: var(--success-light-text);
          border: 0.0625em solid var(--success-color);
        }

      Ui.Alert.Level.Warning =>
        {
          background: var(--warning-light-color);
          color: var(--warning-light-text);
          border: 0.0625em solid var(--warning-color);
        }

      Ui.Alert.Level.Danger =>
        {
          background: var(--danger-light-color);
          color: var(--danger-light-text);
          border: 0.0625em solid var(--danger-color);
        }
    }
  }

  /* Styles for the icon. */
  style icon {
    display: grid;
    align-items: center;
    font-size: 1.25em;
    line-height: 1;
    margin-top: 0.1em;
  }

  /* Styles for the content area. */
  style content {
    display: grid;
    grid-gap: 0.25em;
  }

  /* Styles for the title. */
  style title {
    font-weight: bold;
    line-height: 1.4;
  }

  /* Styles for the message. */
  style message {
    line-height: 1.4;
    font-size: 0.9375em;
  }

  /* Styles for the close button. */
  style close {
    -webkit-appearance: none;
    appearance: none;
    background: none;
    color: inherit;
    cursor: pointer;
    outline: none;
    padding: 0;
    border: 0;
    margin: 0;
    opacity: 0.6;

    display: grid;
    align-items: center;
    font-size: 1em;
    margin-top: 0.1em;

    &:hover {
      opacity: 1;
    }
  }

  /* Returns the appropriate icon for the alert level. */
  get levelIcon : Html {
    case level {
      Ui.Alert.Level.Info => Ui.Icons.INFO
      Ui.Alert.Level.Success => Ui.Icons.CHECK
      Ui.Alert.Level.Warning => Ui.Icons.ALERT
      Ui.Alert.Level.Danger => Ui.Icons.ALERT
    }
  }

  /* Handles the close button click. */
  fun handleClose (event : Html.Event) : Promise(Void) {
    onClose()
  }

  /* Renders the alert. */
  fun render : Html {
    <div::base role="alert">
      <div::icon>
        <Ui.Icon icon={levelIcon}/>
      </div>

      <div::content>
        if String.isNotBlank(title) {
          <div::title>title</div>
        }

        if String.isNotBlank(message) {
          <div::message>message</div>
        }
      </div>

      if closeable {
        <button::close onClick={handleClose}>
          <Ui.Icon icon={Ui.Icons.X}/>
        </button>
      }
    </div>
  }
}
