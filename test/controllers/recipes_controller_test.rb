require "test_helper"

class RecipesControllerTest < ActionDispatch::IntegrationTest
  setup do
    sign_in users(:one)
  end

  test 'if user signed in and has a profile they can get to index or somewhere' do
    get recipes_url
    assert_response :success
  end

  test "if user signed in but doesn't have a profile they can't get to index or somewhere" do
    sign_out :user
    sign_in users(:two)
    get recipes_url
    assert_redirected_to new_profile_url
  end

  test 'if user is not signed in they can see index of recipes' do
    sign_out :user
    get recipes_url
    assert_response :success
  end

  test 'if user is not signed in they can see recipes' do
    sign_out :user
    get recipe_url(1)
    assert_response :success
  end

  test 'if user is not signed in and try to make a recipe they get redirected just like (1)(just to be sure)' do
    sign_out :user
    get new_recipe_url
    assert_response :redirect
  end

  test 'if user is signed in and has a profile but try to edit a recipe that does not belong to them they get
              redirected to the index' do
    get edit_recipe_url(2)
    assert_response :redirect
  end

  test "if user is signed in but tries to edit someone else's recipe they get redirected" do
    get recipe_url(2)
    assert_response :success
    assert_select 'h1', 'a' * 10

    patch recipe_url(2),
          params: { recipe: { title: 'a' * 18,
                              about: 'a' * 50 } }
    assert_response :redirect
    follow_redirect!
    assert_response :success
    assert_select 'h1', 'a' * 10

  end

  test 'if user tries to delete a recipe that does not belong to them they get redirected to the index' do
    delete recipe_url(2)
    assert_response :redirect
  end

  test "if user is signed in but doesn't have a profile and tries to delete a recipe gets redirected" do
    sign_out :user
    sign_in users(:three)

    delete recipe_url(1)
    assert_response :redirect
  end

end
