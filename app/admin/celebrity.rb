ActiveAdmin.register Celebrity do
  permit_params :display_name, :first_name, :last_name, :gender, :birthdate, :deathdate, :nationality, :celebrity_type, :biography, :place_of_birth
end

