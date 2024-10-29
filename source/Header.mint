/*
The header component with a brand and navigation items which on mobile collapses
into a icon which when interacted with opens up an action sheet with the
navigation items.
*/
component Ui.Header {
  /* The height of the component. */
  property height : Ui.Size = Ui.Size.Em(3.5)

  /* The size of the component. */
  property size : Ui.Size = Ui.Size.Inherit

  /* The menu icon. */
  property icon : Html = Ui.Icons.THREE_BARS

  /* The navigation items. */
  property items : Array(Ui.NavItem) = []

  /* The gap between the items. */
  property gap : Ui.Size = Ui.Size.Em(2)

  /* The breakpoint for the mobile version. */
  property breakpoint : Number = 1000

  /* Content for the brand. */
  property brand : Html = <></>

  state width : Number = 0

  /* A state to store the state of the dropdowns. */
  state openDropdowns : Map(String, Bool) = Map.empty()

  /* A state to store the current url. */
  state url : Url = Window.url()

  use Provider.Url { changes: updateUrl }

  /* We are using this provider to update the `width` state. */
  use Provider.ElementSize { changes: updateWidth, element: base }

  /* Styles for the base. */
  style base {
    font-size: #{Ui.Size.toString(size)};
    font-family: var(--font-family);

    height: #{Ui.Size.toString(height)};

    justify-content: space-between;
    grid-auto-flow: column;
    align-items: center;
    grid-gap: 1em;
    display: grid;
  }

  /* Styles for an item. */
  style item (active : Bool) {
    text-decoration: none;
    font-weight: bold;

    grid-auto-flow: column;
    align-items: center;
    grid-gap: 0.75em;
    display: grid;

    cursor: pointer;
    outline: none;

    if active {
      color: var(--primary-color);
    } else {
      color: inherit;
    }

    &:hover, &:focus {
      color: var(--primary-color);
    }
  }

  /* Styles for the label. */
  style label {
    text-overflow: ellipsis;
    white-space: nowrap;
    overflow: hidden;
  }

  /* Styles for the divider. */
  style divider {
    border-left: 0.2em solid var(--background-border);
    height: 2.4em;
  }

  /* Styles for the icon. */
  style icon {
    position: relative;
    top: 0.0625em;
  }

  /* The menu icon click handler. */
  fun handleClick : Promise(Void) {
    Ui.ActionSheet.show(items)
  }

  /* Updates the `url` state. */
  fun updateUrl (url : Url) {
    next { url: url }
  }

  /* Updates the `width` state based on the dimensions and breakpoint. */
  fun updateWidth (dimensions : Dom.Dimensions) {
    next { width: dimensions.width }
  }

  /* Renders the contents of an item. */
  fun renderItem (iconBefore : Html, iconAfter : Html, label : String) {
    <>
      if Html.isNotEmpty(iconBefore) {
        <div::icon><Ui.Icon icon={iconBefore}/></div>
      }

      <span::label>label</span>

      if Html.isNotEmpty(iconAfter) {
        <div::icon><Ui.Icon icon={iconAfter}/></div>
      }
    </>
  }

  /* Renders the component. */
  fun render : Html {
    <div::base as base>
      brand

      <Ui.Container gap={gap}>
        if width < breakpoint {
          [
            <div onClick={handleClick}>
              <Ui.Icon size={Ui.Size.Em(2)} interactive={true} icon={icon}/>
            </div>
          ]
        } else {
          for item of items {
            case item {
              Ui.NavItem.Divider => <div::divider/>
              Ui.NavItem.Html(content) => content

              Ui.NavItem.Group(items, iconBefore, iconAfter, label) =>
                {
                  let key =
                    String.parameterize(label)

                  let open =
                    Map.getWithDefault(openDropdowns, key, false)

                  <Ui.Dropdown
                    onClose={
                      () {
                        next {
                          openDropdowns: Map.set(openDropdowns, key, false)
                        }
                      }
                    }
                    position={Ui.Position.BottomRight}
                    closeOnOutsideClick={true}
                    offset={15}
                    open={open}
                    element={
                      <div::item(false)
                        onClick={
                          () {
                            next {
                              openDropdowns: Map.set(openDropdowns, key, true)
                            }
                          }
                        }
                        tabIndex="0"
                      >renderItem(iconBefore, iconAfter, label)</div>
                    }
                    content={
                      <Ui.Dropdown.Panel><Ui.NavItems items={items}/></Ui.Dropdown.Panel>
                    }
                  />
                }

              Ui.NavItem.Item(action, iconBefore, iconAfter, label) =>
                <div::item(false) onClick={action}>
                  renderItem(iconBefore, iconAfter, label)
                </div>

              Ui.NavItem.Link(iconBefore, iconAfter, target, label, href) =>
                <a::item(Window.isActiveURL(href)) target={target} href={href}>
                  renderItem(iconBefore, iconAfter, label)
                </a>
            }
          }
        }
      </Ui.Container>
    </div>
  }
}
