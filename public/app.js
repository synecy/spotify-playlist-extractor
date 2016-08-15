$(document).ready(function() {
  $("#load-playlist-btn").click(function() {
    $(".list-group").empty();
    var user_id = $("#user_id").val();
    var playlist_id = $("#playlist_id").val();
    $.ajax({
      url: "/v1/playlists/"+user_id+"/"+playlist_id,
      dataType: "json",
      success: function(response) {
        for (var i = 0; i < response.playlist.length; i++) {
           $(".list-group").append('<li class="list-group-item">'+response.playlist[i].name+'</li>');
        }
      },
      error: function(error) {
        console.log("Error: unable to get playlist");
      }
    });
  });
});

