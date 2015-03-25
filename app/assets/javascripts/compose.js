this.Timer = {
  start: function(time) {
    setTimeout(function() { window.location = "/fail"; }, time * 1000);

    this.time = time;
    this.render();
    setInterval(function() { Timer.render(); }, 1000);
  },
  render: function() {
    var minutes;
    this.time--;
    minutes = Math.floor(this.time / 60);
    $("#timer").text(minutes + " minutes and " + (this.time - 60 * minutes) + " seconds left");
  }
};

this.startAutosave = function(prevBody) { 
  var prevBody = ""; 
  var autosave_url = $(".edit_message").data("autosave-url");

  setInterval(function() {
    var params = { message: { body: CKEDITOR.instances['message_body'].getData() } };
    if (prevBody != params.message.body) {
      $.ajax({
        url: autosave_url, 
        method: "PATCH", 
        data: params
      });
      prevBody = params.message.body 
    }
  }, 1000);
}