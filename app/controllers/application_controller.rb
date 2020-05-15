class ApplicationController < ActionController::Base
  #セキュリティトークンが自動的にすべてのフォームに含まれる
  protect_from_forgery with: :exception
  include SessionsHelper
end
