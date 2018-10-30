require 'application_system_test_case'

class ShowingPlayerTwoBtnsTest < ApplicationSystemTestCase
  # Showing buttons to decrease life points of player one
  def setup
    visit calculator_url
    find('button#add-player-two').click
  end

  test 'can see buttons to increase life points of player two' do
    find('button#player-two-show-lp-btns').click
    assert_selector 'button#player-two-lp-plus-one-thousand', count: 1
    assert_selector 'button#player-two-lp-plus-five-hundred', count: 1
    assert_selector 'button#player-two-lp-plus-one-hundred', count: 1
    assert_selector 'button#player-two-lp-plus-ten', count: 1
    assert_no_selector 'button#player-two-lp-minus-one-thousand'
    assert_no_selector 'button#player-two-lp-minus-five-hundred'
    assert_no_selector 'button#player-two-lp-minus-one-hundred'
    assert_no_selector 'button#player-two-lp-minus-ten'
    within('button#player-two-show-lp-btns.minus') do
      assert_text '-', options={:exact => true}
    end
  end

  test 'can see buttons to decrease life points of player two' do
    find('button#player-two-show-lp-btns').click
    find('button#player-two-show-lp-btns').click
    assert_selector 'button#player-two-lp-minus-one-thousand', count: 1
    assert_selector 'button#player-two-lp-minus-five-hundred', count: 1
    assert_selector 'button#player-two-lp-minus-one-hundred', count: 1
    assert_selector 'button#player-two-lp-minus-ten', count: 1
    assert_no_selector 'button#player-two-lp-plus-one-thousand'
    assert_no_selector 'button#player-two-lp-plus-five-hundred'
    assert_no_selector 'button#player-two-lp-plus-one-hundred'
    assert_no_selector 'button#player-two-lp-plus-ten'
    within('button#player-two-show-lp-btns') do
      assert_text '+', options={:exact => true}
    end
  end
end