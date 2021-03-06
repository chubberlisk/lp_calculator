require 'test_helper'

class ViewingLpPlayerOneTest < ActionDispatch::IntegrationTest
  # Viewing life points of player one
  def setup
    get calculator_url
  end

  test 'shows the current life points of player one' do
    assert_select 'p#player-one-lp', 1
  end

  test 'the life points of player one is a number and not empty' do
    assert_select 'p#player-one-lp', /\A[+-]?\d+?(_?\d+)*(\.\d+e?\d*)?\Z/, 1
  end

  test 'the life points of player one begins with 8000' do
    assert_select 'p#player-one-lp', '8000', 1
  end
end
