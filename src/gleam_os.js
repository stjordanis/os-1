export function insert_env(key, value) {
  process.env[key] = value;
}

export function delete_env(key) {
  delete process.env[key];
}

export function get_env(key) {
  if (key in process.env) {
    return { type: "Ok", 0: process.env[key] };
  } else {
    return { type: "Error", 0: undefined };
  }
}
