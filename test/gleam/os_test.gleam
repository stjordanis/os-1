if erlang {
  import gleam/map
  import gleam/os
  import gleam/io

  pub fn env_test() {
    os.insert_env("GLEAM_TEST", "hello")
    assert Ok("hello") =
      os.get_env()
      |> map.get("GLEAM_TEST")

    os.delete_env("GLEAM_TEST")

    assert Error(Nil) =
      os.get_env()
      |> map.get("GLEAM_TEST")
  }

  pub fn unicode_env_test() {
    os.insert_env("GLEAM_UNICODE_TEST", "Iñtërnâtiônà£ißætiøn☃💩")
    assert Ok("Iñtërnâtiônà£ißætiøn☃💩") =
      os.get_env()
      |> map.get("GLEAM_UNICODE_TEST")
  }
}
