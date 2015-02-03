class AddRequestSubjectId < ActiveRecord::Migration
  def change
    add_column :requests, :subject_id, :integer, :after => :to_id
  end
end
