window.Friend = {
  Models: {},
  Collections: {},
  Views: {},
  Routers: {},
  initialize: function() {
    // Friend.debts = new Friend.Collections.Debts();
    
    // Friend.debts.fetch({
    //     success: function() {
    //         console.log("here");
            // new Friend.Routers.Debts({
            //     "$rootEl": $("#content")
            // });
            // Backbone.history.start();
    
        // }
    // });
  }
};

//originally was in friends/show.html.erb
//<script type="application/javascript">
$(document).ready(function(){
  Friend.initialize();
});
//</script>