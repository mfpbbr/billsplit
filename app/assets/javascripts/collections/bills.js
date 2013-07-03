Friend.Collections.Bills = Backbone.Collection.extend({
  model: Friend.Models.Bill,
  url: "/bills"
});