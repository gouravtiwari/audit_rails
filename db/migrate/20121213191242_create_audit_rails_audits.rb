class CreateAuditRailsAudits < ActiveRecord::Migration
  def change
    create_table :audit_rails_audits do |t|
      t.string :action
      t.string :controller
      t.string :description
      t.string :user_name
      t.string :ip_address

      t.timestamps
    end
  end
end
