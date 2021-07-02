/*
A button to scroll to the top of the page.

- It's only visible if the page is scrolled.
- It's positioned on the bottom right corner of the page.
*/
component Ui.ScrollToTop {
  connect Ui exposing { mobile }

  /* We use the scroll provider to update scroll position. */
  use Provider.Scroll { scrolls = updatePosition }

  /* The size of the content. */
  property size : Ui.Size = Ui.Size::Inherit

  /* The threshold (scroll position) to show the button. */
  property threshold : Number = 50

  /* The z-index of the component. */
  property zIndex : Number = 800

  /* Whether or not to display the button globally. */
  property global : Bool = true

  /* We have a state for the scroll position. */
  state scrollPosition = `window.scrollY`

  /* Styles for the base. */
  style base {
    transition: transform 320ms, opacity 320ms;
    font-size: #{Ui.Size.toString(size)};
    z-index: #{zIndex};

    if (global) {
      position: fixed;
    } else {
      position: static;
    }

    if (mobile) {
      bottom: 1rem;
      right: 1rem;
    } else {
      bottom: 1.5rem;
      right: 1.5rem;
    }

    if (scrollPosition < threshold) {
      transform: scale(0);
      opacity: 0;
    } else {
      transform: scale(1);
      opacity: 1;
    }
  }

  /* Updates the scroll position. */
  fun updatePosition (event : Html.Event) : Promise(Never, Void) {
    next { scrollPosition = `window.scrollY` }
  }

  /* Scrolls to the top of the page. */
  fun handleClick (event : Html.Event) : Promise(Never, Void) {
    Window.setScrollTop(0)
  }

  /* Renders the component. */
  fun render : Html {
    try {
      base =
        <div::base>
          <Ui.FloatingButton
            icon={Ui.Icons:CHEVRON_UP}
            onClick={handleClick}
            type="secondary"/>
        </div>

      if (global) {
        <Html.Portals.Body>
          <{ base }>
        </Html.Portals.Body>
      } else {
        base
      }
    }
  }
}
