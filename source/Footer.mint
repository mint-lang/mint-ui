/* A simple website footer component. */
component Ui.Footer {
  connect Ui exposing { mobile }

  /* The navigation items to display on the right side. */
  property navitems : Array(Tuple(String, Array(Ui.NavItem))) = []

  /* The `white-space` CSS value for the categories. */
  property categoryWhiteSpace : String = "initial"

  /* The size of the component. */
  property size : Ui.Size = Ui.Size.Inherit

  /* The content to display on the left side. */
  property infos : Html = <></>

  /* Styles for the base element. */
  style base {
    border-top: 0.1825em solid var(--content-border);
    grid-template-columns: 1fr auto;
    grid-gap: 5em;
    display: grid;

    font-size: #{Ui.Size.toString(size)};
    overflow: hidden;
    margin-top: 2em;
    padding: 3em 0;

    if mobile {
      grid-template-columns: 1fr;
      margin-top: 1em;
      padding: 1em 0;
      grid-gap: 1em;
    }
  }

  /* Styles for the infos content. */
  style infos {
    align-self: center;
  }

  /* Styles for the navigation item categories. */
  style categories {
    white-space: #{categoryWhiteSpace};
    margin: -1em -2.5em;
    flex-wrap: wrap;
    display: flex;

    if mobile {
      padding-right: 0;
    } else {
      padding-right: 1em;
    }
  }

  /* Styles for a navigation item category. */
  style category {
    align-content: start;
    grid-gap: 1em;
    display: grid;

    margin: 1em 2.5em;
    flex: 1;
  }

  /* Renders the component. */
  fun render : Html {
    <div::base>
      <div::infos>infos</div>

      <div::categories>
        for item of navitems {
          <div::category>
            <strong>item[0]</strong>
            <Ui.NavItems items={item[1]}/>
          </div>
        }
      </div>
    </div>
  }
}
