ActiveAdmin.register Product do

  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  permit_params :name, :category, :price, :user_id, :status, :quantity, :isAvailable
  #
  # or
  #
  # permit_params do
  #   permitted = [:name, :category, :price, :user_id, :status, :quantity, :isAvailable]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end
  form do |f|
    f.inputs :user, :name, :price, :quantity, :status, :isAvailable
    f.input :category,
        as:         :select,
        collection: ["Women Accessories","Electronics", "Footwear", "Electrical Appliances", "School Supplies"],
        prompt:     false
    actions
  end
  
end
