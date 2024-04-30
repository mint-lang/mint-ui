/* A generic box component. */
component Ui.Box {
  /* The size of the box. */
  property size : Ui.Size = Ui.Size::Inherit

  /* Whether or not to fit the content to the extent of the box. */
  property fitContent : Bool = false

  /* The children to render. */
  property children : Array(Html) = []

  /* The title of the box. */
  property title : Html = <></>

  /* The label of the box. */
  property label : Html = <></>

  /* Styles for the base container. */
  style base {
    box-shadow: 0 0 0.625em var(--shadow-color);
    background: var(--content-color);
    color: var(--content-text);
    border-radius: 0.5em;
    padding: 1.25em;

    if fitContent {
      display: grid;
    }
  }

  /* Styles for the title. */
  style title {
    border-bottom: 0.0625em solid var(--title-border);
    padding-bottom: 0.5em;
    margin-bottom: 1em;

    font-family: var(--title-font-family);
    color: var(--title-color);
    font-weight: bold;
    font-size: 1.25em;
  }

  /* Styles for the label. */
  style label {
    padding-left: 0.75em;
    font-size: 0.875em;
    font-weight: bold;
    opacity: 0.85;
  }

  /* Styles for the wrapper element. */
  style wrapper {
    font-size: #{Ui.Size.toString(size)};
    grid-gap: 0.5em;
    display: grid;

    if Html.isNotEmpty(label) {
      grid-template-rows: auto 1fr;
    }
  }

  /* Renders the box. */
  fun render {
    <div::wrapper>
      if Html.isNotEmpty(label) {
        <div::label>
         label
        </div>
      }

      <div::base>
        if Html.isNotEmpty(title) {
          <div::title>
           title
          </div>
        }

        <Ui.Content fitContent={fitContent}>
         children
        </Ui.Content>
      </div>
    </div>
  }
}
