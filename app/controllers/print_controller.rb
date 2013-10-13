class PrintController < ApplicationController
	before_filter :authenticate_user!
  def select
  end

  def sheet
  end
end
