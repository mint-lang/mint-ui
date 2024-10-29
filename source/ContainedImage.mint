/* A component to display an image contained in a variable size parent element. */
component Ui.ContainedImage {
  /* Called when the position and size is updated. */
  property onUpdate : Function(Ui.ContainedImage, Promise(Void)) = Promise.never1

  /* The padding to add to the container. */
  property padding : Number = 10

  /* The alt value for the image. */
  property alt : String = ""

  /* The source of the image. */
  property src : String

  /* We are using this provider to update the position and size. */
  use Provider.ElementSize { changes: UPDATE, element: base }

  /* Cache the update function so it doesn't go into an infinite loop. */
  const UPDATE = (dimensions : Dom.Dimensions) { update() }

  /* Styles for the base element. */
  style base {
    background: linear-gradient(45deg, var(--checker-color-1) 25%, transparent 25%, transparent 75%, var(--checker-color-1) 75%, var(--checker-color-1)),
                linear-gradient(45deg, var(--checker-color-1) 25%, transparent 25%, transparent 75%, var(--checker-color-1) 75%, var(--checker-color-1));

    background-size: 1.25em 1.25em, 1.25em 1.25em;
    background-position: 0 0, 0.625em 0.625em;
    background-color: var(--checker-color-2);
    position: relative;
    overflow: hidden;
  }

  /* Styles for the image. */
  style image {
    position: absolute;
  }

  /* Sets the position and size of the image to be contained in the container. */
  fun update : Promise(Void) {
    let Maybe.Just(root) =
      base or return next { }

    let dimensions =
      Dom.getDimensions(root)

    let Maybe.Just(element) =
      image or return next { }

    let imageDimensions =
      Dom.getDimensions(element)

    let naturalWidth =
      `#{element}.naturalWidth`

    let naturalHeight =
      `#{element}.naturalHeight`

    let height =
      Math.min(
        Math.min(dimensions.width * (naturalHeight / naturalWidth),
          dimensions.height), naturalHeight) - (padding * 2)

    let width =
      Math.min(
        Math.min(dimensions.height * (naturalWidth / naturalHeight),
          dimensions.width), naturalWidth) - (padding * 2)

    let left =
      (dimensions.width - width) / 2

    let top =
      (dimensions.height - height) / 2

    element
    |> Dom.setStyle("height", "#{height}px")
    |> Dom.setStyle("width", "#{width}px")
    |> Dom.setStyle("left", "#{left}px")
    |> Dom.setStyle("top", "#{top}px")

    onUpdate(
      {
        originalHeight: naturalHeight,
        originalWidth: naturalWidth,
        currentWidth: width,
        currentHeight: height,
        left: left,
        top: top
      })
  }

  /* Renders the component. */
  fun render : Html {
    <div::base as base>
      <img::image as image onLoad={update} alt={alt} src={src}/>
    </div>
  }
}
