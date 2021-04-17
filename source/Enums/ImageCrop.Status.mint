/* An enum for tracking the status of the dragging for the image cropper. */
enum Ui.ImageCrop.Status {
  /* The cropper is being dragged (manipulated). */
  Dragging(
    directions : Tuple(Ui.ImageCrop.Direction, Ui.ImageCrop.Direction),
    startValue : Ui.ImageCrop.Value,
    startEvent : Html.Event)

  /* The cropper is idle. */
  Idle
}
