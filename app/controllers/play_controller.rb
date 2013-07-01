class PlayController < ApplicationController
  # Get /play/index
  def index
    session[:chars] = []
    session[:hints] = 0
    words = Word.all
   
    if words.size > 0 
      if session[:seen_word_ids].nil? or session[:seen_word_ids].size >= words.size
        session[:seen_word_ids] = [] 
      end
      word = Word.random_word(session[:seen_word_ids])
      session[:seen_word_ids] << word.id
      redirect_to guess_path(word.id)
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
