module ApplicationHelper
  def title
    return t('pazii') unless content_for?(:title)

    "#{content_for(:title)} | #{t('pazii')}"
  end
end
