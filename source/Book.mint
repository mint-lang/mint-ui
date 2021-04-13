/* A 3D book component. */
component Ui.Book {
  /* The perspective amount. */
  property perspective : Number = 700

  /* The border radius of the book. */
  property borderRadius : Number = 5

  /* The thickness of the book. */
  property thickness : Number = 20

  /* The rotation of the book. */
  property rotation : Number = 30

  /* The height of the book. */
  property height : Number = 300

  /* The width of the book. */
  property width : Number = 200

  /* The outward offset of the covers from the pages. */
  property offset : Number = 5

  /* The target window of the URL. */
  property target : String = ""

  /* The link for the anchor. */
  property href : String = ""

  /* The source of the image. */
  property src : String = ""

  /* The alt content for the image. */
  property alt : String = ""

  /* Styles for the base. */
  style base {
    perspective: #{perspective}px;
  }

  /* Style for the book. */
  style book {
    transform: translateZ(-#{thickness / 2}px) rotateY(-#{rotation}deg);
    transform-style: preserve-3d;
    position: relative;
    height: #{height}px;
    width: #{width}px;
    display: block;
  }

  /* Styles for the front cover. */
  style front {
    transform: rotateY(0deg) translateZ(#{thickness / 2}px);
    position: absolute;
  }

  /* Styles for the back cover. */
  style back {
    transform: rotateY(180deg) translateZ(#{thickness / 2}px);
    border-radius: #{borderRadius}px 0 0 #{borderRadius}px;
    height: #{height}px;
    position: absolute;
    width: #{width}px;
    background: #222;
  }

  /* Common styles for the left and right faces. */
  style left-right {
    left: calc(50% - #{thickness / 2}px);
    position: absolute;
  }

  /* Common styles for the top and bottom faces. */
  style top-bottom {
    width: calc(#{width}px - #{offset}px);
    top: calc(50% - #{thickness / 2}px);
    height: #{thickness}px;
    position: absolute;
    background: white;
  }

  /* Styles for the right face. */
  style right {
    transform: rotateY( 90deg) translateZ(#{width / 2}px) translateZ(-#{offset}px);
    height: calc(#{height}px - #{offset * 2}px);
    width: #{thickness}px;
    background: white;
    top: #{offset}px;
  }

  /* Styles for the left face. */
  style left {
    transform: rotateY(-90deg) translateZ(#{width / 2}px) translateZ(1px);
    width: calc(#{thickness}px + 2px);
    height: #{height}px;
    background: #222;
  }

  /* Styles for the top face. */
  style top {
    transform: rotateX( 90deg) translateZ(#{height / 2}px) translateZ(-#{offset}px);
  }

  /* Styles for the bottom face. */
  style bottom {
    transform: rotateX(-90deg) translateZ(#{height / 2}px) translateZ(-#{offset}px);
  }

  /* Styles for the cover image. */
  style image {
    border-radius: 0 #{borderRadius}px #{borderRadius}px 0;
    background: var(--content-color);
    height: #{height}px;
    width: #{width}px;
    display: block;

    object-position: center;
    object-fit: cover;
  }

  /* Renders the book. */
  fun render {
    try {
      contents =
        <>
          <div::front>
            <img::image
              alt={alt}
              src={src}/>
          </div>

          <div::back/>

          <div::left-right::right/>
          <div::left-right::left/>
          <div::top-bottom::bottom/>
          <div::top-bottom::top/>
        </>

      <div::base>
        if (String.isBlank(href)) {
          <a::book>
            <{ contents }>
          </a>
        } else {
          <a::book
            target={target}
            href={href}>

            <{ contents }>

          </a>
        }
      </div>
    }
  }
}
