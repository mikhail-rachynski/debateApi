class Api::V1::SpeechesController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :update]

  def index
    @round = Round.find(params[:round])
    render 'speech.json.jbuilder'
  end

  def create
    @round = Round.find(params[:round])
    @round.speech.create(user: current_user, speech: params[:speech])
    render 'speech.json.jbuilder'
  end

  def update
    speech = current_user.speeches.find(params[:id])
    speech.update(speech: params[:speech])
  end

  def destroy
    speech = current_user.speeches.find(params[:id])
    speech.destroy
  end

end
