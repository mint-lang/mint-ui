/*
A dropdown component.

- On desktop it renders the given content around the given element
  using `Ui.StickyPanel`
- On mobile it renders teh given content in a modal
*/
component Ui.Dropdown {
  connect Ui exposing { mobile }

  /* The click event handler. */
  property onClick : Function(Html.Event, Promise(Never, Void)) = Promise.never1

  /* The close event handler. */
  property onClose : Function(Promise(Never, Void)) = Promise.never

  /* The position of the panel. */
  property position : Ui.Position = Ui.Position::BottomLeft

  /* Whether or not to trigger the close event when clicking outside of the panel. */
  property closeOnOutsideClick : Bool = false

  /* Whether or not to make the panel the same width as the element. */
  property matchWidth : Bool = false

  /* The element which trigger the dropdown. */
  property element : Html = <{  }>

  /* The content to show in the dropdown. */
  property content : Html = <{  }>

  /* The offset from the side of the element. */
  property offset : Number = 5

  /* The zIndex to use for the dropdown. */
  property zIndex : Number = 1

  /* Whether or not the dropdown is open. */
  property open : Bool = false

  /* The width of the panel if `matchWidth` is true. */
  state width : Number = 0

  /* We use this provider to update the width of the panel if needed. */
  use Provider.AnimationFrame {
    frames = updateDimensions
  } when {
    open && matchWidth
  }

  /* We use this provider to close the panel when clicking outside of it. */
  use Provider.OutsideClick {
    elements = [panel],
    clicks = onClose
  } when {
    closeOnOutsideClick && open && !mobile
  }

  /* Style for the panel. */
  style panel {
    if (matchWidth) {
      width: #{width}px;
    }

    if (open) {
      transition: transform 150ms 0ms ease,
                  visibility 1ms 0ms ease,
                  opacity 150ms 0ms ease;

      transform: translateY(0);
      opacity: 1;
    } else {
      transition: visibility 1ms 150ms ease,
                  transform 150ms 0ms ease,
                  opacity 150ms 0ms ease;

      transform: translateY(20px);
      visibility: hidden;
      opacity: 0;
    }
  }

  /* Updates the dimensions of the panel if `matchWidth` is true. */
  fun updateDimensions (timestamp : Number) : Promise(Never, Void) {
    case (stickyPanel) {
      Maybe::Just(panel) =>
        next { width = Dom.getDimensions(`#{panel}.base`).width }

      Maybe::Nothing => next {  }
    }
  }

  /* Renders the dropdown. */
  fun render : Html {
    if (mobile) {
      <>
        <{ element }>

        <Ui.Modal.Base
          closeOnOutsideClick={closeOnOutsideClick}
          onClose={onClose}
          open={open}>

          <{ content }>

        </Ui.Modal.Base>
      </>
    } else {
      <Ui.StickyPanel as stickyPanel
        shouldCalculate={open}
        passThrough={!open}
        position={position}
        element={element}
        offset={offset}
        zIndex={zIndex}
        content={
          <div::panel as panel onClick={onClick}>
            <{ content }>
          </div>
        }/>
    }
  }
}
