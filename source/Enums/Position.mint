/* Represents the position of dropdowns and tooltips. */
enum Ui.Position {
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

/* Utility functions for working with `Ui.Poisition`. */
module Ui.Position {
  /* Converts the given string value in to a position. */
  fun fromString (value : String) : Ui.Position {
    case value {
      "BottomCenter" => Ui.Position::BottomCenter
      "BottomRight" => Ui.Position::BottomRight
      "BottomLeft" => Ui.Position::BottomLeft

      "TopCenter" => Ui.Position::TopCenter
      "TopRight" => Ui.Position::TopRight
      "TopLeft" => Ui.Position::TopLeft

      "RightBottom" => Ui.Position::RightBottom
      "RightCenter" => Ui.Position::RightCenter
      "RightTop" => Ui.Position::RightTop

      "LeftBottom" => Ui.Position::LeftBottom
      "LeftCenter" => Ui.Position::LeftCenter
      "LeftTop" => Ui.Position::LeftTop

      => Ui.Position::BottomLeft
    }
  }

  /* Returns the string representation of a position. */
  fun toString (position : Ui.Position) : String {
    case position {
      Ui.Position::BottomCenter => "BottomCenter"
      Ui.Position::BottomRight => "BottomRight"
      Ui.Position::BottomLeft => "BottomLeft"

      Ui.Position::TopCenter => "TopCenter"
      Ui.Position::TopRight => "TopRight"
      Ui.Position::TopLeft => "TopLeft"

      Ui.Position::RightBottom => "RightBottom"
      Ui.Position::RightCenter => "RightCenter"
      Ui.Position::RightTop => "RightTop"

      Ui.Position::LeftBottom => "LeftBottom"
      Ui.Position::LeftCenter => "LeftCenter"
      Ui.Position::LeftTop => "LeftTop"
    }
  }

  /* Returns the inverse position of the given position. */
  fun inverse (position : Ui.Position) : Ui.Position {
    case position {
      Ui.Position::BottomCenter => Ui.Position::TopCenter
      Ui.Position::BottomRight => Ui.Position::TopRight
      Ui.Position::BottomLeft => Ui.Position::TopLeft

      Ui.Position::TopCenter => Ui.Position::BottomCenter
      Ui.Position::TopRight => Ui.Position::BottomRight
      Ui.Position::TopLeft => Ui.Position::BottomLeft

      Ui.Position::RightBottom => Ui.Position::LeftBottom
      Ui.Position::RightCenter => Ui.Position::LeftCenter
      Ui.Position::RightTop => Ui.Position::LeftTop

      Ui.Position::LeftBottom => Ui.Position::RightBottom
      Ui.Position::LeftCenter => Ui.Position::RightCenter
      Ui.Position::LeftTop => Ui.Position::RightTop
    }
  }
}
