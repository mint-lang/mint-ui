/*
A scrollable container with custom scrollbars and indicators for more items
at the start and end of the container.
*/
component Ui.ScrollPanel {
  /* The orientation, this determines which way the panel should scroll. */
  property orientation : String = "vertical"

  /* The children to render. */
  property children : Array(Html) = []

  /* An extra padding from the scroll bars. */
  property extraPadding : Number = 5

  /* The size of the indicator. */
  property shadowSize : Number = 20

  /* The maximum size of the component. */
  property maxSize : Number = 300

  /* The current scroll position. */
  state scrollPosition : Number = 0

  /* The current scroll size. */
  state scrollSize : Number = 0

  /* The current client size. */
  state clientSize : Number = 0

  use Provider.ElementSize {
    element: Maybe.oneOf([horizontal, vertical]),
    changes: recalculateFromSize
  }

  use Provider.Mutation {
    element: Maybe.oneOf([horizontal, vertical]),
    changes: recalculate
  }

  /* Base style for the component. */
  style base {
    &::before,
    &::after {
      transition: opacity 320ms;
      pointer-events: none;
      position: sticky;
      display: block;
      content: "";
      z-index: 10;
    }

    &::-webkit-scrollbar {
      cursor: pointer;
      height: 12px;
      width: 12px;
    }

    &::-webkit-scrollbar-track {
      background: var(--scrollbar-track);
    }

    &::-webkit-scrollbar-thumb {
      background: var(--scrollbar-thumb);
    }

    &:focus {
      outline: 0.125em solid var(--primary-color);
    }
  }

  /* Style for the horizontal variant. */
  style horizontal {
    max-width: #{maxSize}px;

    overscroll-behavior: contain;
    overflow-y: hidden;
    overflow-x: auto;
    display: flex;

    > * {
      flex: 0 0 auto;
    }

    &::before,
    &::after {
      margin-right: -#{shadowSize}px;
      min-width: #{shadowSize}px;
    }

    &::before {
      background: radial-gradient(ellipse farthest-side at left center, var(--scroll-shadow-to), var(--scroll-shadow-from));
      border-image: linear-gradient(0deg, var(--scroll-shadow-from), var(--scroll-shadow-to), var(--scroll-shadow-from)) 1;
      border-left: 0.0625em solid;
      left: 0;

      if scrollPosition == 0 {
        opacity: 0;
      } else {
        opacity: 1;
      }
    }

    &::after {
      background: radial-gradient(ellipse farthest-side at right center, var(--scroll-shadow-to), var(--scroll-shadow-from));
      border-image: linear-gradient(0deg, var(--scroll-shadow-from), var(--scroll-shadow-to), var(--scroll-shadow-from)) 1;
      border-right: 0.0625em solid;
      right: 0;

      if scrollPosition == (scrollSize - clientSize) {
        opacity: 0;
      } else {
        opacity: 1;
      }
    }

    if scrollSize != clientSize {
      padding-bottom: #{extraPadding}px;
    }
  }

  /* Style for the vertical variant. */
  style vertical {
    max-height: #{maxSize}px;

    overscroll-behavior: contain;
    overflow-x: hidden;
    overflow-y: auto;

    &::before,
    &::after {
      margin-top: -#{shadowSize}px;
      min-height: #{shadowSize}px;
    }

    &::before {
      background: radial-gradient(ellipse farthest-side at top center, var(--scroll-shadow-to), var(--scroll-shadow-from));
      border-image: linear-gradient(90deg, var(--scroll-shadow-from), var(--scroll-shadow-to), var(--scroll-shadow-from)) 1;
      border-top: 0.0625em solid;
      top: 0;

      if scrollPosition == 0 {
        opacity: 0;
      } else {
        opacity: 1;
      }
    }

    &::after {
      background: radial-gradient(ellipse farthest-side at bottom center, var(--scroll-shadow-to), var(--scroll-shadow-from));
      border-image: linear-gradient(90deg, var(--scroll-shadow-from), var(--scroll-shadow-to), var(--scroll-shadow-from)) 1;
      border-bottom: 0.0625em solid;
      bottom: 0;

      if scrollPosition == (scrollSize - clientSize) {
        opacity: 0;
      } else {
        opacity: 1;
      }
    }

    if scrollSize != clientSize {
      padding-right: #{extraPadding}px;
    }

    @supports (-moz-appearance:none) {
      if scrollSize != clientSize {
        padding-right: calc(12px + #{extraPadding}px);
      }
    }
  }

  /*
  This is needed to be a separate function so the provider doesn't re-subscribe
  every update.
  */
  fun recalculateFromSize (dimensions : Dom.Dimensions) : Promise(Void) {
    recalculate()
  }

  /* Sets the state variables from the current state of the element. */
  fun recalculate : Promise(Void) {
    if orientation == "horizontal" {
      if let Maybe::Just(element) = horizontal {
        next
          {
            scrollPosition: Dom.getScrollLeft(element),
            clientSize: Dom.getClientWidth(element),
            scrollSize: Dom.getScrollWidth(element)
          }
      }
    } else if let Maybe::Just(element) = vertical {
      next
        {
          scrollPosition: Dom.getScrollTop(element),
          clientSize: Dom.getClientHeight(element),
          scrollSize: Dom.getScrollHeight(element)
        }
    }
  }

  /* Renders the component. */
  fun render : Html {
    if orientation == "horizontal" {
      <div::base::horizontal as horizontal onScroll={recalculate}>
        children
      </div>
    } else {
      <div::base::vertical as vertical onScroll={recalculate}>
        children
      </div>
    }
  }
}
