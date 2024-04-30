/* Represents the store which all components connect to. */
store Ui {
  const DEFAULT_FONT_CONFIGURATION =
    {
      titleWoff2: @asset(../assets/fonts/nunito-v16-latin-ext_latin-700.woff2),
      titleWoff: @asset(../assets/fonts/nunito-v16-latin-ext_latin-700.woff),
      titleName: "Nunito",
      regularWoff2: @asset(../assets/fonts/open-sans-v18-latin-ext_latin-regular.woff2),
      regularWoff: @asset(../assets/fonts/open-sans-v18-latin-ext_latin-regular.woff),
      boldWoff2: @asset(../assets/fonts/open-sans-v18-latin-ext_latin-700.woff2),
      boldWoff: @asset(../assets/fonts/open-sans-v18-latin-ext_latin-700.woff2),
      name: "Open Sans"
    }

  const DEFAULT_TOKENS =
    [
      Ui.Token::Schemed(name: "background-border", light: "#D0D0D0", dark: "#1A1A1A"),
      Ui.Token::Schemed(name: "background-color", light: "#F0F0F0", dark: "#222222"),
      Ui.Token::Schemed(name: "background-text", light: "#444444", dark: "#EEEEEE"),
      Ui.Token::Schemed(name: "content-faded-border", light: "#DDD", dark: "#242424"),
      Ui.Token::Schemed(name: "content-faded-color", light: "#EEE", dark: "#2C2C2C"),
      Ui.Token::Schemed(name: "content-faded-text", light: "#555", dark: "#CCC"),
      Ui.Token::Schemed(name: "content-border", light: "#DDD", dark: "#292929"),
      Ui.Token::Schemed(name: "content-color", light: "#FFF", dark: "#333"),
      Ui.Token::Schemed(name: "content-text", light: "#555", dark: "#CCC"),
      Ui.Token::Schemed(name: "shadow-color", light: "#00000010", dark: "#00000025"),
      Ui.Token::Schemed(name: "scrollbar-track", light: "#FFF", dark: "#393939"),
      Ui.Token::Schemed(name: "scrollbar-thumb", light: "#DDD", dark: "#555"),
      Ui.Token::Simple(name: "selection-color", value: "var(--primary-color)"),
      Ui.Token::Simple(name: "selection-text", value: "var(--primary-text)"),
      Ui.Token::Simple(name: "scroll-shadow-from", value: "#00000000"),
      Ui.Token::Simple(name: "scroll-shadow-to", value: "#00000030"),
      Ui.Token::Schemed(name: "navitem-border", light: "#EDEDED", dark: "#2A2A2A"),
      Ui.Token::Schemed(name: "checker-color-1", light: "#F0F0F0", dark: "#303030"),
      Ui.Token::Schemed(name: "checker-color-2", light: "#F6F6F6", dark: "#2A2A2A"),
      Ui.Token::Schemed(name: "input-border", light: "#DDD", dark: "#232323"),
      Ui.Token::Schemed(name: "input-color", light: "#F3F3F3", dark: "#2D2D2D"),
      Ui.Token::Schemed(name: "input-text", light: "#555", dark: "#CCC"),
      Ui.Token::Schemed(name: "input-focus-border", light: "#c2e3fd", dark: "#1f313c"),
      Ui.Token::Schemed(name: "input-focus-color", light: "#D8EEFF", dark: "#354c5e"),
      Ui.Token::Schemed(name: "input-focus-text", light: "#306F9F", dark: "#A5CDEC"),
      Ui.Token::Schemed(name: "input-invalid-border", light: "#F4B0AB", dark: "#481B17"),
      Ui.Token::Schemed(name: "input-invalid-color", light: "#FDD3D0", dark: "#7D3E39"),
      Ui.Token::Schemed(name: "input-invalid-text", light: "#6A332F", dark: "#E8D1CF"),
      Ui.Token::Schemed(name: "title-border", light: "#EEE", dark: "#2A2A2A"),
      Ui.Token::Schemed(name: "title-color", light: "#333", dark: "#F6F6F6"),
      Ui.Token::Schemed(name: "primary-light-color", light: "#E9F5FF", dark: "#354553"),
      Ui.Token::Schemed(name: "primary-light-text", light: "#284459", dark: "#c5e2f9"),
      Ui.Token::Simple(name: "primary-focus-ring", value: "#FFFFFF95"),
      Ui.Token::Simple(name: "primary-hover", value: "#1D7AC1"),
      Ui.Token::Simple(name: "primary-color", value: "#0591FC"),
      Ui.Token::Simple(name: "primary-text", value: "#FFF"),
      Ui.Token::Schemed(name: "warning-light-color", light: "#FFEDCE", dark: "#6A5021"),
      Ui.Token::Schemed(name: "warning-light-text", light: "#4a4740", dark: "#eee4cf"),
      Ui.Token::Simple(name: "warning-focus-ring", value: "#FFFFFF95"),
      Ui.Token::Simple(name: "warning-hover", value: "#DB8E0A"),
      Ui.Token::Simple(name: "warning-color", value: "#F59E0B"),
      Ui.Token::Simple(name: "warning-text", value: "#FFF"),
      Ui.Token::Schemed(name: "secondary-focus-ring", light: "#FFFFFF95", dark: "#00000095"),
      Ui.Token::Schemed(name: "secondary-light-color", light: "#DDD", dark: "#444"),
      Ui.Token::Schemed(name: "secondary-light-text", light: "#444", dark: "#EEE"),
      Ui.Token::Schemed(name: "secondary-hover", light: "#545454", dark: "#C6C6C6"),
      Ui.Token::Schemed(name: "secondary-color", light: "#444", dark: "#E6E6E6"),
      Ui.Token::Schemed(name: "secondary-text", light: "#FFF", dark: "#333"),
      Ui.Token::Schemed(name: "success-light-color", light: "#C5FFEC", dark: "#204F3F"),
      Ui.Token::Schemed(name: "success-light-text", light: "#37574d", dark: "#c6f4e6"),
      Ui.Token::Simple(name: "success-focus-ring", value: "#FFFFFF95"),
      Ui.Token::Simple(name: "success-hover", value: "#0C885F"),
      Ui.Token::Simple(name: "success-color", value: "#10B981"),
      Ui.Token::Simple(name: "success-text", value: "#FFF"),
      Ui.Token::Schemed(name: "danger-light-color", light: "#FBE5E5", dark: "#752D2D"),
      Ui.Token::Schemed(name: "danger-light-text", light: "#463636", dark: "#e1b5b5"),
      Ui.Token::Simple(name: "danger-focus-ring", value: "#FFFFFF95"),
      Ui.Token::Simple(name: "danger-hover", value: "#BD2525"),
      Ui.Token::Simple(name: "danger-color", value: "#EF4444"),
      Ui.Token::Simple(name: "danger-text", value: "#FFF"),
      Ui.Token::Schemed(name: "faded-light-color", light: "#00000015", dark: "#FFFFFF15"),
      Ui.Token::Schemed(name: "faded-light-text", light: "#555", dark: "#CCC"),
      Ui.Token::Schemed(name: "faded-focus-ring", light: "#00000095", dark: "#FFFFFF95"),
      Ui.Token::Schemed(name: "faded-hover", light: "#00000025", dark: "#FFFFFF25"),
      Ui.Token::Schemed(name: "faded-color", light: "#00000015", dark: "#FFFFFF15"),
      Ui.Token::Schemed(name: "faded-text", light: "#555", dark: "#CCC")
    ]

  state images : Set(String) = Set.empty()

  fun setImageLoaded (src : String) {
    next { images: Set.add(images, src) }
  }

  /* Whether or not we are in a mobile view. */
  state mobile : Bool = Window.matchesMediaQuery("(max-width: 1000px)")

  /* Whether or not to show dark mode. */
  state darkMode : Bool =
    case Storage.Local.get("ui.dark-mode") {
      Result::Err => Window.matchesMediaQuery("(prefers-color-scheme: dark)")
      Result::Ok(value) => value == "true"
    }

  /* A media query listener for to set mobile property. */
  state mediaQueryListener =
    Window.addMediaQueryListener(
      "(max-width: 1000px)",
      (active : Bool) { next { mobile: active } })

  fun toggleDarkMode : Promise(Void) {
    setDarkMode(!darkMode)
  }

  /* Sets the dark mode state. */
  fun setDarkMode (value : Bool) : Promise(Void) {
    case Storage.Local.set("ui.dark-mode", Bool.toString(value)) {
      Result::Err => Debug.log("Could not save dark mode setting to LocalStorage!")
      Result::Ok => ""
    }

    next { darkMode: value }
  }

  /* A function to not do anything based on a disabled argument. */
  fun disabledHandler (
    disabled : Bool,
    handler : Function(a, Promise(Void))
  ) : Function(a, Promise(Void)) {
    if disabled {
      Promise.never1
    } else {
      handler
    }
  }

  /* A function to handle changes from input delay. */
  fun inputDelayHandler (timeoutId : Number, delay : Number, event : Html.Event) : Tuple(Number, String, Promise(Void)) {
    let {resolve, promise} =
      Promise.create()

    let value =
      Dom.getValue(event.target)

    `clearTimeout(#{timeoutId})`

    let id =
      `setTimeout(#{resolve}, #{delay})`

    {id, value, promise}
  }

  /*
  Returns if the given element is fully visible on the screen.

  TODO: Move to core library.
  */
  fun isFullyVisible (dimensions : Dom.Dimensions) : Bool {
    dimensions.top >= 0 &&
      dimensions.left >= 0 &&
      dimensions.right <= Window.width() &&
      dimensions.bottom <= Window.height()
  }

  /*
  Returns if the given element is visible on the screen.

  TODO: Move to core library.
  */
  fun isVisible (element : Dom.Element) : Bool {
    `
    (() => {
      let rect = #{element}.getBoundingClientRect();
      let node = #{element}.parentNode;

      const height = rect.height;
      const top = rect.top;

      // Check if bottom of the element is off the page
      if (rect.bottom < 0) {
        return false;
      }

      // Check its within the document viewport
      if (top > document.documentElement.clientHeight) {
        return false;
      }

      do {
        rect = node.getBoundingClientRect();

        if (top <= rect.bottom === false) {
          return false
        }

        // Check if the element is out of view due to a container scrolling
        if ((top + height) <= rect.top) {
          return false
        }

        node = node.parentNode
      } while (node != document.body)

      return true;
    })()
    `
  }

  /*
  Scrolls the given element into view if it's not visible.

  TODO: Move to core library.
  */
  fun scrollIntoViewIfNeeded (element : Dom.Element) : Promise(Void) {
    if isVisible(element) {
      next { }
    } else {
      `
      #{element}.scrollIntoView({
        behavior: "smooth",
        inline: "center",
        block: "center",
      })
      `
    }
  }

  fun getElementFromVNode (vnode : Object) : Maybe(Dom.Element) {
    `#{vnode}.__e ? #{Maybe::Just(`#{vnode}.__e`)} : #{Maybe::Nothing}`
  }
}
