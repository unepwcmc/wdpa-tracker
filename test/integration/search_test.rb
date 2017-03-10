require 'test_helper'

class SearchTest < ActionDispatch::IntegrationTest
  test "search range of wdpaids succeeds" do
    FactoryGirl.create(:protected_area, wdpa_id: 5)
    FactoryGirl.create(:protected_area, wdpa_id: 6)

    get "/search", {search_type: "range", "range_from": 1, "range_to": 10}
    assert_response :success
  end

  test "search range of wdpaids returns only results in wdpa releases" do
    FactoryGirl.create(:protected_area, wdpa_id: 5, wdpa_releases_count: 0)
    FactoryGirl.create(:protected_area, wdpa_id: 6, wdpa_releases_count: 0)

    get "/search", {search_type: "range", "range_from": 1, "range_to": 10}

    assert_response :success
    assert_select ".qa-no-results", "No results found"
  end

  test "search range with only one result redirects to PA page" do
    pa = FactoryGirl.create(:protected_area, wdpa_id: 5)
    search_id = {search_type: "range", "range_from": 1, "range_to": 10}

    get "/search", search_id
    assert_redirected_to protected_area_path(pa.wdpa_id, from_search: search_id)
  end

  test "search range and sort wdpa_id succeeds" do
    FactoryGirl.create(:protected_area, wdpa_id: 5)
    FactoryGirl.create(:protected_area, wdpa_id: 6)

    search_id = {search_type: "range", "range_from": 1, "range_to": 10}
    sort = {sort: "wdpa_id"}

    get "/search", search_id.merge(sort)
    assert_response :success
  end

  test "search range and sort country ISO succeeds" do
    FactoryGirl.create(:protected_area, wdpa_id: 5)
    FactoryGirl.create(:protected_area, wdpa_id: 6)

    search_id = {search_type: "range", "range_from": 1, "range_to": 10}
    sort = {sort: "iso"}

    get "/search", search_id.merge(sort)
    assert_response :success
  end

  test "search range and sort designation succeeds" do
    FactoryGirl.create(:protected_area, wdpa_id: 5)
    FactoryGirl.create(:protected_area, wdpa_id: 6)

    search_id = {search_type: "range", "range_from": 1, "range_to": 10}
    sort = {sort: "designation"}

    get "/search", search_id.merge(sort)
    assert_response :success
  end
end
