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
  fun resolve (token : Ui.Token, darkMode : Bool) : Array(String) {
    case (token) {
      Ui.Token::Schemed(name, light, dark) =>
        {
          let value =
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

      Ui.Token::Simple(name, value) =>
        [
          "--#{name}: #{value}"
        ]
    }
  }

  /* Sets a given token. */
  fun setToken (tokens : Array(Ui.Token), token : Ui.Token) : Array(Ui.Token) {
    let name =
      getName(token)

    tokens
    |> Array.reject((item : Ui.Token) { getName(item) == name })
    |> Array.push(token)
  }

  /* Gets the name of the token. */
  fun getName (token : Ui.Token) : String {
    case (token) {
      Ui.Token::Schemed(name) => name
      Ui.Token::Simple(name) => name
    }
  }

  /* Resolves many tokens using the dark mode param. */
  fun resolveMany (tokens : Array(Ui.Token), darkMode : Bool) : String {
    tokens
    |> Array.map((token : Ui.Token) { resolve(token, darkMode) })
    |> Array.concat()
    |> Array.sortBy((item : String) { item })
    |> String.join(";\n")
  }
}
