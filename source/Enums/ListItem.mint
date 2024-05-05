/* Represents an item in a list. */
type Ui.ListItem {
  /*
  An item which consist of:
  - a key which should be unique
  - a content which is displayed
  - a match string which is searched against
  */
  Item(
    matchString : String,
    content : Html,
    key : String)

  /* A divider between items. */
  Divider
}

/* Utility functions for working with `Ui.ListItem`. */
module Ui.ListItem {
  /* Creates list items form an array of strings. */
  fun fromStringArray (array : Array(String)) : Array(Ui.ListItem) {
    for item of array {
      fromString(item)
    }
  }

  /* Creates list items form a string. */
  fun fromString (value : String) : Ui.ListItem {
    Ui.ListItem.Item(
      matchString: String.toLowerCase(value),
      key: String.parameterize(value),
      content: <>value</>)
  }

  /* Returns the `content` of a list item. */
  fun content (item : Ui.ListItem) : Html {
    if let Ui.ListItem.Item(content) = item {
      content
    }
  }

  /* Returns the `matchString` of a list item. */
  fun matchString (item : Ui.ListItem) : String {
    if let Ui.ListItem.Item(matchString) = item {
      matchString
    }
  }

  /* Returns the `key` of a list item. */
  fun key (item : Ui.ListItem) : String {
    if let Ui.ListItem.Item(key) = item {
      key
    }
  }
}
