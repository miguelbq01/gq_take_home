require "application_system_test_case"

class CandidateTest < ApplicationSystemTestCase

  describe 'redeeming the incentive' do
    setup do 
      create(:incentive, {code: 'COUPON_123', redeemed: false})
    end

    it 'should give the latest coupon' do
      visit '/redeem'
      click_on 'Redeem'
      assert_text 'COUPON_123'
    end

    it 'should give a coupon when there is another already redeemed' do
      visit '/redeem'
      click_on 'Redeem'
      assert_text 'COUPON_123'
      create(:incentive, {code: 'COUPON_456', redeemed: false})
      click_on 'Redeem'
      assert_text 'COUPON_456'
    end
  end

  describe 'no codes available' do
    setup do 
      create(:incentive, { code: 'COUPON_123', redeemed: true })
    end

    it 'should return No codes available message' do
      visit '/redeem'
      click_on 'Redeem'
      assert_text 'There are no more codes available!'
    end
  end
end