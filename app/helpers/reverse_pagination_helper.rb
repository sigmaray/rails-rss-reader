module ReversePaginationHelper
  # def reverse_pagination(paginator)
  #   pagination_element = content_tag :div, '', :class => 'pagination'
  #   (1..paginator.total_pages).to_a.reverse.each do 
  #     paginator.page
  #     pagination_element << link_to(request.GET.merge(:page => paginator.page, :class => "#{ page == paginator.page ? 'active' : '' }")
  #   end
    
  #   pagination_element
  # end

  def reverse_pagination(paginator)
    return if paginator.records.blank?

    pagination_element = content_tag :div, '', :class => 'pagination'

    pagination_element << if !paginator.last_page?
      link_to('[last]', request.GET.merge(:page => paginator.total_pages))
    else
      '[last]'
    end

    pagination_element << ('&nbsp;' * 3).html_safe
    pagination_element << if paginator.page < paginator.total_pages
      link_to('[<]', request.GET.merge(:page => paginator.page + 1))
    else
       '[<]'
    end
    pagination_element << ('&nbsp;' * 3).html_safe
    pagination_element << paginator.page.to_s
    pagination_element << ('&nbsp;' * 3).html_safe
    pagination_element << if !paginator.first_page?      
      link_to('[>]', request.GET.merge(:page => paginator.page - 1))
    else
      '[>]'
    end

    pagination_element << ('&nbsp;' * 3).html_safe
    pagination_element << if !paginator.first_page?
      link_to('[first]', request.GET.merge(:page => 1))
    else
      '[first]'
    end
    
    pagination_element
  end
end

