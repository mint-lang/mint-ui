/* Represents a table cell. */
type Ui.Cell {
  /* A list of Html items, separated by some space. */
  HtmlItems(items : Array(Html), breakOnMobile : Bool)

  /* A code. */
  Code(breakSpaces : Bool, code : String)

  /* A simple string value. */
  String(String)

  /* A simple number value. */
  Number(Number)

  /* Arbitrary HTML content. */
  Html(Html)
}
