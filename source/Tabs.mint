/*
A simple tabs component.

- the tabs on mobile dimensions collapse into a buttonwhich opens an action-sheet when clicked
*/
component Ui.Tabs {
  /* The change event handler. */
  property onChange : Function(String, Promise(Void)) = Promise.never1

  /* The size of the component. */
  property size : Ui.Size = Ui.Size::Inherit

  /* The breakpoint for the mobile version. */
  property breakpoint : Number = 1000

  /* The data for the tabs. */
  property items : Array(Ui.Tab) = []

  /* The `key` for the active tab. */
  property active : String = ""

  /* A state to hold the width of the component. */
  state width : Number = 0

  /* We are using this provider to update the `mobile` state. */
  use Provider.ElementSize {
    changes: updateWidth,
    element: base
  }

  /* The style for the base element. */
  style base {
    background: var(--content-color);
    color: var(--content-text);

    font-size: #{Ui.Size.toString(size)};
    font-family: var(--font-family);

    grid-template-rows: min-content 1fr;
    overflow: hidden;
    display: grid;
  }

  /* The style to reset a buttons default appearance. */
  style button-reset {
    -webkit-appearance: none;
    appearance: none;

    font-size: inherit;
    color: inherit;
    background: 0;
    outline: 0;
    padding: 0;
    border: 0;

    &::-moz-focus-inner {
      border: 0;
    }
  }

  /* The style for the tab handles container. */
  style tabs {
    border-bottom: 0.1875em solid var(--content-border);

    grid-auto-flow: column;
    justify-content: start;
    display: grid;
  }

  /* The style for the content. */
  style content {
    padding: 1em;
  }

  /* The style for the mobile tab. */
  style mobile {
    justify-content: space-between;
    grid-auto-flow: column;
    align-items: center;
    display: grid;

    padding-right: 1em;
  }

  /* The style for the mobile button. */
  style button-mobile {
    border-bottom: 0.1875em solid var(--content-border);

    &:focus,
    &:hover {
      border-bottom: 0.1875em solid var(--primary-color);
      color: var(--primary-color);
    }
  }

  /* The style for the inner tab. */
  style tab-inner {
    padding: 1.2em 1em;

    font-size: inherit;
    font-weight: bold;

    grid-auto-flow: column;
    justify-content: start;
    align-items: center;
    grid-gap: 1em;
    display: grid;

    white-space: nowrap;
    cursor: pointer;
  }

  /* The style for a specific tab handle. */
  style tab (active : Bool) {
    margin-bottom: -0.1875em;

    &:focus,
    &:hover {
      border-bottom: 0.1875em solid var(--primary-color);
      color: var(--primary-color);
      opacity: 1;
    }

    if active {
      border-bottom: 0.1875em solid var(--content-text);
      opacity: 1;
    } else {
      border-bottom: 0.1875em solid transparent;
      opacity: 0.75;
    }
  }

  /* Returns if we need to use the mobile version or not. */
  get mobile : Bool {
    width < breakpoint
  }

  /* Updates the `mobile` state based on the dimensions and breakpoint. */
  fun updateWidth (dimensions : Dom.Dimensions) {
    next { width: dimensions.width }
  }

  /* The event handler for the tab select. */
  fun handleSelect (key : String) : Promise(Void) {
    if key == active {
      next { }
    } else {
      onChange(key)
    }
  }

  /* Renders a tabs contents. */
  fun renderTab (tab : Ui.Tab) {
    <div::tab-inner>
      if Html.isNotEmpty(tab.iconBefore) {
        <Ui.Icon icon={tab.iconBefore}/>
      }

      <{ tab.label }>

      if Html.isNotEmpty(tab.iconAfter) {
        <Ui.Icon icon={tab.iconAfter}/>
      }
    </div>
  }

  /* Renders the component. */
  fun render : Html {
    <div::base as base>
      if mobile {
        let navItems =
          for tab of items {
            Ui.NavItem::Item(
              action: (event : Html.Event) { handleSelect(tab.key) },
              iconBefore: tab.iconBefore,
              iconAfter: tab.iconAfter,
              label: tab.label)
          }

        <button::button-reset::button-mobile>
          <div::mobile onClick={() { Ui.ActionSheet.show(navItems) }}>
            <{
              items
              |> Array.find((tab : Ui.Tab) { tab.key == active })
              |> Maybe.map(renderTab)
              |> Maybe.withDefault(<></>)
            }>

            <Ui.Icon
              icon={Ui.Icons:CHEVRON_DOWN}
              size={Ui.Size::Em(1.5)}/>
          </div>
        </button>
      } else {
        <div::tabs>
          for tab of items {
            <button::button-reset::tab(tab.key == active) onClick={() { handleSelect(tab.key) }}>
              <{ renderTab(tab) }>
            </button>
          }
        </div>
      }

      <div::content>
        <{
          items
          |> Array.find((tab : Ui.Tab) { tab.key == active })
          |> Maybe.map((tab : Ui.Tab) { tab.content })
          |> Maybe.withDefault(<></>)
        }>
      </div>
    </div>
  }
}
