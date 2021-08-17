class Api::V1::SpeechesController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :update, :destroy]

  def index
    @speeches = Game.find(params[:game]).speeches.flatten.compact
    render 'index.json.jbuilder'
  end

  def create
    @round = Round.find(params[:round])
    speech = @round.speeches.create(user: current_user, speech: params[:speech])
    pub_speech "set_new_speech", speech.round.game.id, speech
  end

  def update
    speech = current_user.speeches.find(params[:id])
    speech.update(speech: params[:speech])
    pub_speech "edit_speech", speech.round.game.id, speech
  end

  def destroy
    speech = current_user.speeches.find(params[:id])
    speech.destroy
    pub_speech "remove_speech", speech.round.game.id, {id: speech.id}
  end

end
