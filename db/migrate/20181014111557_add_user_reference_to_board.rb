class AddUserReferenceToBoard < ActiveRecord::Migration[5.2]
  def change
    add_reference :boards, :user, required: true
  end
end
