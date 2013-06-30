class WordsController < ApplicationController
  # Get /words/1/my_guess/a
  def my_guess
    if session[:chars]
      session[:chars] << params[:letter].downcase
    else
      session[:chars] = [params[:letter]].downcase
    end
    redirect_to guess_path(params[:id])
  end

  # Get /words/1/hint
  def hint
    session[:hints] += 1
    word = Word.find(params[:id])
    session[:chars] << word.hint(session[:chars])
    redirect_to guess_path(params[:id])
  end

  # Get /words/1/guess
  def guess
    word = Word.find(params[:id])
    if session[:level] == 'easy'
      @word = word.word
    else
      @word = word.underscores(session[:chars])
    end
    @chars = session[:chars]
    @score = (session[:chars].uniq - word.word.split("").uniq).size
    @alphabet = Array('a'..'z').include?(word.word[0].downcase) ? "latin" : "cyrillic"

    respond_to do |format|
      format.html { render layout: "guess" } # guess.html.erb
    end
  end

  # GET /words
  # GET /words.json
  def index
    @words = Word.order(:word).all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @words }
    end
  end

  # GET /words/1
  # GET /words/1.json
  def show
    @word = Word.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @word }
    end
  end

  # GET /words/new
  # GET /words/new.json
  def new
    @word = Word.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @word }
    end
  end

  # GET /words/1/edit
  def edit
    @word = Word.find(params[:id])
  end

  # POST /words
  # POST /words.json
  def create
    @word = Word.new(params[:word])

    respond_to do |format|
      if @word.save
        format.html { redirect_to @word, notice: 'Word was successfully created.' }
        format.json { render json: @word, status: :created, location: @word }
      else
        format.html { render action: "new" }
        format.json { render json: @word.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /words/1
  # PUT /words/1.json
  def update
    @word = Word.find(params[:id])

    respond_to do |format|
      if @word.update_attributes(params[:word])
        format.html { redirect_to @word, notice: 'Word was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @word.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /words/1
  # DELETE /words/1.json
  def destroy
    @word = Word.find(params[:id])
    @word.destroy

    respond_to do |format|
      format.html { redirect_to words_url }
      format.json { head :no_content }
    end
  end
end
