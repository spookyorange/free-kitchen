require "test_helper"

class IngredientTest < ActiveSupport::TestCase
  test 'must have a recipe it belongs to' do
    ingredient = Ingredient.new(name: 'a' * 8, quantity: 10)

    assert_not ingredient.save

    ingredient = Ingredient.new(recipe: recipes(:one), name: 'a' * 8, quantity: 10)

    assert ingredient.save
  end

  test 'ingredient must have a name of 3 to 16 chars' do
    ingredient = Ingredient.new(recipe: recipes(:one), name: 'a' * 2, quantity: 6)

    assert_not ingredient.save

    ingredient = Ingredient.new(recipe: recipes(:one), name: 'a' * 25, quantity: 6)

    assert_not ingredient.save

    ingredient = Ingredient.new(recipe: recipes(:one), name: 'a' * 12, quantity: 6)

    assert ingredient.save
  end

  test 'ingredient must have a quantity that is minimum of 1' do
    ingredient = Ingredient.new(recipe: recipes(:one), name: 'a' * 12, quantity: -5000)

    assert_not ingredient.save

    ingredient = Ingredient.new(recipe: recipes(:one), name: 'a' * 12, quantity: 45)

    assert ingredient.save
  end
end
