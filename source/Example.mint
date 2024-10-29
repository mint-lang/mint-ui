/* A component to display and example, controls and source code of a component. */
component Ui.Example {
  /* Highlights the given code (converts it to `Html`). */
  property highlight : Function(String, Html) = (code : String) { <>code</> }

  /* Controls the horizontal spacing between the elements. */
  property horizontalSpacing : Number = 0

  /* Controls the vertical spacing between the elements. */
  property verticalSpacing : Number = 0

  /* The example and its source code to display. */
  property data : Tuple(Html, String)

  /* Controls when to use a one column layout. */
  property breakpoint : Number = 1000

  /* Whether or not the example expands to full width. */
  property fullWidth : Bool = false

  /* The size of the component. */
  property size : Ui.Size = Ui.Size.Inherit

  /* The controls to display on the right. */
  property controls : Html = <></>

  /* The content for the warning area. */
  property warning : Html = <></>

  /* A state to hold the width of the component. */
  state width : Number = 0

  /* We are using this provider to update the `mobile` state. */
  use Provider.ElementSize { changes: updateWidth, element: base }

  /* the style for the base. */
  style base {
    font-size: #{Ui.Size.toString(size)};
    position: relative;
    grid-gap: 0.5em;
    display: grid;

    if mobile || !Html.isNotEmpty(controls) {
      grid-template-columns: 1fr;
    } else {
      grid-template-columns: 1fr auto;
    }
  }

  /* The style for the demo-area. */
  style demo-area {
    background: linear-gradient(45deg, var(--checker-color-1) 25%, transparent 25%, transparent 75%, var(--checker-color-1) 75%, var(--checker-color-1)),
                linear-gradient(45deg, var(--checker-color-1) 25%, transparent 25%, transparent 75%, var(--checker-color-1) 75%, var(--checker-color-1));

    background-position: 0 0, 0.625em 0.625em;
    background-color: var(--checker-color-2);
    background-size: 1.25em 1.25em;

    box-shadow: 0 0 0.625em var(--shadow-color);
    border-radius: 0.5em;
    overflow: hidden;
    padding: 2em;

    justify-content: center;
    align-items: center;
    display: flex;
  }

  /* The style for the demo-area wrapper. */
  style demo-area-wrapper {
    if horizontalSpacing > 0 && !mobile {
      grid-gap: #{horizontalSpacing}px;
      grid-auto-flow: column;
      align-items: center;
    }

    if fullWidth {
      width: 100%;
    }

    if mobile {
      grid-gap: #{horizontalSpacing}px;
    }

    if mobile && !fullWidth {
      justify-items: center;
    }

    if verticalSpacing > 0 {
      grid-gap: #{verticalSpacing}px;
    }

    display: grid;
  }

  /* The style for the code. */
  style code {
    display: grid;

    if mobile || !Html.isNotEmpty(controls) {
      grid-column: 1;
    } else {
      grid-column: span 2;
    }
  }

  /* The style for the controls. */
  style controls {
    box-shadow: 0 0 0.625em var(--shadow-color);
    background: var(--content-color);
    color: var(--content-text);

    border-radius: 0.5em;
    padding: 1em;

    align-content: start;
    align-items: start;
    grid-gap: 1em;
    display: grid;

    if mobile {
      min-width: 0;
    } else {
      min-width: 16em;
    }
  }

  /* Returns if we need to use the mobile version or not. */
  get mobile : Bool {
    width < breakpoint
  }

  /* Updates the `mobile` state based on the dimensions and breakpoint. */
  fun updateWidth (dimensions : Dom.Dimensions) {
    next { width: dimensions.width }
  }

  /* Renders the component. */
  fun render : Html {
    let {content, code} =
      data

    <div::base as base>
      if Html.isNotEmpty(warning) {
        warning
      }

      <div::demo-area><div::demo-area-wrapper>content</div></div>

      if Html.isNotEmpty(controls) {
        <div::controls>controls</div>
      }

      <div::code>highlight(code)</div>
    </div>
  }
}
