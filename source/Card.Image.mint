/* This component is for displaying an image in a card. */
component Ui.Card.Image {
  /* The value for the `object-position` CSS property. */
  property objectPosition : String = "center"

  /* The value for the `object-fit` CSS property. */
  property objectFit : String = "cover"

  /* The height of the image. */
  property height : Ui.Size = Ui.Size::Em(10)

  /* The URL for the image. */
  property src : String = ""

  /* Renders the image. */
  fun render : Html {
    <Ui.Image
      objectPosition={objectPosition}
      objectFit={objectFit}
      borderRadius="0"
      fullWidth={true}
      height={height}
      src={src}/>
  }
}
