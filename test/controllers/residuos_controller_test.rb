require "test_helper"

class ResiduosControllerTest < ActionDispatch::IntegrationTest
  setup do
    @residuo = residuos(:one)
  end

  test "should get index" do
    get residuos_url, as: :json
    assert_response :success
  end

  test "should create residuo" do
    assert_difference("Residuo.count") do
      post residuos_url, params: { residuo: { eventoId: @residuo.eventoId, isopor: @residuo.isopor, metal: @residuo.metal, organico: @residuo.organico, papel: @residuo.papel, perigoso: @residuo.perigoso, plastico: @residuo.plastico, vidro: @residuo.vidro } }, as: :json
    end

    assert_response :created
  end

  test "should show residuo" do
    get residuo_url(@residuo), as: :json
    assert_response :success
  end

  test "should update residuo" do
    patch residuo_url(@residuo), params: { residuo: { eventoId: @residuo.eventoId, isopor: @residuo.isopor, metal: @residuo.metal, organico: @residuo.organico, papel: @residuo.papel, perigoso: @residuo.perigoso, plastico: @residuo.plastico, vidro: @residuo.vidro } }, as: :json
    assert_response :success
  end

  test "should destroy residuo" do
    assert_difference("Residuo.count", -1) do
      delete residuo_url(@residuo), as: :json
    end

    assert_response :no_content
  end
end
