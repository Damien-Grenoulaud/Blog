# frozen_string_literal: true

module ApplicationHelper
  def flash_success(&)
    tag.div class: 'alert alert-icon', style: 'background-color: cadetblue !important', 'data-controller': 'alert' do
      concat tag.div "✓", class: "mx-2 my-2 text-lg h-10 w-10 border-2 rounded-full flex items-center justify-center border-white"
      concat tag.div(capture(&), class: "alert-body")
      concat tag.div class: 'alert-close icon-cross', 'data-action': "click->alert#close"
    end
  end
end
