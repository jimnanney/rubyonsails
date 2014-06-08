class StaticController < ApplicationController
  page_title :index, "Ruby on Sails"
  def index
    render({
      :layout => "index"
    })
  end
end
