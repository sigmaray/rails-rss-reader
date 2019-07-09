# https://medium.com/@Flyr1Q/rails-reverse-pagination-from-scratch-74346c9ab556

class ReversePagination
  attr_reader :page, :per_page, :total_count, :total_pages, :records, :scope

  def initialize(scope, page, per_page)
    @scope = scope
    initialize_params(scope.klass, page, per_page)

    # @records = scope.limit(limit).offset(offset).order(:created_at).reverse
    # @records = scope.limit(limit).offset(offset).order(:pub_date).reverse    
    @records = scope.limit(limit).offset(offset).reverse    
  end

  def initialize_params(klass, page, per_page)
    @per_page = per_page
    # @per_page = klass::PER_PAGE
    @total_count = scope.count
    @total_pages = total_count / per_page
    @total_pages = 1 if @total_pages == 0 && @total_count > 0
    if page.blank?
      @page = total_pages
    else
      @page = page.to_i
    end    
    @page = total_pages if @page <= 0 || @page > total_pages
  end

  def limit
    @per_page + 1 / (@total_pages - @page + 1) * (@total_count % @per_page)
  end

  def offset
    return 0 if @scope.count == 0
    (@page - 1) * @per_page
  end

  def last_page?
    @page == @total_pages
  end

  def first_page?
    @page == 1
  end

  def has_next_pages?
    @page < @total_pages
  end

  def has_previous_pages?
    @page > 1
  end
end
