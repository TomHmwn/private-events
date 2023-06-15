class FixStatusName < ActiveRecord::Migration[7.0]
  def change
    rename_column :rsvps, :status, :invitation
    # Ex:- rename_column("admin_users", "pasword","hashed_pasword")
  end
end
