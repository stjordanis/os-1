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
  // TODO: JavaScript version once JavaScript has Map support
  // pub fn get_all_env() -> Map(String, String) {
  //   os_getenv_all()
  //   |> list.map(fn(char_list) {
  //     assert Ok(value) = string.split_once(char_list_to_string(char_list), "=")
  //     value
  //   })
  //   |> map.from_list()
  // }
  /// Returns all environment variables set on the system.
  pub external fn do_insert_env(String, String) -> Nil =
    "gleam_os_ffi" "insert_env"

  pub external fn do_delete_env(String) -> Nil =
    "gleam_os_ffi" "delete_env"

  pub external fn do_get_env(String) -> Result(String, Nil) =
    "gleam_os_ffi" "get_env"
}

if javascript {
  external fn do_insert_env(String, String) -> Nil =
    "../gleam_os_ffi.js" "insert_env"

  external fn do_delete_env(String) -> Nil =
    "../gleam_os_ffi.js" "delete_env"

  external fn do_get_env(String) -> Result(String, Nil) =
    "../gleam_os_ffi.js" "get_env"
}
