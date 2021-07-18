require "application_system_test_case"

class ResearcherTest < ApplicationSystemTestCase

  describe 'viewing_incentive' do
    setup do 
      create(:incentive, code: 'COUPON_123')
    end

    it 'should_show_the_current_coupon' do
      visit '/setup'
      assert_equal 'COUPON_123', find_by_id('code_table').first("tbody tr td").text
    end
  end

  describe 'add new codes' do
    let(:incentive) { create(:incentive, code: 'OLD_CODE')}

    setup do
      incentive ## create incentive beforehand as let doesnt run until called
    end
    
    it 'should_update_the_code_table' do
      visit '/setup'
      fill_in 'incentive_code', with: 'NEW_CODE'
      click_on 'Save'
      assert_text 'Successfully created'
      table_tr = find_by_id('code_table').all("tbody tr")
      assert_equal 'OLD_CODE', table_tr.first.first("td").text
      assert_equal 'NEW_CODE', table_tr.last.first("td").text
    end

    it 'should return Code already on the list, please enter another code, when sending existing code' do
      visit '/setup'
      fill_in 'incentive_code', with: 'OLD_CODE'
      click_on 'Save'
      assert_text 'Code already on the list, please enter another code'
    end
  end
end