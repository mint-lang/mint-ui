/* A tooltip component that shows a hint on hover. */
component Ui.Tooltip {
  /* The tooltip text to display. */
  property content : String = ""

  /* The position of the tooltip. */
  property position : Ui.Position = Ui.Position.TopCenter

  /* The size of the tooltip. */
  property size : Ui.Size = Ui.Size.Inherit

  /* The child element to wrap. */
  property children : Array(Html) = []

  /* The offset from the element. */
  property offset : Number = 8

  /* Whether or not the tooltip is visible. */
  state visible : Bool = false

  /* Styles for the tooltip wrapper. */
  style base {
    font-size: #{Ui.Size.toString(size)};
    display: inline-block;
    position: relative;
  }

  /* Styles for the tooltip content. */
  style tooltip {
    font-family: var(--font-family);
    background: var(--content-text);
    color: var(--content-color);

    border-radius: 0.375em;
    padding: 0.375em 0.625em;

    pointer-events: none;
    position: absolute;
    white-space: nowrap;
    font-size: 0.8125em;
    line-height: 1.4;
    z-index: 1000;

    if visible {
      transition: opacity 150ms 0ms ease;
      opacity: 1;
    } else {
      transition: opacity 150ms 0ms ease;
      opacity: 0;
    }

    case position {
      Ui.Position.TopCenter =>
        {
          transform: translateX(-50%);
          bottom: calc(100% + #{offset}px);
          left: 50%;
        }

      Ui.Position.TopLeft =>
        {
          bottom: calc(100% + #{offset}px);
          left: 0;
        }

      Ui.Position.TopRight =>
        {
          bottom: calc(100% + #{offset}px);
          right: 0;
        }

      Ui.Position.BottomCenter =>
        {
          transform: translateX(-50%);
          top: calc(100% + #{offset}px);
          left: 50%;
        }

      Ui.Position.BottomLeft =>
        {
          top: calc(100% + #{offset}px);
          left: 0;
        }

      Ui.Position.BottomRight =>
        {
          top: calc(100% + #{offset}px);
          right: 0;
        }

      Ui.Position.LeftCenter =>
        {
          transform: translateY(-50%);
          right: calc(100% + #{offset}px);
          top: 50%;
        }

      Ui.Position.LeftTop =>
        {
          right: calc(100% + #{offset}px);
          top: 0;
        }

      Ui.Position.LeftBottom =>
        {
          right: calc(100% + #{offset}px);
          bottom: 0;
        }

      Ui.Position.RightCenter =>
        {
          transform: translateY(-50%);
          left: calc(100% + #{offset}px);
          top: 50%;
        }

      Ui.Position.RightTop =>
        {
          left: calc(100% + #{offset}px);
          top: 0;
        }

      Ui.Position.RightBottom =>
        {
          left: calc(100% + #{offset}px);
          bottom: 0;
        }
    }
  }

  /* Shows the tooltip. */
  fun handleMouseEnter (event : Html.Event) : Promise(Void) {
    next { visible: true }
  }

  /* Hides the tooltip. */
  fun handleMouseLeave (event : Html.Event) : Promise(Void) {
    next { visible: false }
  }

  /* Renders the tooltip. */
  fun render : Html {
    <div::base
      onMouseEnter={handleMouseEnter}
      onMouseLeave={handleMouseLeave}>

      children

      if String.isNotBlank(content) {
        <div::tooltip role="tooltip">content</div>
      }
    </div>
  }
}
