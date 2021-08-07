/*
A global drawer component.

Some of its features:

- When open pressing `Esc` closes it.
- After opening it will focus the first focusable item.
- Showing it returns a promise which is resolved when its closed or rejected when cancelled.
- The keyboard focus is trapped in the list: `Tab` and `Shift-Tab` cycles focusable elements.
- When closed the focus is returned to the last focused element before opening
  (which is usually the one that opened the drawer).
*/
global component Ui.Drawer {
  /* The reject function. */
  state reject : Function(Ui.Drawer.Cancelled, Void) = (error : Ui.Drawer.Cancelled) { void }

  /* The resolve function. */
  state resolve : Function(Void, Void) = (value : Void) { void }

  /* The previously focused element. */
  state focusedElement : Maybe(Dom.Element) = Maybe::Nothing

  /* The transition duration. */
  state transitionDuration : Number = 240

  /* The minimum width of the drawer. */
  state minWidth : String = "0"

  /* The content of the drawer. */
  state content : Html = <></>

  /* The z-index of the drawer. */
  state zIndex : Number = 900

  /* Whether or not the drawer is open. */
  state open : Bool = false

  use Provider.Shortcuts {
    shortcuts =
      [
        {
          condition = () : Bool { true },
          bypassFocused = true,
          shortcut = [27],
          action = hide
        }
      ]
  }

  /* Shows the component with the given content. */
  fun show (content : Html) : Promise(Ui.Drawer.Cancelled, Void) {
    showWithOptions(
      content,
      900,
      240,
      "0",
      () {
        case (base) {
          Maybe::Just(item) => item.focusFirst()
          Maybe::Nothing => next { }
        }
      })
  }

  /* Shows the component with the given content and z-index. */
  fun showWithOptions (
    content : Html,
    zIndex : Number,
    transitionDuration : Number,
    minWidth : String,
    openCallback : Function(Promise(Never, Void))
  ) : Promise(Ui.Drawer.Cancelled, Void) {
    try {
      {resolve, reject, promise} =
        Promise.create()

      next
        {
          transitionDuration = transitionDuration,
          focusedElement = Dom.getActiveElement(),
          minWidth = minWidth,
          content = content,
          resolve = resolve,
          zIndex = zIndex,
          reject = reject,
          open = true
        }

      sequence {
        Timer.timeout(transitionDuration, "")
        openCallback()
      }

      promise
    }
  }

  /* Cancels the drawer. */
  fun cancel : Promise(Never, Void) {
    sequence {
      next { open = false }

      Timer.timeout(transitionDuration, "")
      reject(`null` as Ui.Drawer.Cancelled)
      Dom.focus(focusedElement)

      next
        {
          reject = (error : Ui.Drawer.Cancelled) { void },
          resolve = (value : Void) { void },
          focusedElement = Maybe::Nothing,
          content = <{  }>
        }
    }
  }

  /* Hides the drawer. */
  fun hide : Promise(Never, Void) {
    sequence {
      next { open = false }

      Timer.timeout(transitionDuration, "")
      resolve(void)
      Dom.focus(focusedElement)

      next
        {
          reject = (error : Ui.Drawer.Cancelled) { void },
          resolve = (value : Void) { void },
          focusedElement = Maybe::Nothing,
          content = <{  }>
        }
    }
  }

  /* Renders the drawer. */
  fun render : Html {
    <Ui.Drawer.Base as base
      transitionDuration={transitionDuration}
      minWidth={minWidth}
      onClose={cancel}
      zIndex={zIndex}
      open={open}>

      <{ content }>

    </Ui.Drawer.Base>
  }
}
