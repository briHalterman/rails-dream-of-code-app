# frozen_string_literal: true

class TrimestersController < ApplicationController
  def index
    @trimesters = Trimester.all
  end

  def show
    @trimester = Trimester.find(params[:id])
  end

  def edit
    @trimester = Trimester.find(params[:id])
    # @coding_classes = CodingClass.all
  end

  def update
    @trimester = Trimester.find(params[:id])

    respond_to do |format|
      if trimester_params[:application_deadline].present? &&  @trimester.update(trimester_params)
        format.html { redirect_to @trimester, notice: 'Trimester was successfully updated.'}
        format.json { render :show, status: :created, location: @trimester }
      else
        format.html { render :edit, status: :bad_request }
        format.json { render json: @trimester.errors, status: :bad_request }
      end
    end
  end
end

private

def trimester_params
  params.require(:trimester).permit(:application_deadline)
end
