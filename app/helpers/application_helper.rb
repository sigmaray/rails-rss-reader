# module PaginationHelper
# #   def reverse_links_pagination
# #     pagination_element = content_tag :div, '', :class => 'pagination'
# #     (1..@paginator.total_pages).to_a.reverse.each do 
# # page
# #       pagination_element << link_to(page, users_path(request.GET.merge(:page => page), :class => "#{ page == @paginator.page ? 'active' : '' }")
# #     end
    
# #     pagination_element
# #   end
# end

# class WillPaginate::ViewHelpers::LinkRenderer
#         # def to_html
#         #     links = @options[:page_links] ? windowed_links : []
#         #     # previous/next buttons
#         #     if @options[:reverse] === true
#         #         links.push page_link_or_span(@collection.previous_page, 'disabled prev_page', @options[:previous_label])
#         #         links.unshift page_link_or_span(@collection.next_page, 'disabled next_page', @options[:next_label])
#         #     else
#         #         links.unshift page_link_or_span(@collection.previous_page, 'disabled prev_page', @options[:previous_label])
#         #         links.push page_link_or_span(@collection.next_page, 'disabled next_page', @options[:next_label])
#         #     end

#         #     html = links.join(@options[:separator])
#         #     @options[:container] ? @template.content_tag(:div, html, html_attributes) : html
#         # end 

#   # def to_html
#   #   html = pagination.map do |item|
#   #     item.is_a?(Fixnum) ?
#   #       page_number(item) :
#   #       (raise item.inspect; send(item) if self.respond_to?(item.to_sym))
#   #   end.join(@options[:link_separator])

#   #   @options[:container] ? html_container(html) : html
#   # end

#   # def to_html
#   #   html = pagination.map do |item|
#   #     item.is_a?(Integer) ?
#   #       page_number(item) :
#   #       send(item)
#   #   end.join(@options[:link_separator])
    
#   #   @options[:container] ? html_container(html) : html
#   # end
# end

# class MyCustomLinkRenderer < WillPaginate::ViewHelpers::LinkRenderer
#   def to_html
#     html = pagination.map do |item|
#       item.is_a?(Fixnum) ?
#         page_number(item) :
#         (raise item.inspect;send(item))
#     end.join(@options[:link_separator])

#     @options[:container] ? html_container(html) : html
#   end
# end

class Kaminari::Helpers::Tag
  def page_url_for(page)
    params = params_for(page)
    if page.to_i == 1
      params[:page] = 1
    end
    params[:only_path] = true
    @template.url_for params
  end
end

module ApplicationHelper
  # # change the default link renderer for will_paginate
  # def will_paginate(collection_or_options = nil, options = {})
  #   if collection_or_options.is_a? Hash
  #     options, collection_or_options = collection_or_options, nil
  #   end
  #   unless options[:renderer]
  #     options = options.merge :renderer => MyCustomLinkRenderer
  #   end
  #   super *[collection_or_options, options].compact
  # end
  # def reverse_links_pagination(paginator)
  #   pagination_element = content_tag :div, '', :class => 'pagination'
  #   (1..paginator.total_pages).to_a.reverse.each do 
  #     paginator.page
  #     pagination_element << link_to(request.GET.merge(:page => paginator.page, :class => "#{ page == paginator.page ? 'active' : '' }")
  #   end
    
  #   pagination_element
  # end

  def reverse_links_pagination(paginator)
    return if paginator.records.blank?
    # afford = 5
    pagination_element = content_tag :div, '', :class => 'pagination'
    # pagination_element << link_to('[first]', request.GET.merge(:page => 1)
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

    # if paginator.total_pages < afford
    #   (1..paginator.total_pages).to_a.reverse.each do |page|
    #     pagination_element << link_to(page, request.GET.merge(:page => page, :class => "#{ page == paginator.page ? 'active' : '' }")
    #   end
    # else
    #   # if (paginator.total_pages - paginator.page) < afford
    #   #   ((paginator.page - afford)..paginator.total_pages).to_a.reverse.each do |page|
    #   #     pagination_element << link_to(page, {request.GET.merge(:page => page}, :class => "#{ page == paginator.page ? 'active' : '' }", style: "margin: 0 2px;#{ page == paginator.page ? 'font-weight: bold' : '' }")
    #   #   end
    #   # else
    #     start = paginator.page - (afford/2)
    #     start = 1 if start <= 0
    #     endd = paginator.page + (afford/2)
    #     endd = paginator.total_pages if endd > paginator.total_pages
    #     (start..endd).to_a.reverse.each do |page|
    #       pagination_element << link_to(page, {request.GET.merge(:page => page}, :class => "#{ page == paginator.page ? 'active' : '' }", style: "margin: 0 2px;#{ page == paginator.page ? 'font-weight: bold' : '' }")
    #     end
    #   # end
    # end
    # pagination_element << ('&nbsp;' * 3).html_safe
    # pagination_element << link_to('[first]', request.GET.merge(:page => 1)
    
    pagination_element
  end
end
