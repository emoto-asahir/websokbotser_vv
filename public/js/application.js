function appendCount (count) {
  $("#count").text(count);
}
function appendMessage (name, text) {
  $("#chat").append('<span class="label label-default">' + name + "</span>" + text + "<br/>");
}
function sendMessage() {
  var name = $('#username').val();
  var text = $('#msgbody').val();
  ws.send("sssssssssssssssssssssssss");
  $('#msgbody').val('');    
  
}

$('#msgbody').keypress(function (e) {
    if ((e.which && e.which == 13) || (e.keyCode && e.keyCode == 13)) {
        sendMessage();
    }
});

$("#send").click(function(event) {
  sendMessage();
});

var ws = new WebSocket(location.origin.replace(/^http/, 'ws'));

ws.onmessage = function(msg) {
  var data = JSON.parse(msg.data);
  if (data.body) {
    appendMessage(data.name, data.body);
  } else if (data.count) {
    appendCount(data.count);
  }
}
