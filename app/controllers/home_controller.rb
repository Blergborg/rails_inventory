class HomeController < ApplicationController
  def index
  end

  def about
    # can write anything here (call api from another site w/ a get requrest to pull data in,
    # parse it out, then access it from a view through an instance variable)
    @about_us = "This is a place for you to keep an inventory of stuff"
  end
end
