/* This enum represents a size. */
enum Ui.Size {
  /* CSS em unit. */
  Em(Number)

  /* CSS px unit. */
  Px(Number)

  /* CSS inherit value. */
  Inherit
}

/* Utility functions for working with `Ui.Size`. */
module Ui.Size {
  /* Converts the size into it's CSS equivalent. */
  fun toString (size : Ui.Size) : String {
    case (size) {
      Ui.Size::Em(value) => "#{value}em"
      Ui.Size::Px(value) => "#{value}px"
      Ui.Size::Inherit => "inherit"
    }
  }
}
