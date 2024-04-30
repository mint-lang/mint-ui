/* Renders a time relative from the current time in human readable language. */
component Ui.RelativeTime {
  /* The formatter for the text. */
  property formatter : Function(Time, Time, Time.Format.Language, String) = Time.distanceOfTimeInWords

  /* The language to use for time formatting. */
  property language : Time.Format.Language = Time.Format:ENGLISH

  /* The formatter for the title. */
  property titleFormatter : Function(Time.Format.Language, Time, String) =
    (language : Time.Format.Language, date : Time) {
      Time.format(date, language, "%F")
    }

  /* The date. */
  property date : Time

  /* The current time. */
  state now : Time = Time.now()

  use Provider.Tick { ticks: () { next { now: Time.now() } } }

  /* Styles for the component. */
  style base {
    display: inline-block;
  }

  /* Renders the component. */
  fun render : Html {
    <time::base title={titleFormatter(language, date)}>
      formatter(date, now, language)
    </time>
  }
}
