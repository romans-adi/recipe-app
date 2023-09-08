module IngredientsHelper
  def sort_link(column:, label:, target:)
    current_sort_column = request.params[:sort]
    current_sort_direction = request.params[:direction]
    new_sort_direction = if current_sort_column == column
                           current_sort_direction == 'asc' ? 'desc' : 'asc'
                         else
                           'asc'
                         end
    link_to(label, request.params.merge(sort: column, direction: new_sort_direction), data: { turbo_frame: target })
  end
end
