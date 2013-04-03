ActiveAdmin.register User do

  index do
    column :email
    column :firstname
    column :lastname
    column "Date Create", :created_at
    column "Date Update", :updated_at
    column :avatar
    default_actions
  end

  config.clear_sidebar_sections!

  form do |f|
    f.inputs "User Info" do
      if f.object.new_record?
        f.input :email
        f.input :firstname
        f.input :lastname
        f.input :password
        f.input :password_confirmation
      else
        f.input :email
        f.input :firstname
        f.input :lastname
      end
    end
    f.buttons
  end

end
