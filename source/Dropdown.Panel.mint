/* This component is usually used inside of a dropdown. */
component Ui.Dropdown.Panel {
  connect Ui exposing { mobile }

  /* The size of the panel. */
  property size : Ui.Size = Ui.Size::Inherit

  /* The children to display. */
  property children : Array(Html) = []

  /* The width of the panel. */
  property width : String = "auto"

  /* The title of the panel. */
  property title : Html = <></>

  /* Styles for the panel. */
  style base {
    box-shadow: 0 0.125em 0.625em -0.125em var(--shadow-color);
    border: 0.0625em solid var(--content-border);
    border-radius: 0.5em;
    width: #{width};

    background: var(--content-color);
    color: var(--content-text);

    font-size: #{Ui.Size.toString(size)};
    font-family: var(--font-family);
  }

  /* Styles for the title. */
  style title {
    border-bottom: 0.0714em solid var(--input-border);
    border-radius: 0.5em 0.5em 0 0;
    padding: 0.5714em 0.85714em;

    background: var(--input-color);
    color: var(--input-text);

    font-size: 0.875em;
    font-weight: bold;
  }

  /* Styles for the content. */
  style content {
    padding: 0.75em;
  }

  /* Renders the panel. */
  fun render : Html {
    <div::base as base>
      if (Html.isNotEmpty(title)) {
        <div::title>
          <{ title }>
        </div>
      }

      <div::content>
        <{ children }>
      </div>
    </div>
  }
}
