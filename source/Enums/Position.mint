/* Represents the position of dropdowns and tooltips. */
type Ui.Position {
  BottomCenter
  BottomRight
  BottomLeft
  TopCenter
  TopRight
  TopLeft
  RightBottom
  RightCenter
  RightTop
  LeftBottom
  LeftCenter
  LeftTop
}

/* Utility functions for working with `Ui.Position`. */
module Ui.Position {
  /* Converts the given string value in to a position. */
  fun fromString (value : String) : Ui.Position {
    case value {
      "BottomCenter" => Ui.Position.BottomCenter
      "BottomRight" => Ui.Position.BottomRight
      "BottomLeft" => Ui.Position.BottomLeft

      "TopCenter" => Ui.Position.TopCenter
      "TopRight" => Ui.Position.TopRight
      "TopLeft" => Ui.Position.TopLeft

      "RightBottom" => Ui.Position.RightBottom
      "RightCenter" => Ui.Position.RightCenter
      "RightTop" => Ui.Position.RightTop

      "LeftBottom" => Ui.Position.LeftBottom
      "LeftCenter" => Ui.Position.LeftCenter
      "LeftTop" => Ui.Position.LeftTop

      => Ui.Position.BottomLeft
    }
  }

  /* Returns the string representation of a position. */
  fun toString (position : Ui.Position) : String {
    case position {
      BottomCenter => "BottomCenter"
      BottomRight => "BottomRight"
      BottomLeft => "BottomLeft"

      TopCenter => "TopCenter"
      TopRight => "TopRight"
      TopLeft => "TopLeft"

      RightBottom => "RightBottom"
      RightCenter => "RightCenter"
      RightTop => "RightTop"

      LeftBottom => "LeftBottom"
      LeftCenter => "LeftCenter"
      LeftTop => "LeftTop"
    }
  }

  /* Returns the inverse position of the given position. */
  fun inverse (position : Ui.Position) : Ui.Position {
    case position {
      BottomCenter => Ui.Position.TopCenter
      BottomRight => Ui.Position.TopRight
      BottomLeft => Ui.Position.TopLeft

      TopCenter => Ui.Position.BottomCenter
      TopRight => Ui.Position.BottomRight
      Ui.Position.TopLeft => Ui.Position.BottomLeft

      RightBottom => Ui.Position.LeftBottom
      RightCenter => Ui.Position.LeftCenter
      RightTop => Ui.Position.LeftTop

      LeftBottom => Ui.Position.RightBottom
      LeftCenter => Ui.Position.RightCenter
      LeftTop => Ui.Position.RightTop
    }
  }
}
