# frozen_string_literal: true

ENV['RAILS_ENV'] ||= 'test'
require_relative '../config/environment'
require 'rails/test_help'

module ActiveSupport
  class TestCase
    # Run tests in parallel with specified workers
    parallelize(workers: :number_of_processors, with: :threads)

    # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
    fixtures :all

    def login
      set_user
   
      post login_path params: {
         user: {
           mail: "test@test.com",
           password: "motdepasse"
         }
       }
     end
   
     private
   
     def set_user
       User.create(nom: "Test", prenom: "test", mail: "test@test.com", password: "motdepasse", password_confirmation:"motdepasse") unless User.find_by mail: "test@test.com" 
     end
    # Add more helper methods to be used by all tests here...
  end
end
