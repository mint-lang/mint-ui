/* A layout component for displaying documentation. */
component Ui.Layout.Documentation {
  connect Ui exposing { mobile }

  /* The content to display in the mobile navigation select. */
  property mobileNavigationLabel : Html = <>"Pages"</>

  /* The size of the component. */
  property size : Ui.Size = Ui.Size.Inherit

  /* The items grouped by a string. */
  property items : Array(Ui.NavItem) = []

  /* The breakpoint to render the table of contents. */
  property tocBreakpoint : Number = 1440

  /* The content to render. */
  property children : Array(Html) = []

  /* The items for the table of contents. */
  state tocItems : Array(Tuple(String, String)) = []

  /* A variable to store when to show the table of contents. */
  state tocShown : Bool = false

  /* We are using this provider to update the `tocShown` state. */
  use Provider.ElementSize { changes: updateTocShown, element: base }

  /* We are using the mutation provider to update elements on the fly. */
  use Provider.Mutation { changes: updateToc, element: content }

  /* The styles for the base. */
  style base {
    grid-template-columns: 16em 1fr;
    align-items: start;
    grid-gap: 2em;
    display: grid;

    font-size: #{Ui.Size.toString(size)};
    font-family: var(--font-family);

    if showToc {
      grid-template-columns: 18em 1fr 16em;
    }

    if mobile {
      grid-template-rows: min-content 1fr;
      grid-template-columns: 1fr;
      grid-gap: 0;
    }
  }

  /* Styles for the content. */
  style content {
    min-width: 0;
  }

  /* Styles for the table of contents item. */
  style toc-item {
    text-decoration: none;
    color: inherit;

    grid-template-columns: min-content 1fr;
    grid-gap: 0.5em;
    display: grid;

    &::before {
      content: "";

      background: currentColor;
      border-radius: 50%;
      margin-top: 0.75em;
      height: 0.25em;
      width: 0.25em;
      opacity: 0.6;
    }

    &:hover, &:focus {
      color: var(--primary-color);
      outline: none;
    }
  }

  /* Styles for the table of contents. */
  style toc {
    align-self: start;
    position: sticky;
    top: 2em;

    if !showToc {
      display: none;
    }
  }

  /* Reset for the buttons. */
  style button-reset {
    font-size: inherit;
    color: inherit;

    appearance: none;
    background: none;
    display: block;
    outline: none;
    width: 100%;
    padding: 0;

    border-radius: 0.375em;
    border: 0;

    margin: 0;
    margin-bottom: 1em;

    &:hover, &:focus {
      box-shadow: 0 0 0 0.1875em var(--primary-color),
                  0 0 0.625em var(--shadow-color);
    }
  }

  /* Style for the mobile page selector. */
  style button {
    font-weight: bold;
    text-align: left;
    cursor: pointer;

    box-shadow: 0 0 0.625em var(--shadow-color);
    background: var(--content-color);
    color: var(--content-text);
    padding: 0.875em 1.25em;
    border-radius: 0.375em;

    grid-template-columns: 1fr auto;
    grid-gap: 1em;
    display: grid;
  }

  /* A computed property to calculate to whether or not show the table of contents. */
  get showToc : Bool {
    tocShown && !Array.isEmpty(tocItems)
  }

  /* Gets the table of contents data of an element. */
  fun getTocData (element : Dom.Element) : Tuple(String, String) {
    {
      Maybe.withDefault(Dom.getAttribute(element, "name"), ""),
      Dom.getTextContent(element)
    }
  }

  /* Updates the `tocShown` state based on the dimensions and breakpoint. */
  fun updateTocShown (dimensions : Dom.Dimensions) {
    next { tocShown: dimensions.width > tocBreakpoint }
  }

  /* Updates the table of contents. */
  fun updateToc {
    if let Maybe.Just(element) = content {
      let items =
        Dom.getElementsBySelector(element, "a[name]")

      let newTocItems =
        Array.map(items, getTocData)

      if newTocItems != tocItems {
        next { tocItems: newTocItems }
      }
    }
  }

  /* Handles the change event from the select. */
  fun openActionSheet (event : Html.Event) : Promise(Void) {
    Ui.ActionSheet.show(items)
  }

  /* Renders the layout. */
  fun render : Html {
    <div::base as base>
      if !mobile {
        <Ui.Box><Ui.NavItems items={items}/></Ui.Box>
      } else {
        <button::button-reset onClick={openActionSheet}>
          <div::button>
            mobileNavigationLabel
            <Ui.Icon icon={Ui.Icons.CHEVRON_DOWN}/>
          </div>
        </button>
      }

      <div::content as content>children</div>

      if !mobile {
        <div::toc>
          <Ui.Box label=<>"Contents"</>>
            for item of tocItems {
              <div><a::toc-item href="##{item[0]}">item[1]</a></div>
            }
          </Ui.Box>
        </div>
      }
    </div>
  }
}
