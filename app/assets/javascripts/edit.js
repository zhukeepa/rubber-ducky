this.Timer = {
  start: function(time) {
    this.time = time;
    setTimeout(function() {
      window.location = "/fail";
    }, time * 1000);
    this.render();
    setInterval(function() {
      Timer.render();
      Timer.autosave();
    }, 1000);
  },
  render: function() {
    var minutes;
    this.time--;
    minutes = Math.floor(this.time / 60);
    $("#timer").text(minutes + " minutes and " + (this.time - 60 * minutes) + " seconds left");
  },
  autosave: function() {
    var params = { message: { body: $("#message_body").val() } };
    console.log(params.message.body);
    //$.ajax({minutes("/autosave", params);
  }
};

//this.Autosave
//check if content changed