class HomeController < ApplicationController
  def index
    @active_chapter = Chapter.active
  end
end
