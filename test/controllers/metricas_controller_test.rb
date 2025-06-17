require "test_helper"

class MetricasControllerTest < ActionDispatch::IntegrationTest
  setup do
    @metrica = metricas(:one)
  end

  test "should get index" do
    get metricas_url, as: :json
    assert_response :success
  end

  test "should create metrica" do
    assert_difference("Metrica.count") do
      post metricas_url, params: { metrica: {  } }, as: :json
    end

    assert_response :created
  end

  test "should show metrica" do
    get metrica_url(@metrica), as: :json
    assert_response :success
  end

  test "should update metrica" do
    patch metrica_url(@metrica), params: { metrica: {  } }, as: :json
    assert_response :success
  end

  test "should destroy metrica" do
    assert_difference("Metrica.count", -1) do
      delete metrica_url(@metrica), as: :json
    end

    assert_response :no_content
  end
end
