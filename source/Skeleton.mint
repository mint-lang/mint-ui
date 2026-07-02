/* A loading placeholder that mimics the shape of content. */
component Ui.Skeleton {
  /* The size of the skeleton. */
  property size : Ui.Size = Ui.Size.Inherit

  /* The width of the skeleton (CSS value). */
  property width : String = "100%"

  /* The height of the skeleton (CSS value). */
  property height : String = "1em"

  /* The border radius of the skeleton (CSS value). */
  property borderRadius : String = "0.375em"

  /* Whether or not the skeleton is circular. */
  property circular : Bool = false

  /* Styles for the skeleton. */
  style base {
    font-size: #{Ui.Size.toString(size)};

    background: linear-gradient(
      90deg,
      var(--content-faded-color) 25%,
      var(--content-faded-border) 50%,
      var(--content-faded-color) 75%
    );

    background-size: 200% 100%;
    animation: shimmer 1.5s ease-in-out infinite;

    width: #{width};
    height: #{height};

    if circular {
      border-radius: 50%;
    } else {
      border-radius: #{borderRadius};
    }

    @keyframes shimmer {
      0% {
        background-position: 200% 0;
      }

      100% {
        background-position: -200% 0;
      }
    }
  }

  /* Renders the skeleton. */
  fun render : Html {
    <div::base aria-hidden="true"/>
  }
}
