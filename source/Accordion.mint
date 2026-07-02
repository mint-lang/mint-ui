/* An accordion component with collapsible content sections. */
component Ui.Accordion {
  /* The size of the accordion. */
  property size : Ui.Size = Ui.Size.Inherit

  /* The list of sections. Each section is a tuple of (key, title, content). */
  property sections : Array(Tuple(String, String, Html)) = []

  /* Whether or not multiple sections can be open at the same time. */
  property multiple : Bool = false

  /* Whether or not the accordion is disabled. */
  property disabled : Bool = false

  /* The set of currently open section keys. */
  state openSections : Set(String) = Set.empty()

  /* Styles for the accordion container. */
  style base {
    font-size: #{Ui.Size.toString(size)};
    font-family: var(--font-family);

    border: 0.0625em solid var(--content-border);
    border-radius: 0.375em;
    overflow: hidden;

    if disabled {
      filter: saturate(0) brightness(0.8) contrast(0.5);
      pointer-events: none;
    }
  }

  /* Styles for a section. */
  style section {
    &:not(:last-child) {
      border-bottom: 0.0625em solid var(--content-border);
    }
  }

  /* Styles for a section header. */
  style header {
    -webkit-appearance: none;
    appearance: none;
    background: var(--content-color);
    color: var(--content-text);
    font-family: var(--font-family);
    font-size: 1em;
    font-weight: bold;

    display: grid;
    grid-template-columns: 1fr auto;
    align-items: center;
    grid-gap: 0.5em;

    padding: 0.875em 1em;
    cursor: pointer;
    outline: none;
    width: 100%;
    border: 0;

    line-height: 1.4;
    text-align: left;

    &:hover {
      background: var(--content-faded-color);
    }

    &:focus-visible {
      background: var(--content-faded-color);
    }
  }

  /* Styles for the chevron icon. */
  style chevron (open : Bool) {
    transition: transform 200ms ease;
    display: grid;

    if open {
      transform: rotate(180deg);
    }
  }

  /* Styles for the section content. */
  style content (open : Bool) {
    background: var(--content-color);
    color: var(--content-text);
    overflow: hidden;

    if open {
      padding: 0 1em 0.875em 1em;
    } else {
      padding: 0;
      height: 0;
    }
  }

  /* Toggles a section open or closed. */
  fun toggleSection (key : String) : Promise(Void) {
    if Set.has(openSections, key) {
      next { openSections: Set.delete(openSections, key) }
    } else if multiple {
      next { openSections: Set.add(openSections, key) }
    } else {
      next { openSections: Set.add(Set.empty(), key) }
    }
  }

  /* Renders the accordion. */
  fun render : Html {
    <div::base>
      {
        for section of sections {
          let {key, title, content} =
            section

          let open =
            Set.has(openSections, key)

          <div::section>
            <button::header onClick={(e : Html.Event) { toggleSection(key) }}>
              title

              <div::chevron(open)>
                <Ui.Icon icon={Ui.Icons.CHEVRON_DOWN}/>
              </div>
            </button>

            <div::content(open)>content</div>
          </div>
        }
      }
    </div>
  }
}
