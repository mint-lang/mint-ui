/* A component to render raw HTML. */
component Ui.Html {
  /* The raw HTML to render. */
  property content : String = ""

  /* Renders the component. */
  fun render : Html {
    <div dangerouslySetInnerHTML={`{__html: #{content}}`}/>
  }
}
