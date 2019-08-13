debug.log = function(...) {
  write(sprintf("%s (pid=%s, %s)", sprintf(...), Sys.getpid(), Sys.time()), stdout())
}

# Update a listenv using bindings from a listenv evaluated in a future
# Used to outsource computation to a cluster and then fold the results into main R session
futureUpdate = function(env, f) {
  update = future::value(f)
  env[names(update)] = update
  env
}
