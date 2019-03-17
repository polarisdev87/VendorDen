class SetSettingForAllShops < ActiveRecord::Migration[5.2]
  def up
    Shop.all.to_a.each do |shop|
      shop.send(:set_setting) unless shop.setting.present?
    end
  end
end
