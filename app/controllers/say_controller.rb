class SayController < ApplicationController
  def hello
    @time = Time.now
  end

  def goodbye
  end

  def directories
    @files = Dir.glob("*")
  end
end
