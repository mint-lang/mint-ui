/*
The base component for a drawer, this contains the backdrop and the surface for
the content with transitions.

Use this when you want to create a custom drawer.
*/
component Ui.Drawer.Base {
  /* The close event handler. */
  property onClose : Function(Promise(Void)) = Promise.never

  /* The duration of the transition. */
  property transitionDuration : Number = 240

  /* Whether or not to trigger the close event when clicking on the backdrop. */
  property closeOnOutsideClick : Bool = true

  /* The content to render. */
  property children : Array(Html) = []

  /* The minimum width of the drawer. */
  property minWidth : String = "0"

  /* The zIndex of the drawer. */
  property zIndex : Number = 900

  /* Whether or not the drawer is open. */
  property open : Bool = false

  use Provider.OutsideClick {
    elements: [drawer],
    clicks: onClose
  } when {
    open && closeOnOutsideClick
  }

  style base {
    -webkit-tap-highlight-color: rgba(0,0,0,0);
    -webkit-touch-callout: none;

    background: rgba(0, 0, 0, 0.8);
    transform: translate3d(0,0,0);
    z-index: #{zIndex};
    position: fixed;
    bottom: 0;
    right: 0;
    left: 0;
    top: 0;

    if (open) {
      transition: opacity #{transitionDuration}ms 0ms ease,
                  visibility 1ms 0ms ease;

      pointer-events: auto;
      visibility: visible;
      opacity: 1;
    } else {
      transition: visibility 1ms #{transitionDuration}ms ease,
                  opacity #{transitionDuration}ms 0ms ease;

      pointer-events: none;
      visibility: hidden;
      opacity: 0;
    }
  }

  style drawer {
    transition: transform #{transitionDuration}ms ease;
    border-right: 0.0625em solid var(--content-border);
    background: var(--content-color);
    color: var(--content-text);
    min-width: #{minWidth};
    padding: 1.5em;

    position: absolute;
    bottom: 0;
    right: 0;
    top: 0;

    if (open) {
      transform: translateX(0);
    } else {
      transform: translateX(3em);
    }
  }

  /* Focuses the first focusable element in the drawer. */
  fun focusFirst : Promise(Void) {
    drawer
    |> Maybe.map(Dom.focusFirst)
    |> Maybe.withDefault(Promise.never())
  }

  fun render : Html {
    <Html.Portals.Body>
      <Ui.FocusTrap>
        <div::base>
          <div::drawer as drawer>
            <{ children }>
          </div>
        </div>
      </Ui.FocusTrap>
    </Html.Portals.Body>
  }
}
