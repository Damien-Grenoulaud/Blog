# frozen_string_literal: true

require 'test_helper'

class CommentTest < ActiveSupport::TestCase
  test "Creation Commentaire sans article" do
    @Comment = Comment.new
    assert_not @Comment.save,"test mauvais"
  end
  # test "the truth" do
  #   assert true
  # end
end
