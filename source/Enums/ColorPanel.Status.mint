/* An enum for tracking the status of the dragging for the color panel. */
enum Ui.ColorPanel.Status {
  /* The value-saturation handle is dragged. */
  ValueSaturationDragging(Dom.Element)

  /* The alpha handle is dragged. */
  AlphaDragging(Dom.Element)

  /* The hue handle is dragged. */
  HueDragging(Dom.Element)

  /* Nothing is dragged. */
  Idle
}
