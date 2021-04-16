/* An enum for tracking the status of the dragging for the image cropper. */
enum Ui.Cropper.Status {
  /* The cropper is being dragged (manipulated). */
  Dragging(
    directions : Tuple(Ui.Cropper.Direction, Ui.Cropper.Direction),
    startValue : Ui.Cropper.Value,
    startEvent : Html.Event)

  /* The cropper is idle. */
  Idle
}
