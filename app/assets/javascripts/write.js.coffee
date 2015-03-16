@Timer =
  start: (time) ->
    @time = time
    setTimeout(->
      window.location = "/fail"
    , time*1000)
    @render()
    setInterval(-> 
      Timer.render()
    , 1000)
  render: -> 
    @time--
    minutes = Math.floor(@time/60)
    $("#timer").text "#{minutes} minutes and #{@time - 60*minutes} seconds left"