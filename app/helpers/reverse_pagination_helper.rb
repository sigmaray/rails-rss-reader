# https://medium.com/@Flyr1Q/rails-reverse-pagination-from-scratch-74346c9ab556

module ReversePaginationHelper
  def reverse_pagination(paginator)
    return if paginator.records.blank?

    content_tag :div, class: 'pagination' do
      concat(if !paginator.last_page?
        link_to('[last]', request.GET.merge(page: paginator.total_pages))
      else
        '[last]'
      end)
      concat ('&nbsp;' * 3).html_safe
      concat(
        if paginator.page < paginator.total_pages
          link_to('[<]', request.GET.merge(page: paginator.page + 1))
        else
           '[<]'
        end
      )
      concat ('&nbsp;' * 3).html_safe
      concat paginator.page.to_s
      concat ('&nbsp;' * 3).html_safe
      concat(
        if !paginator.first_page?      
          link_to('[>]', request.GET.merge(page: paginator.page - 1))
        else
          '[>]'
        end
      )
      concat ('&nbsp;' * 3).html_safe
      concat(
        if !paginator.first_page?
          link_to('[first]', request.GET.merge(page: 1))
        else
          '[first]'
        end
      )
    end
  end
end
