class PlayController < ApplicationController
  # Get /play/index
  def index
    session[:chars] = []
    session[:hints] = 0
    words = Word.find(:all)
   
    if words.size > 0 
      redirect_to guess_path(1 + rand(words.size))
    else
      redirect_to words_path
    end
  end

  def easy_play
    session[:level] = 'easy'
    redirect_to play_path
  end

  def regular_play
    session[:level] = 'regular'
    redirect_to play_path
  end
end
