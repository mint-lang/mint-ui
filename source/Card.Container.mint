/* This component is for showing structured content in a Card. */
component Ui.Card.Container {
  /* The size of the container. */
  property size : Ui.Size = Ui.Size::Inherit

  /* Where to align the text (center, left or right). */
  property textAlign : String = "left"

  /* The thumbnail image. */
  property thumbnail : String = ""

  /* The content for the subtitle field. */
  property subtitle : Html = <></>

  /* The content for the content field. */
  property content : Html = <></>

  /*
  The image to display on the left, if provided it's displayed instead
  of the thumbnail.
  */
  property image : Html = <></>

  /* The content for the title field. */
  property title : Html = <></>

  /* Styles for the base element. */
  style base {
    font-size: #{Ui.Size.toString(size)};
    font-family: var(--font-family);
    color: var(--content-text);
    text-align: #{textAlign};

    if hasImage {
      grid-template-columns: auto 1fr;
    } else {
      grid-template-columns: 1fr;
    }

    grid-template-rows: #{rows};
    grid-gap: 0.375em 1em;
    align-content: start;
    display: grid;

    padding: 1.25em;
    flex: 1;
  }

  /* Styles for the image. */
  style image {
    place-content: center;
    grid-row: span 2;
    display: grid;
  }

  /* Styles for the title. */
  style title {
    color: var(--title-color);
    font-size: 1.25em;
    font-weight: bold;
    line-height: 1.25;
  }

  /* Styles for the subtitle. */
  style subtitle {
    color: var(--content-text);
    font-size: 0.75em;
    line-height: 1.5;
  }

  /* Styles for the content. */
  style content {
    if hasImage {
      grid-column: span 2;
    }
  }

  /*
  Returns the value for the `grid-template-rows` CSS property based on the
  existence of the fields.
  */
  get rows : String {
    let size =
      [
        Html.isNotEmpty(title),
        Html.isNotEmpty(subtitle),
        Html.isNotEmpty(content)
      ]
      |> Array.select((item : Bool) { item })
      |> Array.size()

    "repeat(#{size}, auto)"
  }

  /* Returns whether or not to display an image. */
  get hasImage : Bool {
    String.isNotBlank(thumbnail) || Html.isNotEmpty(image)
  }

  /* Renders the component. */
  fun render : Html {
    <div::base>
      if hasImage {
        <div::image>
          if Html.isNotEmpty(image) {
            image
          } else {
            <Ui.Image
              height={Ui.Size::Em(3)}
              width={Ui.Size::Em(3)}
              src={thumbnail}/>
          }
        </div>
      }

      if Html.isNotEmpty(title) {
        <div::title>
          title
        </div>
      }

      if Html.isNotEmpty(subtitle) {
        <div::subtitle>
          subtitle
        </div>
      }

      if Html.isNotEmpty(content) {
        <div::content>
          <Ui.Content>
            content
          </Ui.Content>
        </div>
      }
    </div>
  }
}
