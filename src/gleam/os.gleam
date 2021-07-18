//// Function to interact with the host operating system.

/// Gets an environment variable.
pub fn get_env(key: String) -> Result(String, Nil) {
  do_get_env(key)
}

/// Sets an environment variable.
pub fn insert_env(key: String, value: String) -> Nil {
  do_insert_env(key, value)
  Nil
}

/// Deletes an environment variable.
pub fn delete_env(key: String) -> Nil {
  do_delete_env(key)
  Nil
}

if erlang {
  import gleam/list
  import gleam/map.{Map}
  import gleam/string

  // Internal type for erlang interop.
  external type CharList

  external fn os_getenv_all() -> List(CharList) =
    "os" "getenv"

  external fn os_getenv(String) -> List(CharList) =
    "os" "getenv"

  external fn os_putenv(key: CharList, value: CharList) -> Bool =
    "os" "putenv"

  external fn os_unsetenv(key: CharList) -> Bool =
    "os" "unsetenv"

  external fn char_list_to_string(CharList) -> String =
    "unicode" "characters_to_binary"

  external fn string_to_char_list(String) -> CharList =
    "unicode" "characters_to_list"

  // TODO: JavaScript version once JavaScript has Map support
  /// Returns all environment variables set on the system.
  pub fn get_all_env() -> Map(String, String) {
    list.map(
      os_getenv(),
      fn(char_list) {
        assert Ok(value) =
          string.split_once(char_list_to_string(char_list), "=")
        value
      },
    )
    |> map.from_list()
  }

  fn do_insert_env(key: String, value: String) {
    os_putenv(string_to_char_list(key), string_to_char_list(value))
  }

  fn do_delete_env(key: String) {
    os_unsetenv(string_to_char_list(key))
  }
}

if javascript {
  external fn do_insert_env(String, String) -> Nil =
    "../gleam_os.js" "insert_env"

  external fn do_delete_env(String) -> Nil =
    "../gleam_os.js" "delete_env"

  external fn do_get_env(String) -> Result(String, Nil) =
    "../gleam_os.js" "get_env"
}
