//= require jquery
//= require rails-ujs
//= require action_cable
//= require jquery.remotipart
//= require turbolinks
//= require skim
//= require_tree ./templates
//= require_tree

var App = App || {};
App.cable = ActionCable.createConsumer();