/*
The base component for a modal, this contains the backdrop and the centered
content with transitions.

Use this when you want to create a custom modal.
*/
component Ui.Modal.Base {
  /* The close event handler. */
  property onClose : Function(Promise(Void)) = Promise.never

  /* The duration of the transition. */
  property transitionDuration : Number = 240

  /* Whether or not to trigger the close event when clicking on the backdrop. */
  property closeOnOutsideClick : Bool = true

  /* The content to render. */
  property children : Array(Html) = []

  /* The zIndex of the modal. */
  property zIndex : Number = 900

  /* Whether or not the modal is open. */
  property open : Bool = false

  use Provider.OutsideClick {
    elements: [wrapper],
    clicks: onClose
  } when {
    open && closeOnOutsideClick
  }

  /* Styles for the base element. */
  style base {
    -webkit-tap-highlight-color: rgba(0,0,0,0);
    -webkit-touch-callout: none;

    background: rgba(0, 0, 0, 0.8);
    max-height: 100vh;
    overflow-y: auto;
    display: flex;

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

  /* Styles for the wrapper. */
  style wrapper {
    transition: transform #{transitionDuration}ms ease;
    padding: 1em;
    margin: auto;

    if (open) {
      transform: translateY(0);
    } else {
      transform: translateY(-3em);
    }
  }

  /* Focuses the first focusable element in the modal. */
  fun focusFirst : Promise(Void) {
    wrapper
    |> Maybe.map(Dom.focusFirst)
    |> Maybe.withDefault(Promise.never())
  }

  /* Renders the modal. */
  fun render : Html {
    <Ui.FocusTrap>
      <div::base>
        <div::wrapper as wrapper>
          <{ children }>
        </div>
      </div>
    </Ui.FocusTrap>
  }
}
