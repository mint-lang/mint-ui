/* A component to render a navigation item (on desktop). */
component Ui.NavItem {
  /* The size of the component. */
  property size : Ui.Size = Ui.Size.Inherit

  /* The navigation item. */
  property item : Ui.NavItem

  use Provider.Url { changes: (url : Url) { next { } } }

  /* Styles for a row. */
  style row {
    font-size: #{Ui.Size.toString(size)};
    line-height: 1.7;

    grid-auto-flow: column;
    justify-content: start;
    align-items: center;
    grid-gap: 0.75em;
    display: grid;
  }

  /* Style for an item in the sidebar. */
  style item (active : Bool) {
    text-decoration: none;
    cursor: pointer;
    color: inherit;
    outline: none;

    if active {
      color: var(--primary-color);
    }

    &:hover, &:focus {
      color: var(--primary-color);
    }
  }

  /* Style for a group. */
  style group-item {
    margin-bottom: 0.3125em;

    &:not(:first-child) {
      margin-top: 1.25em;
    }
  }

  /* Style for the divider. */
  style divider {
    border-top: 0.125em solid var(--navitem-border);
    font-size: #{Ui.Size.toString(size)};
    margin: 0.25em 0;
  }

  /* Styles for the group. */
  style group {
    font-size: #{Ui.Size.toString(size)};
    margin-bottom: 0.5em;

    > div {
      padding-left: 0.75em;
      border-left: 1px solid var(--navitem-border);
    }

    strong {
      margin-bottom: 0.5em;
    }

    &:not(:first-child) {
      margin-top: 0.5em;
    }
  }

  /* Renders the contents of an item. */
  fun renderContents (
    iconBefore : Html,
    iconAfter : Html,
    label : String
  ) : Html {
    <>
      if Html.isNotEmpty(iconBefore) {
        <Ui.Icon icon={iconBefore}/>
      }

      label

      if Html.isNotEmpty(iconAfter) {
        <Ui.Icon icon={iconAfter}/>
      }
    </>
  }

  /* Renders the item. */
  fun render : Html {
    case item {
      Group(items, iconBefore, iconAfter, label) =>
        <div::group>
          <strong::group-item::row>renderContents(iconBefore, iconAfter, label)</strong>

          <Ui.NavItems items={items}/>
        </div>

      Link(iconBefore, iconAfter, target, label, href) =>
        <a::row::item(Window.isActiveURL(href)) target={target} href={href}>
          renderContents(iconBefore, iconAfter, label)
        </a>

      Item(action, iconBefore, iconAfter, label) =>
        <div::row::item(false) onClick={action}>
          renderContents(iconBefore, iconAfter, label)
        </div>

      Divider => <div::divider/>
      Html(content) => content
    }
  }
}
