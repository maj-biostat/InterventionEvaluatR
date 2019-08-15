debug.log = function(...) {
  message(sprintf("%s (pid=%s, %s)", sprintf(...), Sys.getpid(), Sys.time()))
}

# Update a listenv using bindings from a listenv evaluated in a future
# Used to outsource computation to a cluster and then fold the results into main R session
futureUpdate = function(env, f) {
  update = future::value(f)
  env[names(update)] = update
  env
}

#' @importFrom progress progress_bar
progressDefault = function(analysis) {
  list(
    step = function(message) {
      analysis$.private$progressBar = progress_bar$new(format=sprintf("%s [:bar] :percent", message), total=100, clear=FALSE, show_after=0)
      analysis$.private$progressBar$tick(0)
    },
    done = function(message) {
      analysis$.private$progress$step(message)
    }
  )
}
