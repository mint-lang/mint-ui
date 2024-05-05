/* A panel that sticks to the given element. */
component Ui.StickyPanel {
  /* The position of the panel. */
  property position : Ui.Position = Ui.Position.BottomLeft

  /* A flag that decides if the position should be calculated on animation frames. */
  property shouldCalculate : Bool = true

  /* The element to position against. */
  property element : Html = Html.empty()

  /* The content to position. */
  property content : Html = Html.empty()

  /* The offset of the panel. */
  property offset : Number = 0

  /* If `true`, pointer events will pass through the panel. */
  property passThrough : Bool = false

  /* The `z-index` of the panel. */
  property zIndex : Number = 0

  /* Variable for the left position. */
  state left : Number = 0

  /* Variable for the right position. */
  state top : Number = 0

  use Provider.AnimationFrame {
    frames: updateDimensions
  } when {
    shouldCalculate
  }

  /* Styles for the panel. */
  style panel {
    z-index: #{zIndex};
    position: fixed;
    left: #{left}px;
    top: #{top}px;

    if passThrough {
      pointer-events: none;
    }
  }

  /* Calculates the position from the dimensions of the panel and element. */
  fun calculatePosition (
    position : Ui.Position,
    dimensions : Dom.Dimensions,
    panel : Dom.Dimensions
  ) : Dom.Dimensions {
    let top =
      case position {
        Ui.Position.BottomCenter => dimensions.bottom + offset
        Ui.Position.BottomRight => dimensions.bottom + offset
        Ui.Position.BottomLeft => dimensions.bottom + offset

        Ui.Position.TopCenter => dimensions.top - panel.height - offset
        Ui.Position.TopRight => dimensions.top - panel.height - offset
        Ui.Position.TopLeft => dimensions.top - panel.height - offset

        Ui.Position.RightCenter => dimensions.top + (dimensions.height / 2) - (panel.height / 2)
        Ui.Position.RightBottom => dimensions.bottom - panel.height
        Ui.Position.RightTop => dimensions.top

        Ui.Position.LeftCenter => dimensions.top + (dimensions.height / 2) - (panel.height / 2)
        Ui.Position.LeftBottom => dimensions.bottom - panel.height
        Ui.Position.LeftTop => dimensions.top
      }

    let left =
      case position {
        Ui.Position.BottomCenter => dimensions.left + (dimensions.width / 2) - (panel.width / 2)
        Ui.Position.BottomRight => dimensions.right - panel.width
        Ui.Position.BottomLeft => dimensions.left

        Ui.Position.TopCenter => dimensions.left + (dimensions.width / 2) - (panel.width / 2)
        Ui.Position.TopRight => dimensions.right - panel.width
        Ui.Position.TopLeft => dimensions.left

        Ui.Position.RightCenter => dimensions.right + offset
        Ui.Position.RightBottom => dimensions.right + offset
        Ui.Position.RightTop => dimensions.right + offset

        Ui.Position.LeftCenter => dimensions.left - panel.width - offset
        Ui.Position.LeftBottom => dimensions.left - panel.width - offset
        Ui.Position.LeftTop => dimensions.left - panel.width - offset
      }

    { panel |
      bottom: top + panel.height,
      right: left + panel.width,
      left: left,
      top: top,
      x: left,
      y: top
    }
  }

  /* Calculates the position of the panel. */
  fun updateDimensions (timestamp : Number) : Promise(Void) {
    if let Maybe.Just(base) = Ui.getElementFromVNode(`#{element}`) {
      if let Maybe.Just(element) = panel {
        let panelDimensions =
          Dom.getDimensions(element)

        let dimensions =
          Dom.getDimensions(base)

        let favoredPosition =
          calculatePosition(position, dimensions, panelDimensions)

        let finalPosition =
          if Ui.isFullyVisible(favoredPosition) {
            favoredPosition
          } else {
            let inversePosition =
              calculatePosition(
                Ui.Position.inverse(position),
                dimensions,
                panelDimensions)

            if Ui.isFullyVisible(inversePosition) {
              inversePosition
            } else {
              favoredPosition
            }
          }

        next
          {
            left: finalPosition.left,
            top: finalPosition.top
          }
      }
    }
  }

  /* Renders the element and the panel. */
  fun render : Array(Html) {
    [
      element,
      <Html.Portals.Body>
        <div::panel as panel>
          content
        </div>
      </Html.Portals.Body>
    ]
  }
}
