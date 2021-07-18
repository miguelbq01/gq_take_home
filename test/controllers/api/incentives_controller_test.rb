require 'test_helper'

class Api::IncentivesControllerTest < ActionDispatch::IntegrationTest
  describe 'GET #index' do
    subject { get '/api/incentives' }

    setup do
      create(:incentive, { code: 'COUPON!', redeemed: false})
    end

    it 'should return all incentives' do
      subject
      assert_response :ok
      data = response.parsed_body
      assert_equal 1, data.size
      assert_equal 'COUPON!', data[0]['code']
      assert_equal false, data[0]['redeemed']
      assert data[0].key? 'id'
    end
  end

  describe 'PUT #update' do
    subject { put "/api/incentives/#{incentive.id}", params: {incentive: params} }

    let(:incentive) { create(:incentive) }
    let(:params) { {code: 'FOOBAR'} }

    it 'should update the incentive' do
      subject
      assert_response :success
      assert_equal 'FOOBAR', incentive.reload.code
    end
  end

  describe 'POST #create' do
    subject { post "/api/incentives/", params: {incentive: params} }

    setup do
      create(:incentive, { code: 'COUPON!', redeemed: false})
    end

    let(:params) { {code: 'NEW_CODE'} }

    it 'should create the incentive' do
      subject
      assert_response :success
      data = response.parsed_body
      assert_equal 'NEW_CODE', data[1]['code']
      assert_equal false, data[1]['redeemed']
    end

    it 'should return Code already created' do
      params[:code] = "COUPON!"
      subject
      assert_response :unprocessable_entity
      data = response.parsed_body
      assert_equal 'Code already created', data['error']
    end
  end

  describe 'GET #get_code' do
    subject { get "/api/get_code" }

    it 'should return No codes available' do
      subject
      assert_response :not_found
      data = response.parsed_body
      assert_equal 'No codes available.', data["error"]
    end

    it 'should return a incentive code and be already redeemed' do
      create(:incentive, { code: 'COUPON!', redeemed: false})
      subject
      assert_response :success
      data = response.parsed_body
      assert_equal 'COUPON!', data["code"]
      assert_equal true, data["redeemed"]
    end

    it 'should return the unredeemed code' do
      create(:incentive, { code: 'CODE1', redeemed: false})
      create(:incentive, { code: 'CODE2', redeemed: true})
      subject
      assert_response :success
      data = response.parsed_body
      assert_equal "CODE1", data["code"]
      assert_equal true, data["redeemed"]
    end
  end
end
