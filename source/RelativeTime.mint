/* Renders a time relative from the current time in human readable language. */
component Ui.RelativeTime {
  /* The date. */
  property date : Time

  /* The current time. */
  state now : Time = Time.now()

  use Provider.Tick { ticks = () { next { now = Time.now() } } }

  /* Styles for the component. */
  style base {
    display: inline-block;
  }

  /* Renders the component. */
  fun render : Html {
    <time::base title={Time.toIso(date)}>
      <{ Time.relative(now, date) }>
    </time>
  }
}
