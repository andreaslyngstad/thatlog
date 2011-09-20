class DeviseCreateUsers < ActiveRecord::Migration
  def self.up
    create_table(:users) do |t|
      t.database_authenticatable :null => false
      t.recoverable
      t.rememberable
      t.trackable
      
      # t.lockable :lock_strategy => :failed_attempts, :unlock_strategy => :both
      # t.token_authenticatable
		t.string   	:loginable_token
	    t.string   	:invitation_token,     :limit => 60
	    t.datetime 	:invitation_sent_at
	    t.string   	:confirmation_token
	    t.datetime 	:confirmed_at
	    t.datetime 	:confirmation_sent_at
	    
	    t.string   	:roles
      	t.string 	:phone
      	t.string 	:name
      	t.integer 	:firm_id
   

      t.timestamps
    end
	add_index :users, :loginable_token
    add_index :users, :email,                :unique => true
    add_index :users, :reset_password_token, :unique => true
    # add_index :users, :confirmation_token,   :unique => true
    # add_index :users, :unlock_token,         :unique => true
  end

  def self.down
    drop_table :users
  end
end
