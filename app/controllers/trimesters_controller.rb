class TrimestersController < ApplicationController

  def index
    @trimesters = Trimester.all
  end

end

