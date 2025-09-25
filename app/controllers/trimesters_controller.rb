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
      if @trimester.update(trimester_params)
        format.html { redirect_to @trimester, notice: 'Trimester was successfully updated.'}
        format.json { render :show, status: :created, location: @trimester }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @trimester.errors, status: :unprocessable_entity }
      end
    end
  end
end

private

def trimester_params
  params.require(:trimester).permit(:application_deadline)
end
