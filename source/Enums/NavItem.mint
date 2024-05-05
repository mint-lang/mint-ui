/*
Represents a navigation item, it is used in certain components:

- `Ui.Layout.Documentation`
- `Ui.ActionSheet`
- `Ui.Header`
- `Ui.Footer`
*/
type Ui.NavItem {
  /* A divider between items. */
  Divider

  /* A group of other navigation items. */
  Group(
    items : Array(Ui.NavItem),
    iconBefore : Html,
    iconAfter : Html,
    label : String)

  /* An item which has an action. */
  Item(
    action : Function(Html.Event, Promise(Void)),
    iconBefore : Html,
    iconAfter : Html,
    label : String)

  /* An item which links to a different page. */
  Link(
    iconBefore : Html,
    iconAfter : Html,
    target : String,
    label : String,
    href : String)

  /* Arbitrary HTML content. */
  Html(Html)
}
