/* Represents a theme. */
component Ui.Theme.Root {
  connect Ui exposing { darkMode, mobile }

  /* The font configuration. */
  property fontConfiguration : Ui.FontConfiguration

  /* The tokens to use, if then the default theme is used. */
  property tokens : Array(Ui.Token)

  /* The children to render. */
  property children : Array(Html) = []

  fun render : Html {
    let fontSize =
      if mobile {
        "14px"
      } else {
        "16px"
      }

    let resolvedTokens =
      [
        [
          Ui.Token.Simple(name: "title-font-family", value: fontConfiguration.titleName),
          Ui.Token.Simple(name: "font-family", value: fontConfiguration.name)
        ],
        tokens
      ]
      |> Array.concat()
      |> Ui.Token.resolveMany(darkMode)

    let css =
      "
        @font-face {
          font-family: '#{fontConfiguration.titleName}';
          font-style: normal;
          font-weight: 700;
          src: local(''),
               url('#{fontConfiguration.titleWoff2}') format('woff2'),
               url('#{fontConfiguration.titleWoff}') format('woff');
        }

        @font-face {
          font-family: '#{fontConfiguration.name}';
          font-style: normal;
          font-weight: 400;
          src: local(''),
               url('#{fontConfiguration.regularWoff2}') format('woff2'),
               url('#{fontConfiguration.regularWoff}') format('woff');
        }

        @font-face {
          font-family: '#{fontConfiguration.name}';
          font-style: normal;
          font-weight: 700;
          src: local(''),
               url('#{fontConfiguration.boldWoff2}') format('woff2'),
               url('#{fontConfiguration.boldWoff}') format('woff');
        }

        html {
          scrollbar-color: var(--scrollbar-thumb) var(--scrollbar-track);
          scroll-behavior: smooth;

          -webkit-tap-highlight-color: rgba(0,0,0,0);
          touch-action: manipulation;
          overflow-y: scroll;
        }

        body {
          margin: 0;
        }

        *::-webkit-scrollbar {
          cursor: pointer;
          height: 12px;
          width: 12px;
        }

        *::-webkit-scrollbar-track {
          background: var(--scrollbar-track);
        }

        *::-webkit-scrollbar-thumb {
          background: var(--scrollbar-thumb);
        }

        :root {
          background: var(--background-color);
          color: var(--background-text);

          font-family: var(--font-family);
          font-size: #{fontSize};
        }

        ::selection {
          background-color: var(--selection-color);
          color: var(--selection-text);
        }
        "

    <>
      <Html.Portals.Head>
        <style>
          css
        </style>

        <style>":root { #{resolvedTokens} } "</style>
      </Html.Portals.Head>

      children
    </>
  }
}
