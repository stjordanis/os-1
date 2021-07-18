-module(gleam_os_ffi).
-export([get_env/1, insert_env/2, delete_env/1]).

get_env(Key) ->
  case os:getenv(unicode:characters_to_list(Key)) of
    false -> {error, nil};
    Value -> {ok, unicode:characters_to_binary(Value)}
  end.

insert_env(Key, Value) ->
  os:putenv(unicode:characters_to_list(Key), unicode:characters_to_list(Value)),
  nil.

delete_env(Key) ->
  os:unsetenv(unicode:characters_to_list(Key)),
  nil.
