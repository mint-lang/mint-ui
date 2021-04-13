/* An image component. */
component Ui.Image {
  connect Ui exposing { images, setImageLoaded }

  /* The value for the `object-position` CSS property. */
  property objectPosition : String = "center"

  /* The value for the `object-fit` CSS property. */
  property objectFit : String = "cover"

  /* The value for the `border-radius` CSS property. */
  property borderRadius : String = ""

  /* Whether or not the image fills the width of it's parent element. */
  property fullWidth : Bool = false

  /* Wehter or not the image is draggable using browser drag & drop. */
  property draggable : Bool = false

  /* The height of the image. */
  property height : Ui.Size = Ui.Size::Px(100)

  /* The width of the image. */
  property width : Ui.Size = Ui.Size::Px(100)

  /* The source of the image. */
  property src : String = ""

  /* The alt attribute for the image. */
  property alt : String = ""

  /* Whether or not the image is visible. */
  state visible : Bool = false

  /* Whether or not the image is loaded. */
  state loaded : Bool = false

  use Provider.Intersection {
    rootMargin = "50px",
    treshold = 0.01,
    element = base,
    callback =
      (ratio : Number) {
        if (ratio > 0) {
          next { visible = true }
        } else {
          next {  }
        }
      }
  } when {
    !visible
  }

  /* The style for the image. */
  style image {
    object-position: #{objectPosition};
    object-fit: #{objectFit};

    transition: opacity 200ms;
    border-radius: inherit;
    height: inherit;
    display: block;
    width: inherit;

    if (Set.has(src, images) || loaded) {
      opacity: 1;
    } else {
      opacity: 0;
    }
  }

  /* The style for the base. */
  style base {
    background: var(--content-faded-color);
    height: #{Ui.Size.toString(height)};

    if (fullWidth) {
      width: 100%;
    } else {
      width: #{Ui.Size.toString(width)};
    }

    if (String.isBlank(borderRadius)) {
      border-radius: 0.15em;
    } else {
      border-radius: #{borderRadius};
    }
  }

  /* The load event handler. */
  fun handleLoad : Promise(Never, Void) {
    if (Set.has(src, images)) {
      next {  }
    } else {
      sequence {
        setImageLoaded(src)
        next { loaded = true }
      }
    }
  }

  /* The drag start event handler. */
  fun handleDragStart (event : Html.Event) : Void {
    if (draggable) {
      void
    } else {
      Html.Event.preventDefault(event)
    }
  }

  /* Renders the image. */
  fun render : Html {
    <div::base as base>
      if (visible) {
        <img::image
          onDragStart={handleDragStart}
          onLoad={handleLoad}
          alt={alt}
          src={src}/>
      }
    </div>
  }
}
