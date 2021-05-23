/*
An action sheet comes up from the bottom of the screen and displays actions
a user can take.

Some of it's features:

- Showing the component returns a promise which is resolved when its closed.
- When open pressing `Esc` closes it.
- After opened it will focus the first focusable item.
- On navigation it closes.

- The keyboard focus is trapped in the list: `Tab` and `Shift-Tab` cycles
  focusable elements.

- When closed the focus is returned to the last focused element before opening
  (which is usally the one that opened the action-sheet).
*/
global component Ui.ActionSheet {
  connect Ui exposing { mobile }

  /* The resolve function. */
  state resolve : Function(Void, Void) = (value : Void) { void }

  /* The previously focused element. */
  state focusedElement : Maybe(Dom.Element) = Maybe::Nothing

  /* The base size of the component. */
  state size : Ui.Size = Ui.Size::Inherit

  /* The displayed items. */
  state items : Array(Ui.NavItem) = []

  /* The state of the component (open / closed). */
  state open : Bool = false

  use Provider.Url { changes = handleUrlChange }

  use Provider.Shortcuts {
    shortcuts =
      [
        {
          shortcut = [Html.Event:ESCAPE],
          condition = () : Bool { true },
          bypassFocused = true,
          action = hide
        }
      ]
  }

  /* The style of the backdrop element. */
  style base {
    background: rgba(0, 0, 0, 0.8);
    position: fixed;
    z-index: 1000;
    bottom: 0;
    right: 0;
    left: 0;
    top: 0;

    font-size: #{Ui.Size.toString(size)};
    justify-content: flex-end;
    flex-direction: column;
    display: flex;

    if (open) {
      transition: visibility 1ms, opacity 320ms;
      visibility: visibilie;
      opacity: 1;
    } else {
      transition: visibility 320ms 1ms, opacity 320ms;
      visibility: hidden;
      opacity: 0;
    }
  }

  /* Style of an item. */
  style item (group : Bool) {
    box-sizing: border-box;
    padding: 0 1em;
    height: 3em;
    width: 100%;
    outline: 0;
    margin: 0;
    border: 0;

    text-decoration: none;
    font-family: inherit;
    font-size: inherit;
    color: inherit;

    grid-auto-flow: column;
    justify-content: start;
    align-items: center;
    grid-gap: 0.75em;
    display: grid;

    if (group) {
      background: var(--content-faded-color);
      color: var(--content-faded-text);
      font-weight: bold;
    } else {
      cursor: pointer;
    }
  }

  style item-interactive (group : Bool) {
    &:hover,
    &:focus {
      if (!group) {
        color: var(--primary-color);
      }
    }
  }

  /* Style for the divider. */
  style divider {
    background: var(--content-border);
    height: 0.125em;
    border: 0;
  }

  /* Style for the scroll container. */
  style container {
    transition: transform 320ms, opacity 320ms;
    overscroll-behavior: contain;
    scrollbar-width: thin;
    text-align: center;
    overflow: auto;
    min-height: 0;

    if (open) {
      transform: translateY(0);
      opacity: 1;
    } else {
      transform: translateY(100%);
      opacity: 0;
    }
  }

  /* Style for the items container. */
  style items {
    border-radius: 0.5em;
    overflow: hidden;
    margin: 1em;

    background: var(--content-color);
    font-family: var(--font-family);
    color: var(--content-text);
    text-align: left;

    > * {
      border: 0;
    }

    > * + * {
      border-top: 0.0625em solid var(--content-faded-border);
    }

    if (mobile) {
      display: block;
    } else {
      display: inline-block;
      min-width: 300px;
    }
  }

  /* Styles for a group of items. */
  style group {
    grid-template-columns: 0.4375em 1fr;
    display: grid;
  }

  /* Styles for the gutter on the left. */
  style gutter {
    border-right: 0.0625em solid var(--content-faded-border);
    background: var(--content-faded-color);
  }

  /* Styles for the group item container. */
  style group-items {
    > * + * {
      border-top: 0.0625em solid var(--content-faded-border);
    }
  }

  /* Style for custom HTML content. */
  style html {
    padding: 0.5em 1em;
  }

  /* Reset for the buttons. */
  style reset {
    font-size: inherit;
    color: inherit;

    appearance: none;
    background: none;
    display: block;
    outline: none;
    width: 100%;

    padding: 0;
    margin: 0;
  }

  /* Hides the component. */
  fun hide : Promise(Never, Void) {
    if (!open) {
      next {  }
    } else {
      sequence {
        next { open = false }

        Timer.timeout(320, "")
        resolve(void)
        Dom.focus(focusedElement)

        next
          {
            resolve = (value : Void) { void },
            focusedElement = Maybe::Nothing,
            size = Ui.Size::Inherit,
            items = []
          }
      }
    }
  }

  /* Shows the component with the given items and options. */
  fun showWithOptions (size : Ui.Size, items : Array(Ui.NavItem)) : Promise(Never, Void) {
    if (Array.isEmpty(items)) {
      next {  }
    } else {
      try {
        {resolve, reject, promise} =
          Promise.create()

        next
          {
            focusedElement = Dom.getActiveElement(),
            resolve = resolve,
            items = items,
            size = size
          }

        sequence {
          /* We need to wait for the component to be rendered before showing it. */
          Timer.timeout(10, "")
          next { open = true }

          /* We need to wait for the element to be settled before we can focus it. */
          Timer.timeout(100, "")

          case (container) {
            Maybe::Just(element) => Dom.focusFirst(element)
            Maybe::Nothing => next {  }
          }

          case (scrollContainer) {
            Maybe::Just(element) => Dom.scrollTo(element, 0, 0)
            Maybe::Nothing => next {  }
          }
        }

        promise
      }
    }
  }

  /* Shows the component with the given items. */
  fun show (items : Array(Ui.NavItem)) : Promise(Never, Void) {
    showWithOptions(Ui.Size::Inherit, items)
  }

  /* The url change event handler. */
  fun handleUrlChange (url : Url) : Promise(Never, Void) {
    hide()
  }

  /* The close event handler. */
  fun handleClose (event : Html.Event) : Promise(Never, Void) {
    if (Dom.containsMaybe(container, event.target)) {
      next {  }
    } else {
      hide()
    }
  }

  /* The item click event handler. */
  fun handleItemClick (
    onClick : Function(Html.Event, Promise(Never, Void)),
    event : Html.Event
  ) {
    sequence {
      onClick(event)
      hide()
    }
  }

  /* The link click event handler. */
  fun handleLinkClick (href : String, event : Html.Event) {
    if (String.isNotBlank(href) && !event.ctrlKey) {
      sequence {
        /* Wait for navigation to complete. */
        Timer.timeout(10, "")
        hide()
      }
    } else {
      next {  }
    }
  }

  /* Renders the contents of the item. */
  fun renderContents (
    iconAfter : Html,
    iconBefore : Html,
    label : String,
    group : Bool,
    href : String,
    target : String,
    onClick : Function(Html.Event, Promise(Never, Void))
  ) {
    try {
      contents =
        <>
          if (Html.isNotEmpty(iconBefore)) {
            <Ui.Icon icon={iconBefore}/>
          }

          <{ label }>

          if (Html.isNotEmpty(iconAfter)) {
            <Ui.Icon icon={iconAfter}/>
          }
        </>

      if (group) {
        <div::item(group)::item-interactive(group) onClick={onClick}>
          <{ contents }>
        </div>
      } else if (String.isNotBlank(href)) {
        <a::item(group)::item-interactive(group)
          onClick={onClick}
          target={target}
          href={href}>

          <{ contents }>

        </a>
      } else {
        <button::reset::item-interactive(group) onClick={onClick}>
          <div::item(group)>
            <{ contents }>
          </div>
        </button>
      }
    }
  }

  /* Renders the given navigation item. */
  fun renderItem (item : Ui.NavItem) : Html {
    case (item) {
      Ui.NavItem::Html(content) =>
        <div::html>
          <{ content }>
        </div>

      Ui.NavItem::Divider => <div::divider/>

      Ui.NavItem::Item(iconAfter, iconBefore, label, action) =>
        renderContents(
          iconAfter,
          iconBefore,
          label,
          false,
          "",
          "",
          handleItemClick(action))

      Ui.NavItem::Link(iconAfter, iconBefore, label, href, target) =>
        renderContents(
          iconAfter,
          iconBefore,
          label,
          false,
          href,
          target,
          handleLinkClick(href))

      Ui.NavItem::Group(iconAfter, iconBefore, label, items) =>
        <>
          <{
            renderContents(
              iconAfter,
              iconBefore,
              label,
              true,
              "",
              "",
              Promise.never1())
          }>

          <div::group>
            <div::gutter/>

            <div::group-items>
              for (item of items) {
                renderItem(item)
              }
            </div>
          </div>
        </>
    }
  }

  /* Renders the component. */
  fun render : Html {
    <Ui.FocusTrap>
      <div::base as base onClick={handleClose}>
        <div::container as scrollContainer>
          <div::items as container>
            for (item of items) {
              renderItem(item)
            }
          </div>
        </div>
      </div>
    </Ui.FocusTrap>
  }
}
