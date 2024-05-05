/* A record for the image croppers value. */
type Ui.ImageCrop.Value {
  /* The URL of the image. */
  source : String,

  /* The height of the cropped area (normalized from 0 to 1). */
  height : Number,

  /* The width of the cropped area (normalized from 0 to 1). */
  width : Number,

  /* The left position of the cropped area (normalized from 0 to 1). */
  x : Number,

  /* The top position of the cropped area (normalized from 0 to 1). */
  y : Number
}
