class AddAttachmentLogoToFirm < ActiveRecord::Migration
  def self.up
    add_column :firms, :logo_file_name, :string
    add_column :firms, :logo_content_type, :string
    add_column :firms, :logo_file_size, :integer
    add_column :firms, :logo_updated_at, :datetime
    add_column :firms, :background, :string
    add_column :firms, :color, :string
  end

  def self.down
    remove_column :firms, :logo_file_name
    remove_column :firms, :logo_content_type
    remove_column :firms, :logo_file_size
    remove_column :firms, :logo_updated_at
    remove_column :firms, :background, :string
    remove_column :firms, :color, :string
  end
end
