# frozen_string_literal: true

module ApplicationHelper
  def flash_success(&)
    tag.div class: 'flex items-center justify-between p-4 text-white', style: 'background-color: cadetblue !important', 'data-controller': 'alert' do
      concat tag.div "✓", class: "mx-2 my-2 text-lg h-10 w-10 border-2 rounded-full flex items-center justify-center border-white"
      concat tag.div(capture(&), class: "alert-body")
      concat tag.div "x", class: "cursor-pointer", 'data-action': "click->alert#close"
    end
  end

  def flash_error(&)
    tag.div class: 'flex items-center justify-between p-4 text-white', style: 'background-color: darkred !important', 'data-controller': 'alert' do
      concat tag.div "✓", class: "mx-2 my-2 text-lg h-10 w-10 border-2 rounded-full flex items-center justify-center border-white"
      concat tag.div(capture(&), class: "alert-body")
      concat tag.div "x", class: "cursor-pointer", 'data-action': "click->alert#close"
    end
  end
end
