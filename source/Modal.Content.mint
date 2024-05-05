/* The content part of a modal, with a title, content and actions. */
component Ui.Modal.Content {
  connect Ui exposing { mobile }

  /* The minimum width of the modal. */
  property minWidth : Ui.Size = Ui.Size.Em(17.5)

  /* The maximum width of the modal. */
  property maxWidth : Ui.Size = Ui.Size.Em(30)

  /* The size of the modal. */
  property size : Ui.Size = Ui.Size.Inherit

  /* The content to display in the body of the modal. */
  property content : Html = <></>

  /* The content to display in the footer of the modal. */
  property actions : Html = <></>

  /* The content to display in the title of the modal. */
  property title : Html = <></>

  /* The icon to display in the header. */
  property icon : Html = <></>

  /* Styles for the base element. */
  style base {
    max-width: #{Ui.Size.toString(maxWidth)};
    min-width: #{Ui.Size.toString(minWidth)};

    box-shadow: 0 0 1.25em var(--shadow-color);
    border-radius: 0.375em;

    font-size: #{Ui.Size.toString(size)};
    font-family: var(--font-family);

    position: relative;
    z-index: 1;

    flex-direction: column;
    display: flex;
  }

  /* Style for the header. */
  style header {
    border-bottom: 0.0625em solid var(--content-border);
    background: var(--content-faded-color);
    color: var(--content-faded-text);

    border-radius: 0.375em 0.375em 0 0;
    padding: 1em;

    align-items: center;
    display: flex;
  }

  /* Style for the title. */
  style title {
    font-size: 1.375em;
    margin-right: auto;
    font-weight: bold;

    if mobile {
      font-size: 1em;
    }
  }

  /* Style for the content. */
  style content {
    background: var(--content-color);
    color: var(--content-text);

    line-height: 1.5;
    padding: 1em;
    flex: 1;

    if mobile {
      min-width: 0;
    }
  }

  /* Style for the actions. */
  style actions {
    background: var(--content-faded-color);
    color: var(--content-faded-text);

    border-top: 0.0625em solid var(--content-border);
    border-radius: 0 0 0.375em 0.375em;
    padding: 1em;

    justify-content: flex-end;
    grid-auto-flow: column;
    grid-gap: 1em;
    display: grid;
  }

  /* Style for the icon. */
  style icon {
    border-right: 0.125em solid var(--content-faded-border);
    padding-right: 1em;
    margin-right: 1em;

    justify-content: center;
    align-items: center;
    display: flex;

    &:empty {
      display: none;
    }
  }

  /* Renders the component. */
  fun render : Html {
    <div::base>
      <div::header>
        if Html.isNotEmpty(icon) {
          <div::icon>
            <Ui.Icon
              size={Ui.Size.Em(1.375)}
              icon={icon}/>
          </div>
        }

        <div::title>
          title
        </div>

        <Ui.Icon
          onClick={(event : Html.Event) { Ui.Modal.cancel() }}
          interactive={true}
          icon={Ui.Icons.X}/>
      </div>

      <div::content>
        content
      </div>

      if Html.isNotEmpty(actions) {
        <div::actions>
          actions
        </div>
      }
    </div>
  }
}
