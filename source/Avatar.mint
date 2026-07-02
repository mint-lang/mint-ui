/* A user avatar component with image and initials fallback. */
component Ui.Avatar {
  /* The size of the avatar. */
  property size : Ui.Size = Ui.Size.Inherit

  /* The image source URL. */
  property src : String = ""

  /* The alt text for the image. */
  property alt : String = ""

  /* The initials to show as fallback when there is no image. */
  property initials : String = ""

  /* Whether or not the avatar has a circular shape. */
  property circular : Bool = true

  /* Styles for the avatar container. */
  style base {
    font-size: #{Ui.Size.toString(size)};
    font-family: var(--font-family);

    background: var(--primary-color);
    color: var(--primary-text);

    justify-content: center;
    display: inline-flex;
    align-items: center;

    overflow: hidden;
    height: 2.5em;
    width: 2.5em;

    if circular {
      border-radius: 50%;
    } else {
      border-radius: 0.375em;
    }
  }

  /* Styles for the image. */
  style image {
    object-fit: cover;
    height: 100%;
    width: 100%;
  }

  /* Styles for the fallback initials. */
  style fallback {
    text-transform: uppercase;
    font-weight: bold;
    font-size: 1em;
    line-height: 1;

    user-select: none;
  }

  /* Styles for the default icon fallback. */
  style icon {
    font-size: 1.25em;
    display: grid;
  }

  /* Renders the avatar. */
  fun render : Html {
    <div::base>
      if String.isNotBlank(src) {
        <img::image src={src} alt={alt}/>
      } else if String.isNotBlank(initials) {
        <span::fallback>initials</span>
      } else {
        <div::icon>
          <Ui.Icon icon={Ui.Icons.PERSON}/>
        </div>
      }
    </div>
  }
}
