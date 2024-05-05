/* A component to display a brand image, which behaves like a link. */
component Ui.Brand {
  /* The size of the component. */
  property size : Ui.Size = Ui.Size.Em(1.25)

  /* The SVG icon to display before the text. */
  property icon : Html = <></>

  /* The name of the brand. */
  property name : String = ""

  /* The page to link to. */
  property href : String = ""

  /* The styles for the base element. */
  style base {
    grid-auto-flow: column;
    place-content: center;
    display: inline-grid;
    align-items: center;
    grid-gap: 0.5em;

    font-size: #{Ui.Size.toString(size)};
    text-decoration: none;
    color: inherit;
    outline: none;
  }

  /* Style for the name. */
  style name {
    font-weight: bold;
  }

  /* Style for the root element is it's a link. */
  style link {
    &:focus,
    &:hover {
      color: var(--primary-color);
    }
  }

  fun render : Html {
    let content =
      <>
        if Html.isNotEmpty(icon) {
          <Ui.Icon icon={icon}/>
        }

        <div::name>
          name
        </div>
      </>

    if String.isEmpty(href) {
      <div::base href={href}>
        content
      </div>
    } else {
      <a::base::link href={href}>
        content
      </a>
    }
  }
}
