/* A component to display a pricing item / plan. */
component Ui.PricingItem {
  /* The information for the price - currency, value, period. */
  property price : Maybe(Tuple(String, String, String)) = Maybe.Nothing

  /* The maximum width of the component. */
  property maxWidth : Ui.Size = Ui.Size.Em(22)

  /* The size of the component. */
  property size : Ui.Size = Ui.Size.Inherit

  /* The slot for the image at the top. */
  property image : Html = <></>

  /* The slot for the description of the item. */
  property description : Html

  /* The slot for the actions - usually a single button. */
  property actions : Html

  /* The slot for the name below the image. */
  property name : Html

  /* The styles for the base. */
  style base {
    max-width: #{Ui.Size.toString(maxWidth)};
    font-size: #{Ui.Size.toString(size)};

    background: var(--content-color);
    color: var(--content-text);
    border-radius: 0.375em;
    padding: 3em 1em 1em;

    flex-direction: column;
    display: flex;
  }

  /* The styles for the price. */
  style price {
    font-family: var(--title-font-family);
    color: var(--title-color);
    text-align: center;
    line-height: 1;
    font-size: 4em;

    margin: 0.3em 0;

    > * {
      display: inline;
    }
  }

  /* The styles for the price value. */
  style value {
    font-weight: 500;
  }

  /* The styles for the price period. */
  style period {
    font-family: var(--font-family);
    font-size: 0.3em;
  }

  /* The styles for the currency. */
  style currency {
    vertical-align: super;
    font-size: 0.35em;

    margin-right: 0.25em;
    position: relative;
    top: -0.25em;
  }

  /* The styles for the image. */
  style image {
    color: var(--title-color);
    text-align: center;

    margin-bottom: 1.5em;
  }

  /* The styles for the name. */
  style name {
    font-family: var(--title-font-family);
    color: var(--title-color);
    text-align: center;
    font-weight: bold;
    font-size: 1.5em;
  }

  /* The styles for the description. */
  style description {
    padding: 0 1em;
    flex: 1;
  }

  /* Styles for the actions. */
  style actions {
    grid-auto-flow: column;
    grid-gap: 1em;
    display: grid;
  }

  /* Styles for the horizontal rules. */
  style hr {
    margin: 1.5em 0;
    width: 100%;

    border: 0;
    border-bottom: 0.125em solid var(--faded-color);
  }

  /* Renders the component. */
  fun render : Html {
    <div::base>
      if Html.isNotEmpty(image) {
        <div::image>
          image
        </div>
      }

      <div::name>
        name
      </div>

      <hr::hr/>

      if let Maybe.Just(item) = price {
        <div::price>
          <div::currency>
            item[0]
          </div>

          <div::value>
            item[1]
          </div>

          <div::period>
            item[2]
          </div>
        </div>
      }

      <div::description>
        <Ui.Content>
          description
        </Ui.Content>
      </div>

      <hr::hr/>

      <div::actions>
        actions
      </div>
    </div>
  }
}
