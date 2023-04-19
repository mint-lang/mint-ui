/* A simple image cropping component. */
component Ui.ImageCrop {
  connect Ui exposing { mobile }

  /* Called when the position and size is updated. */
  property onUpdate : Function(Ui.ContainedImage, Promise(Void)) = Promise.never1

  /* The `change` event handler. */
  property onChange : Function(Ui.ImageCrop.Value, Promise(Void)) = Promise.never1

  /* The size of the component. */
  property size : Ui.Size = Ui.Size::Inherit

  /* Whether or not to embed the panel (removes border and padding). */
  property embedded : Bool = false

  /* The value (crop data). */
  property value : Ui.ImageCrop.Value =
    {
      source: "",
      height: 0.5,
      width: 0.5,
      x: 0.25,
      y: 0.25
    }

  /* A state to hold the dimensions of the image. */
  state position : Ui.ContainedImage =
    {
      originalHeight: 0,
      originalWidth: 0,
      currentHeight: 0,
      currentWidth: 0,
      left: 0,
      top: 0
    }

  /* The status. */
  state status = Ui.ImageCrop.Status::Idle

  /* The provider to track the pointer while dragging. */
  use Provider.Pointer {
    downs: Promise.never1,
    moves: moves,
    ups: ups
  } when {
    status != Ui.ImageCrop.Status::Idle
  }

  /* Styles for the base element. */
  style base {
    font-size: #{Ui.Size.toString(size)};
    position: relative;
    user-select: none;
    display: grid;

    > *:first-child {
      border: 0.0625em solid var(--input-border);
      border-radius: 0.375em;
    }

    if (!embedded) {
      border: 0.0625em solid var(--input-border);
      background: var(--input-color);
      color: var(--input-text);
      border-radius: 0.375em;
      padding: 1em;
    }

    &:focus {
      outline: 0;

      if (!embedded) {
        border-color: var(--input-focus-border);
        background: var(--input-focus-color);
        color: var(--input-focus-text);
      }
    }
  }

  /* The style for the wrapper. */
  style wrapper (overflow : bool) {
    height: calc(#{position.currentHeight}px + 1px);
    width: calc(#{position.currentWidth}px + 1px);
    position: absolute;

    if (overflow) {
      overflow: hidden;
    }

    if (!embedded) {
      left: calc(#{position.left}px + 1em + 1px);
      top: calc(#{position.top}px + 1em + 1px);
    } else {
      left: #{position.left}px;
      top: #{position.top}px;
    }
  }

  /* Styles for the image overlay. */
  style overlay {
    outline: 4000px solid rgba(0, 0, 0, 0.5);
  }

  /* Styles for the cutout. */
  style cutout {
    height: #{value.height * 100}%;
    width: #{value.width * 100}%;
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
    border-image-slice: 1;
    border-style: solid;
    border-width: 1px;
    cursor: move;
  }

  /* Styles for a crop handle. */
  style crop-handle (corner : String) {
    border: 0.0625em solid rgba(255, 255, 255, 0.7);
    box-shadow: 0 0 0 0.0625em rgba(0, 0, 0, 0.5);
    background-color: rgba(0, 0, 0, 0.2);

    position: absolute;
    height: var(--size);
    width: var(--size);

    if (mobile) {
      --size: 1.5em;
    } else {
      --size: 0.75em;
    }

    case (corner) {
      "top-left" =>
        left: calc((var(--size) / 2 + 1px) * -1);
        top: calc((var(--size) / 2 + 1px) * -1);
        cursor: nw-resize;

      "top-right" =>
        right: calc((var(--size) / 2 + 1px) * -1);
        top: calc((var(--size) / 2 + 1px) * -1);
        cursor: ne-resize;

      "bottom-left" =>
        bottom: calc((var(--size) / 2 + 1px) * -1);
        left: calc((var(--size) / 2 + 1px) * -1);
        cursor: sw-resize;

      "bottom-right" =>
        bottom: calc((var(--size) / 2 + 1px) * -1);
        right: calc((var(--size) / 2 + 1px) * -1);
        cursor: se-resize;

      =>
    }
  }

  /* Calculates the next position and size based on a direction for an axis. */
  fun calculateAxis (
    direction : Ui.ImageCrop.Direction,
    startPosition : Number,
    startSize : Number,
    distance : Number
  ) {
    case (direction) {
      Ui.ImageCrop.Direction::Backward =>
        {
          /* Clamp the distance to the minimum and maximum possible values. */
          let clampedDistance =
            Math.clamp(
              distance,
              -startPosition + startSize,
              1 - (startPosition + startSize))

          /*
          Calculate new size. In this case moving down/right we need
          to add the distance to the size.
          */
          let size =
            startSize + clampedDistance

          /* Calculate new position based on size. */
          let position =
            startPosition + Math.clamp(size, -1, 0)

          {position, size}
        }

      Ui.ImageCrop.Direction::Forward =>
        {
          /* Clamp the distance to the minimum and maximum possible values. */
          let clampedDistance =
            Math.clamp(
              distance,
              -startPosition,
              1 - startPosition)

          /*
          Calculate new size. In this case moving up/left we need
          to subtract the distance from the size.
          */
          let size =
            startSize - clampedDistance

          /* Calculate new position based on size and distance. */
          let position =
            startPosition + clampedDistance + Math.clamp(size, -1, 0)

          {position, size}
        }

      /* This is the clearest case since we are just moving the crop area. */
      Ui.ImageCrop.Direction::Move =>
        {
          Math.clamp(startPosition + distance, 0, 1 - startSize),
          startSize
        }
    }
  }

  /* Handles the move event. */
  fun moves (event : Html.Event) : Promise(Void) {
    case (base) {
      Maybe::Just(element) =>
        case (status) {
          Ui.ImageCrop.Status::Dragging(directions, startValue, startEvent) =>
            {
              /* Calculate the moved distance as a percentage of the image. */
              let distance =
                {
                  (event.pageX - startEvent.pageX) / position.currentWidth,
                  (event.pageY - startEvent.pageY) / position.currentHeight
                }

              /* Calculate the new values for the horizontal axis. */
              let {x, width} =
                calculateAxis(
                  directions[0],
                  startValue.x,
                  startValue.width,
                  distance[0])

              /* Calculate the new values for the vertical axis. */
              let {y, height} =
                calculateAxis(
                  directions[1],
                  startValue.y,
                  startValue.height,
                  distance[1])

              /* Call the change event handler with the new value. */
              onChange(
                { value |
                  height: Math.abs(height),
                  width: Math.abs(width),
                  y: y,
                  x: x
                })
            }

          => next { }
        }

      => next { }
    }
  }

  /* Handles the up event. */
  fun ups (event : Html.Event) : Promise(Void) {
    next { status: Ui.ImageCrop.Status::Idle }
  }

  /* Starts the drag. */
  fun startDrag (
    directions : Tuple(Ui.ImageCrop.Direction, Ui.ImageCrop.Direction),
    event : Html.Event
  ) {
    Html.Event.stopPropagation(event)

    next
      {
        status:
          Ui.ImageCrop.Status::Dragging(
            directions: directions,
            startValue: value,
            startEvent: event)
      }
  }

  /* Handles the keydown event. */
  fun handleKeyDown (event : Html.Event) {
    let updatedValue =
      case (event.keyCode) {
        Html.Event:DOWN_ARROW =>
          Maybe::Just({ value | y: Math.clamp(value.y + 0.005, 0, 1 - value.height) })

        Html.Event:RIGHT_ARROW =>
          Maybe::Just({ value | x: Math.clamp(value.x + 0.005, 0, 1 - value.width) })

        Html.Event:LEFT_ARROW =>
          Maybe::Just({ value | x: Math.clamp(value.x - 0.005, 0, 1) })

        Html.Event:UP_ARROW =>
          Maybe::Just({ value | y: Math.clamp(value.y - 0.005, 0, 1) })

        => Maybe::Nothing
      }

    case (updatedValue) {
      Maybe::Just(newValue) =>
        {
          Html.Event.preventDefault(event)
          onChange(newValue)
        }

      Maybe::Nothing => next { }
    }
  }

  /* Updates the position of the image. */
  fun updatePosition (value : Ui.ContainedImage) {
    await next { position: value }
    onUpdate(value)
  }

  /* Renders the component. */
  fun render {
    <div::base as base
      onKeyDown={handleKeyDown}
      tabindex="0">

      <Ui.ContainedImage
        onUpdate={updatePosition}
        src={value.source}/>

      <div::wrapper(true)>
        <div::overlay::cutout/>
      </div>

      <div::wrapper(false)>
        <div::crop-area::cutout
          onPointerDown={
            (event : Html.Event) {
              startDrag(
                {
                  Ui.ImageCrop.Direction::Move,
                  Ui.ImageCrop.Direction::Move
                },
                event)
            }
          }>

          <div::crop-handle("top-left")
            onPointerDown={
              (event : Html.Event) {
                startDrag(
                  {
                    Ui.ImageCrop.Direction::Forward,
                    Ui.ImageCrop.Direction::Forward
                  },
                  event)
              }
            }/>

          <div::crop-handle("top-right")
            onPointerDown={
              (event : Html.Event) {
                startDrag(
                  {
                    Ui.ImageCrop.Direction::Backward,
                    Ui.ImageCrop.Direction::Forward
                  },
                  event)
              }
            }/>

          <div::crop-handle("bottom-left")
            onPointerDown={
              (event : Html.Event) {
                startDrag(
                  {
                    Ui.ImageCrop.Direction::Forward,
                    Ui.ImageCrop.Direction::Backward
                  },
                  event)
              }
            }/>

          <div::crop-handle("bottom-right")
            onPointerDown={
              (event : Html.Event) {
                startDrag(
                  {
                    Ui.ImageCrop.Direction::Backward,
                    Ui.ImageCrop.Direction::Backward
                  },
                  event)
              }
            }/>

        </div>
      </div>

    </div>
  }
}
