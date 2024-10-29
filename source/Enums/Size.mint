/* This enum represents a size. */
type Ui.Size {
  /* CSS em unit. */
  Em(Number)

  /* CSS px unit. */
  Px(Number)

  /* CSS inherit value. */
  Inherit
}

/* Utility functions for working with `Ui.Size`. */
module Ui.Size {
  /* Converts the size into its CSS equivalent. */
  fun toString (size : Ui.Size) : String {
    case size {
      Em(value) => "#{value}em"
      Px(value) => "#{value}px"
      Inherit => "inherit"
    }
  }
}
