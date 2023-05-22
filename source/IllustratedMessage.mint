component Ui.IllustratedMessage {
  connect Ui exposing { mobile }

  /* The size of the component. */
  property size : Ui.Size = Ui.Size::Inherit

  /* The subtitle to display. */
  property subtitle : Html = <></>

  /* The actions to display. */
  property actions : Html = <></>

  /* The image to display. */
  property image : Html = <></>

  /* The title to display. */
  property title : Html = <></>

  /* The styles for the base element. */
  style base {
    font-size: #{Ui.Size.toString(size)};
    justify-content: center;
    flex-direction: column;
    align-items: center;
    display: flex;
    flex: 1;

    if mobile {
      padding: 3em 1em;
    } else {
      padding: 4em 0;
    }
  }

  /* The styles for the title. */
  style title {
    font-family: var(--title-font-family);
    text-align: center;
    font-weight: bold;
    margin-top: 1em;

    if mobile {
      font-size: 1.5em;
    } else {
      font-size: 2em;
    }
  }

  /* The styles for the subtitle. */
  style subtitle {
    margin-bottom: 2em;
    margin-top: 0.5em;

    text-align: center;

    if mobile {
      font-size: 1em;
    } else {
      font-size: 1.25em;
    }
  }

  /* The styles for the image. */
  style image {
    display: grid;
  }

  /* The styles for the actions. */
  style actions {
    grid-auto-flow: column;
    display: grid;

    if mobile {
      grid-auto-flow: row;
      grid-gap: 1em;
    } else {
      grid-auto-flow: column;
      grid-gap: 2em;
    }
  }

  /* Renders the component. */
  fun render : Html {
    <div::base>
      if Html.isNotEmpty(image) {
        <div::image>
          <{ image }>
        </div>
      }

      if Html.isNotEmpty(title) {
        <div::title>
          <{ title }>
        </div>
      }

      if Html.isNotEmpty(subtitle) {
        <div::subtitle>
          <{ subtitle }>
        </div>
      }

      if Html.isNotEmpty(actions) {
        <div::actions>
          <{ actions }>
        </div>
      }
    </div>
  }
}
