/* A simple button like element which toggles light/dark mode. */
component Ui.DarkModeToggle {
  connect Ui exposing { darkMode, setDarkMode }

  /* The size of the content. */
  property size : Ui.Size = Ui.Size.Inherit

  /* Styles for the button. */
  style button {
    -webkit-tap-highlight-color: rgba(0,0,0,0);
    -webkit-touch-callout: none;
    -webkit-appearance: none;
    appearance: none;

    font-size: #{Ui.Size.toString(size)};

    position: relative;
    background: none;
    cursor: pointer;
    outline: none;
    padding: 0;
    margin: 0;
    border: 0;

    &:focus > *,
    &:hover > * {
      background: var(--primary-color);
      color: var(--primary-text);
    }
  }

  /* Styles for the button content. */
  style button-content {
    box-shadow: 0 0 0.625em var(--shadow-color);
    background: var(--secondary-color);
    color: var(--secondary-text);
    border-radius: 1.125em;
    height: 2.25em;
    width: 4.5em;

    grid-template-columns: 1fr 1fr;
    display: grid;
  }

  /* The style for the icon. */
  style icon {
    background: var(--content-color);
    color: var(--content-text);

    transition: left 320ms, transform 320ms;
    position: absolute;
    top: 0.125em;

    border-radius: 1em;
    content: "";
    height: 2em;
    width: 2em;

    justify-content: center;
    align-items: center;
    display: flex;

    if darkMode {
      transform: rotate(0);
      left: 0.125em;
    } else {
      transform: rotate(360deg);
      left: 2.375em;
    }
  }

  /* Toggles the mode. */
  fun toggle {
    setDarkMode(!darkMode)
  }

  /* Renders the component. */
  fun render {
    <button::button onClick={toggle}>
      <div::button-content>
        <Ui.Icon
          icon={Ui.Icons.MOON}
          opacity={0.5}/>

        <Ui.Icon
          icon={Ui.Icons.SUN}
          opacity={0.5}/>

        <div::icon>
          <Ui.Icon
            icon={
              if darkMode {
                Ui.Icons.MOON
              } else {
                Ui.Icons.SUN
              }
            }/>
        </div>
      </div>
    </button>
  }
}
