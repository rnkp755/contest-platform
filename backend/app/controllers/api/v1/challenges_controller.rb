module Api
  module V1
    class Api::V1::ChallengesController < ApplicationController
      before_action :findChallenge, only: [:show, :update, :destroy] # Runs 'findChallenge' before show, update, and destroy actions
      # GET /api/v1/challenges
      def index
        # Show all challenges
        # Render JSON response with all challenges
        @challenges = Challenge.all
        render json: {status: 'SUCCESS', message: "Data Fetched", data: @challenges} # Convert ActiveRecord objects to JSON and return
      end

      # GET /api/v1/challenges/:id
      def show
        # Show a specific challenge
        # Find the challenge by ID and render it as JSON
        render json: {status: 'SUCCESS', message: "Data Fetched", data: @challenge}, status: :ok
      end

      # POST /api/v1/challenges
      def create
        # Create a new challenge
        # Create a new Challenge object with the provided parameters
        
        @challenge = Challenge.new(challenge_params)       # Initialize a new Challenge with permitted parameters
        if @challenge.save                                 # Attempt to save the Challenge to the database
          render json: {status: 'SUCCESS', message: 'Challenge created', data: @challenge}, status: :ok
        else
          render json: {status: 'ERROR', message: 'Challenge not created', data: @challenge.errors}, status: :unprocessable_entity
        end
      end

      # PATCH/PUT /api/v1/challenges/:id
      def update
        # Update an existing challenge
        # Find the challenge by ID and update it with the provided parameters        
        if @challenge.update(challenge_params)
          render json: {status: 'SUCCESS', message: 'Challenge updated', data: @challenge}, status: :ok
        else
          render json: {status: 'ERROR', message: 'Challenge not updated', data: @challenge.errors}, status: :unprocessable_entity
        end
      end

      # DELETE /api/v1/challenges/:id
      def destroy
        # Delete a specific challenge
        # Find the challenge by ID and destroy it
        @challenge.destroy
        render json: {status: 'SUCCESS', message: 'Challenge deleted', data: nil}, status: :ok
      end

      private # All methods below this line are private and cannot be accessed as actions
      def findChallenge
        @challenge = Challenge.find(params[:id])
      end
        
      def challenge_params
        params.require(:challenge).permit(:title, :description, :start_date, :end_date)
      end
    end
  end 
end
