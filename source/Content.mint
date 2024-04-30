/*
A component to display content:

- Headings (<h1>, <h2>, <h3>, etc...)
- Paragraphs (<p>)
- Ordered and unordered lists (<ol>, <ul>)
- Images (<img>)
- Preformatted text (<code>, <pre>)
- Keyboard shortcuts (<kbd>)
*/
component Ui.Content {
  connect Ui exposing { mobile }

  /* The size of the content. */
  property size : Ui.Size = Ui.Size.Inherit

  /* Whether or not to fit the content to the extent of the base element. */
  property fitContent : Bool = false

  /* The children to display. */
  property children : Array(Html) = []

  /* Where to align the text. */
  property textAlign : String = ""

  property key : String = ""

  /* The styles for the contents. */
  style base {
    font-size: #{Ui.Size.toString(size)};
    font-family: var(--font-family);
    text-align: #{textAlign};
    word-break: break-word;
    line-height: 1.7;

    if fitContent {
      display: grid;
    }

    > *:first-child {
      margin-top: 0;
    }

    > *:last-child {
      margin-bottom: 0;
    }

    h1,
    h2,
    h3,
    h4,
    h5 {
      margin-bottom: 0.35em;
      margin-top: 2em;

      line-height: 1.2em;
    }

    h1 + *,
    h2 + *,
    h3 + *,
    h4 + *,
    h5 + * {
      margin-top: 0;
    }

    ul,
    ol {
      padding-left: 1.5em;
    }

    li + li {
      margin-top: 0.5em;
    }

    a:not([name]):not([class]) {
      color: var(--primary-color);
      text-decoration: none;

      code:not([class]),
      kbd:not([class]) {
        color: inherit;
      }

      &:focus {
        outline: 0.125em dotted var(--primary-color);
        text-decoration: underline;
        outline-offset: 0.125em;
      }

      &[target="_blank"]:after {
        transform: scaleX(-1);
        display: inline-block;
        margin-left: 0.1em;
        content: " ⎋";
      }
    }

    code:not([class]),
    kbd:not([class]) {
      border: 0.0625em solid var(--input-border);
      background: var(--input-color);
      color: var(--input-text);

      padding: 0.35em 0.45em 0.2em;
      border-radius: 0.25em;
      font-size: 0.875em;
    }

    kbd:not([class]) {
      border-bottom: 0.1875em solid var(--input-border);
    }

    pre:not([class]) code:not([class]) {
      padding: 0.5em 0.75em;
      display: block;
    }

    video:not([class]),
    img:not([class]) {
      border-radius: 0.25em;
      width: 100%;
    }
  }

  /* Renders the content. */
  fun render : Html {
    <div::base key={key}>
      children
    </div>
  }
}
