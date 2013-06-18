class AddColumnReadToResponses < ActiveRecord::Migration
  def change
    add_column :responses, :read, :boolean, :default => false
    responses = Response.all
    responses.each do |r|
      r.read = false
    end
  end
end
