ActiveAdmin.register Movie do
  permit_params :title, :description, :release_date, :film_rate_id, :featured, :director_id, :poster_path, :language
  form do |f|
    f.inputs do
      f.input :title
      f.input :description
      f.input :release_date, as: :datepicker,
              datepicker_options: {
                min_date: "1900-01-01",
                max_date: 1.day.ago.to_date
              }
      f.input :film_rate_id
      f.input :featured
      f.input :director_id
      f.input :poster_path
      f.input :language
      f.actions
    end
  end
end