# frozen_string_literal: true

module CommentsHelper
    def avatar(img)
        return image_tag(img,:class => "w-10 h-10 rounded-full ring-2 ring-gray-300 dark:ring-gray-500 inline-block") if img&.representable?
    end
end
