class QuestionsController < ApplicationController
    before_action :set_question, only: [:show, :update, :destroy]
    
     acts_as_token_authentication_handler_for User, fallback_to_devise: false
     before_filter :authenticate_user!, except: [:random,:show,:ql]
    
    
    def new
    end
    
    def ql 
      questions = Question.where('answer is NULL AND flag is NULL').limit(10)
      respond_to do |format|
        format.json {
            render :json => questions     }
      end
    end
    
    def create
    end
    
    def random
        question = Question.where('answer IS NOT NULL').order("RANDOM()").first
        respond_to do |format|
        format.json {
            render :json => question     }
        end
    end
    
    def show
        respond_to do |format|
        format.json {
            render :json => @question     }
        end
    end
    
    def update
      respond_to do |format|
        if @question.update(question_params)
          format.json { head :no_content }
        else
          format.json { render json: @question.errors, status: :unprocessable_entity }
        end
      end
    end
    
    def destroy
      @question.destroy
      respond_to do |format|
        format.json { head :no_content }
      end
    end

  private
    
    def set_question
      @question = Question.find(params[:id])
    end
    
    def question_params
      if(params[:question])
        params.require(:question).permit(:description, :tags, :answer,:picture,:comments,:flag)
      end
    end
end
