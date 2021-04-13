/* Represents a design token. */
enum Ui.Token {
  /* A token which has a different value on light and dark modes. */
  Schemed(name : String, light : String, dark : String)

  /* A simple token which is the same in all modes. */
  Simple(name : String, value : String)
}

/* Utility functions for the Ui.Token enum. */
module Ui.Token {
  /* Resolves the token using the dark mode param. */
  fun resolve (darkMode : Bool, token : Ui.Token) : Array(String) {
    case (token) {
      Ui.Token::Schemed name light dark =>
        try {
          value =
            if (darkMode) {
              "var(--dark-#{name})"
            } else {
              "var(--light-#{name})"
            }

          [
            "--light-#{name}: #{light}",
            "--dark-#{name}: #{dark}",
            "--#{name}: #{value}"
          ]
        }

      Ui.Token::Simple name value =>
        [
          "--#{name}: #{value}"
        ]
    }
  }

  /* Resolves many tokens using the dark mode param. */
  fun resolveMany (darkMode : Bool, tokens : Array(Ui.Token)) : String {
    tokens
    |> Array.flatMap(resolve(darkMode))
    |> Array.sortBy((item : String) { item })
    |> String.join(";\n")
  }
}
