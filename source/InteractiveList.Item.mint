/* A component to display a `Ui.ListItem` for the interactive list. */
component Ui.InteractiveList.Item {
  /* The click event handler. */
  property onClick : Function(Html.Event, Promise(Void)) = Promise.never1

  /* The size of the item. */
  property size : Ui.Size = Ui.Size.Inherit

  /* The content to render. */
  property children : Array(Html) = []

  /* Whether or not the item is intended. */
  property intended : Bool = false

  /* Whether or not the item is selected. */
  property selected : Bool = false

  /* Styles for the base. */
  style base {
    font-size: #{Ui.Size.toString(size)};
    border-radius: 0.25em;

    user-select: none;
    padding: 0.625em;
    cursor: pointer;

    grid-auto-flow: column;
    justify-content: start;
    align-items: center;
    grid-gap: 0.25em;
    display: grid;

    if selected {
      background: var(--primary-color);
      color: var(--primary-text);
    } else {
      background: var(--content-color);
      color: var(--content-text);
    }

    &:hover {
      background: var(--primary-color);
      color: var(--primary-text);

      if selected {
        filter: brightness(0.8) contrast(1.5);
      }
    }
  }

  /* Renders the item. */
  fun render : Html {
    <div::base onClick={onClick}>
      if intended {
        <Ui.Icon icon={Ui.Icons.CHEVRON_RIGHT}/>
      }

      children
    </div>
  }
}
