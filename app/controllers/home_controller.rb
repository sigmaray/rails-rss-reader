# PER_PAGE = 4

class ReversePagination
  attr_reader :page, :per_page, :total_count, :total_pages, :records, :scope

  def initialize(scope, page, per_page)
    @scope = scope
    initialize_params(scope.klass, page, per_page)

    # @records = scope.limit(limit).offset(offset)#.order(:created_at).reverse

    # @records = scope.limit(limit).offset(offset).order(:pub_date).reverse    
    @records = scope.limit(limit).offset(offset).reverse    
    # raise @records.inspect
  end

  # def initialize_params(klass, page)
  #   @per_page = klass::PER_PAGE
  #   @total_count = klass.count
  #   @total_pages = total_count / per_page    
  #   # self.page = page.to_i
  #   p = (page.blank? ? 0 : page.to_i)
  #   # raise p.inspect
  #   @page = @total_pages if (p <= 0 || p > @total_pages)
  #   raise @page.inspect
  # end

  def initialize_params(klass, page, per_page)
    @per_page = per_page
    # @per_page = klass::PER_PAGE
    # @total_count = klass.count
    # @total_count = klass.count
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

class HomeController < ApplicationController
  # def reverse_paginate(scope, page)
  #   @paginator = ReversePagination.new(scope, page)
  #   @paginator.records
  # end

  def index
    # pc = 50
    scoped = Item.visible.order('pub_date')
    if params[:feed_id].present?
      @feed = Feed.find(params[:feed_id])
      scoped = scoped.where(feed_id: params[:feed_id])
    end
    # if params[:page].blank?
    #   # p = Item.all.paginate(page: 1, per_page: pc).total_pages
    #   p = scoped.page(p).per(PER_PAGE).total_pages
    #   # p = p - 2 if p > 0
    # else
    #   p = params[:page]
    # end

    # @items = scoped.page(p).per(PER_PAGE)
    # @items = prepare_reverse(scoped)
    # @items = prepare(scoped)
    
    @paginator = ReversePagination.new(scoped, params[:page], 10)
    @items = @paginator.records    
    # @items = Item.visible.paginate(page: p, per_page: pc)    

  end

  private

  def prepare(scoped)
    if params[:page].blank?
      # p = Item.all.paginate(page: 1, per_page: pc).total_pages
      p = scoped.page(p).per(PER_PAGE).total_pages
      # p = p - 2 if p > 0
    else
      p = params[:page]
    end

    scoped.page(p).per(PER_PAGE)
  end

  # def prepare_reverse(scope)
  #   # @per_page = City.default_per_page
  #   @per_page = PER_PAGE
  #   total_count = scope.count
  #   rest_count = total_count > @per_page ? (total_count % @per_page) : 0
  #   @num_pages = total_count > @per_page ? (total_count / @per_page) : 1

  #   if params[:page]
  #     offset = params[:page].sub(/-.*/, '').to_i
  #     current_page = @num_pages - (offset - 1) / @per_page
  #     scope.page(current_page).per(@per_page).padding(rest_count)
  #   else
  #     scope.page(1).per(@per_page + rest_count)
  #   end
  # end
end
