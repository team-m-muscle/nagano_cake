class ApplicationController < ActionController::Base
  @search_path = "" # ヘッダーの検索用path
  @top_page_path = "" # ヘッダーロゴのリンク用path
  before_action :authenticate_admin!, if: :admin_url 

  def admin_url
    request.fullpath.include?("/admin")
  end
end
