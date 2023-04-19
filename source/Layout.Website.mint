/* A vertical layout which usually good for normal websites. */
component Ui.Layout.Website {
  connect Ui exposing { mobile }

  /* Whether or not to align the content to the top. */
  property alignContentToTop : Bool = false

  /* Content for the notification area. */
  property notification : Html = <></>

  /* Content for the breadcrumbs area. */
  property breadcrumbs : Html = <></>

  /* Content for the main area. */
  property content : Html = <></>

  /* Content for the footer area. */
  property footer : Html = <></>

  /* Content for the header area. */
  property header : Html = <></>

  /* Whether or not center the whole layout on the screen. */
  property centered : Bool = true

  /* The maximum width of the layout. */
  property maxWidth : String = "100vw"

  /* Styles for the base element. */
  style base {
    max-width: #{maxWidth};
    min-height: 100vh;
    min-width: 320px;

    grid-template-rows: #{rows};
    display: grid;

    box-sizing: border-box;
    padding: 1em 2.5em 0;

    if (mobile) {
      padding: 0.5em 1em 0;
    } else if (centered) {
      width: clamp(20em, 100%, 100em);
      margin-right: auto;
      margin-left: auto;
    }

    > * {
      min-width: 0;

      &:not(:last-child) {
        border-bottom: 1px solid var(--border);
      }

      &:empty {
        display: none;
      }
    }
  }

  style breadcrumbs {
    padding-bottom: 0.5em;
  }

  /* Style for the content. */
  style content {
    padding: 1em 0;
    display: grid;

    if (alignContentToTop) {
      align-content: start;
    }
  }

  /* Returns the data for the `grid-template-rows` CSS property. */
  get rows {
    [
      {notification, "min-content"},
      {header, "min-content"},
      {breadcrumbs, "min-content"},
      {content, "1fr"},
      {footer, "min-content"}
    ]
    |> Array.map(
      (item : Tuple(Html, String)) {
        let {html, ratio} =
          item

        if (Html.isNotEmpty(html)) {
          Maybe::Just(ratio)
        } else {
          Maybe::Nothing
        }
      })
    |> Array.compact
    |> String.join(" ")
  }

  /* Renders the component. */
  fun render : Html {
    <div::base>
      if (Html.isNotEmpty(notification)) {
        <div>
          <{ notification }>
        </div>
      }

      if (Html.isNotEmpty(header)) {
        <div>
          <{ header }>
        </div>
      }

      if (Html.isNotEmpty(breadcrumbs)) {
        <div::breadcrumbs>
          <{ breadcrumbs }>
        </div>
      }

      if (Html.isNotEmpty(content)) {
        <div::content>
          <{ content }>
        </div>
      }

      if (Html.isNotEmpty(footer)) {
        <div>
          <{ footer }>
        </div>
      }
    </div>
  }
}
