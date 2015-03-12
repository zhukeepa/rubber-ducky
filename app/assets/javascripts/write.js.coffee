@Timer =
  start: (time) ->
    @time = time
    @render()
    setInterval(-> 
      Timer.render()
    , 1000)
  render: -> 
    @time--
    minutes = Math.floor(@time/60)
    $("#timer").text "#{minutes} minutes and #{@time - 60*minutes} left"