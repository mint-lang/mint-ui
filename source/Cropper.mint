component Ui.Cropper {
  /* The `change` event handler. */
  property onChange : Function(Ui.Cropper.Value, Promise(Never, Void)) = Promise.never1

  /* Whether or not to embed the panel (removes border and padding). */
  property embedded : Bool = false

  /* The value (crop data). */
  property value : Ui.Cropper.Value =
    {
      source = "",
      height = 0.5,
      width = 0.5,
      x = 0.25,
      y = 0.25
    }

  /* The status. */
  state status = Ui.Cropper.Status::Idle

  /* Styles for the base element. */
  style base {
    user-select: none;

    if (!embedded) {
      border: 0.0625em solid var(--input-border);
      background: var(--input-color);
      color: var(--input-text);
      border-radius: 0.375em;
      padding: 1em;
    }

    &:focus {
      outline: 0;
    }
  }

  /* Styles for the image itself. */
  style image {
    display: block;
    width: 100%;
  }

  /* Styles for the image wrapper. */
  style image-wrapper {
    position: relative;
    overflow: hidden;
  }

  /* Styles for the image overlay. */
  style image-overlay {
    outline: 4000px solid rgba(0, 0, 0, 0.5);
  }

  /* Styles for the cutout. */
  style cutout {
    height: calc(#{value.height * 100}%;
    width: calc(#{value.width * 100}%;
    box-sizing: border-box;
    left: #{value.x * 100}%;
    top: #{value.y * 100}%;
    position: absolute;
  }

  /* Styles for the crop area. */
  style crop-area {
    /* Marching ants border. */
    border-image: url(#{@asset(../assets/images/ants.gif)});
    border-image-repeat: repeat;
    border-width: 0.0625em;
    border-image-slice: 1;
    border-style: solid;

    cursor: move;
  }

  /* Styles for the wrapper element. */
  style wrapper {
    position: relative;
  }

  /* Styles for a crop handle. */
  style crop-handle (corner : String) {
    background-color: rgba(0, 0, 0, 0.2);

    box-shadow: 0 0 0 0.0625em rgba(0, 0, 0, 0.5);
    border: 0.0625em solid rgba(255, 255, 255, 0.7);

    position: absolute;
    height: 0.75em;
    width: 0.75em;

    case (corner) {
      "top-left" =>
        cursor: nw-resize;
        left: -0.375em;
        top: -0.375em;

      "top-right" =>
        right: calc((0.375em + 0.0625em) * -1);
        cursor: ne-resize;
        top: -0.375em;

      "bottom-left" =>
        bottom: calc((0.375em + 0.0625em) * -1);
        cursor: sw-resize;
        left: -0.375em;

      "bottom-right" =>
        bottom: calc((0.375em + 0.0625em) * -1);
        right: calc((0.375em + 0.0625em) * -1);
        cursor: se-resize;

      =>
    }
  }

  /* The provider to track the mouse while dragging. */
  use Provider.Mouse {
    clicks = Promise.never1,
    moves = moves,
    ups = ups
  } when {
    status != Ui.Cropper.Status::Idle
  }

  /* Calculates the next position and size based on a direction for an axis. */
  fun calculateAxis (
    direction : Ui.Cropper.Direction,
    startSize : Number,
    startPosition : Number,
    distance : Number
  ) {
    case (direction) {
      Ui.Cropper.Direction::Backward =>
        try {
          /* Clamp the distance to the minimum and maximum possible values. */
          clampedDistance =
            Math.clamp(
              -startPosition + startSize,
              1 - (startPosition + startSize),
              distance)

          /*
          Caclulate new size. In this case moving down/right we need
          to add the distance to the size.
          */
          size =
            startSize + clampedDistance

          /* Calculate new position based on size. */
          position =
            startPosition + Math.clamp(-1, 0, size)

          {position, size}
        }

      Ui.Cropper.Direction::Forward =>
        try {
          /* Clamp the distance to the minimum and maximum possible values. */
          clampedDistance =
            Math.clamp(
              -startPosition,
              1 - startPosition,
              distance)

          /*
          Caclulate new size. In this case moving up/left we need
          to subtract the distance from the size.
          */
          size =
            startSize - clampedDistance

          /* Calculate new position based on size and distance. */
          position =
            startPosition + clampedDistance + Math.clamp(-1, 0, size)

          {position, size}
        }

      /* This is the clearest case since we are just moving the crop area. */
      Ui.Cropper.Direction::Move =>
        {
          Math.clamp(0, 1 - startSize, startPosition + distance),
          startSize
        }
    }
  }

  /* Handles the move event. */
  fun moves (event : Html.Event) : Promise(Never, Void) {
    case (base) {
      Maybe::Just element =>
        try {
          dimensions =
            Dom.getDimensions(element)

          case (status) {
            Ui.Cropper.Status::Dragging directions startValue startEvent =>
              try {
                /* Caclulate the moved distance as a percentage of the image. */
                distance =
                  {
                    (event.pageX - startEvent.pageX) / dimensions.width,
                    (event.pageY - startEvent.pageY) / dimensions.height
                  }

                /* Calculate the new values for the horizontal axis. */
                {x, width} =
                  calculateAxis(
                    directions[0],
                    startValue.width,
                    startValue.x,
                    distance[0])

                /* Calculate the new values for the vertical axis. */
                {y, height} =
                  calculateAxis(
                    directions[1],
                    startValue.height,
                    startValue.y,
                    distance[1])

                /* Call the change event handler with the new value. */
                onChange(
                  { value |
                    height = Math.abs(height),
                    width = Math.abs(width),
                    y = y,
                    x = x
                  })
              }

            => next {  }
          }
        }

      => next {  }
    }
  }

  fun ups (event : Html.Event) : Promise(Never, Void) {
    next { status = Ui.Cropper.Status::Idle }
  }

  fun startDrag (
    directions : Tuple(Ui.Cropper.Direction, Ui.Cropper.Direction),
    event : Html.Event
  ) {
    try {
      Html.Event.stopPropagation(event)

      next
        {
          status =
            Ui.Cropper.Status::Dragging(
              directions = directions,
              startValue = value,
              startEvent = event)
        }
    }
  }

  fun render {
    <div::base as base tabindex="0">
      <div::wrapper>
        <div::image-wrapper>
          <img::image src={value.source}/>
          <div::image-overlay::cutout/>
        </div>

        <div::crop-area::cutout
          onMouseDown={
            startDrag(
              {
                Ui.Cropper.Direction::Move,
                Ui.Cropper.Direction::Move
              })
          }>

          <div::crop-handle("top-left")
            onMouseDown={
              startDrag(
                {
                  Ui.Cropper.Direction::Forward,
                  Ui.Cropper.Direction::Forward
                })
            }/>

          <div::crop-handle("top-right")
            onMouseDown={
              startDrag(
                {
                  Ui.Cropper.Direction::Backward,
                  Ui.Cropper.Direction::Forward
                })
            }/>

          <div::crop-handle("bottom-left")
            onMouseDown={
              startDrag(
                {
                  Ui.Cropper.Direction::Forward,
                  Ui.Cropper.Direction::Backward
                })
            }/>

          <div::crop-handle("bottom-right")
            onMouseDown={
              startDrag(
                {
                  Ui.Cropper.Direction::Backward,
                  Ui.Cropper.Direction::Backward
                })
            }/>

        </div>
      </div>
    </div>
  }
}
