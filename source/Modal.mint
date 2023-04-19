/*
A generic global modal component.

Some of its features:

- When open pressing `Esc` closes it.

- After opened it will focus the first focusable item (which usually is the
  close icon).

- Showing the component returns a promise which is resolved when its closed or
  rejected when cancelled.

- The keyboard focus is trapped in the list: `Tab` and `Shift-Tab` cycles
  focusable elements.

- When closed the focus is returned to the last focused element before opening
  (which is usually the one that opened the modal).
*/
global component Ui.Modal {
  /* The resolve function. */
  state resolve : Function(Maybe(Void), Void) = (value : Maybe(Void)) { void }

  /* The previously focused element. */
  state focusedElement : Maybe(Dom.Element) = Maybe::Nothing

  /* The transition duration. */
  state transitionDuration : Number = 240

  /* The content of the modal. */
  state content : Html = <></>

  /* The z-index of the modal. */
  state zIndex : Number = 900

  /* Whether or not the modal is open. */
  state open : Bool = false

  use Provider.Shortcuts {
    shortcuts:
      [
        {
          condition: () : Bool { true },
          bypassFocused: true,
          shortcut: [27],
          action: cancel
        }
      ]
  }

  /* Shows the component with the given content. */
  fun show (content : Html) : Promise(Maybe(Void)) {
    showWithOptions(
      content,
      900,
      240,
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
    openCallback : Function(Promise(Void))
  ) : Promise(Maybe(Void)) {
    let {resolve, promise} =
      Promise.create()

    next
      {
        transitionDuration: transitionDuration,
        focusedElement: Dom.getActiveElement(),
        content: content,
        resolve: resolve,
        zIndex: zIndex,
        open: true
      }

    /* This block makes it so that it's statements are run asynchronously. */
    {
      await Timer.timeout(transitionDuration)
      openCallback()
    }

    promise
  }

  /* Cancels the modal. */
  fun cancel : Promise(Void) {
    await next { open: false }

    await Timer.timeout(transitionDuration)
    await resolve(Maybe::Nothing)
    await Dom.focus(focusedElement)

    next
      {
        resolve: (value : Maybe(Void)) { void },
        focusedElement: Maybe::Nothing,
        content: <{  }>
      }
  }

  /* Hides the modal. */
  fun hide : Promise(Void) {
    await next { open: false }

    await Timer.timeout(transitionDuration)
    await resolve(Maybe::Just(void))
    await Dom.focus(focusedElement)

    await next
      {
        resolve: (value : Maybe(Void)) { void },
        focusedElement: Maybe::Nothing,
        content: <{  }>
      }
  }

  /* Renders the modal. */
  fun render : Html {
    <Ui.Modal.Base as base
      onClose={cancel}
      zIndex={zIndex}
      open={open}>

      <{ content }>

    </Ui.Modal.Base>
  }
}
