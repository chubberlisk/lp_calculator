require 'application_system_test_case'

class DecreasingLpPlayerOneTest < ApplicationSystemTestCase
  # Decreasing life points of player one
  def setup
    visit calculator_url
  end

  test 'can reduce the life points of player one by 1000' do
    find('button#player-one-lp-minus-one-thousand').click
    find('button#player-one-lp-confirm').click
    within('p#player-one-lp') do
      assert_text '7000', options={:exact => true}
    end
  end

  test 'can reduce the life points of player one by 500' do
    find('button#player-one-lp-minus-five-hundred').click
    find('button#player-one-lp-confirm').click
    within('p#player-one-lp') do
      assert_text '7500', options={:exact => true}
    end
  end

  test 'can reduce the life points of player one by 100' do
    find('button#player-one-lp-minus-one-hundred').click
    find('button#player-one-lp-confirm').click
    within('p#player-one-lp') do
      assert_text '7900', options={:exact => true}
    end
  end

  test 'can reduce the life points of player one by 10' do
    find('button#player-one-lp-minus-ten').click
    find('button#player-one-lp-confirm').click
    within('p#player-one-lp') do
      assert_text '7990', options={:exact => true}
    end
  end

  test 'the life points of player one equals 0 when -1000 is clicked 8 times' do
    for i in 0..7 do
      find('button#player-one-lp-minus-one-thousand').click
    end
    dismiss_confirm do
      find('button#player-one-lp-confirm').click
    end
    within('p#player-one-lp') do
      assert_text '0', options={:exact => true}
    end
  end

  test 'the life points of player one equals 0 when -1000 is clicked 9 times' do
    for i in 0..8 do
      find('button#player-one-lp-minus-one-thousand').click
    end
    dismiss_confirm do
      find('button#player-one-lp-confirm').click
    end
    within('p#player-one-lp') do
      assert_text '0', options={:exact => true}
    end
  end

  test 'the life points of player one equals 0 when a button value is more than current life points' do
    for i in 0..6 do
      find('button#player-one-lp-minus-one-thousand').click
    end
    find('button#player-one-lp-minus-five-hundred').click
    find('button#player-one-lp-minus-one-thousand').click
    dismiss_confirm do
      find('button#player-one-lp-confirm').click
    end
    within('p#player-one-lp') do
      assert_text '0', options={:exact => true}
    end
  end
end