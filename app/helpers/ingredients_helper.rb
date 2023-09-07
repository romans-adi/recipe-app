module IngredientsHelper
  def sort_link(column:, label:, target:, recipe_id:)
    link_to(label, general_shopping_list_path(id: recipe_id, column: column), data: { turbo_frame: target })
  end
end
