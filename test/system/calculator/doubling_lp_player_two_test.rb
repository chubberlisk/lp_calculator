require 'application_system_test_case'

class DoublingLpPlayerTwoTest < ApplicationSystemTestCase
  # Doubling life points of player two
  test 'can double life points of player two' do
    visit calculator_url
    find('button#add-player-two').click
    find('button#player-two-show-lp-btns').click
    find('button#player-two-show-lp-btns').click
    find('button#player-two-lp-double').click
    find('button#player-two-lp-confirm').click
    within('p#player-two-lp') do
      assert_text '16000', options={:exact => true}
    end
  end
end
