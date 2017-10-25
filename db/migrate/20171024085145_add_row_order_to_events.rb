class AddRowOrderToEvents < ActiveRecord::Migration[5.0]
  def change
    add_column :events,:row_order,:integer
    #等会要用row_order来排序，而数据库之前的event没有添加这一栏，
    #所以先把所有events都更新出row_order，其中:last是ranked-model提供的排序方式
    Event.find_each do |e|
      e.update(:row_order_position=>:last)
    end
    add_index :events,:row_order 
  end
end
