# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2021_01_01_001723) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "awards", force: :cascade do |t|
    t.text "award", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["award"], name: "index_awards_on_award", unique: true
  end

# Could not dump table "celebrities" because of following StandardError
#   Unknown type 'celebrity_type' for column 'celebrity_type'

  create_table "comments", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "movie_id", null: false
    t.string "comment", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["movie_id"], name: "index_comments_on_movie_id"
    t.index ["user_id"], name: "index_comments_on_user_id"
  end

  create_table "genres", force: :cascade do |t|
    t.text "genre", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["genre"], name: "index_genres_on_genre", unique: true
  end

  create_table "movie_awards", force: :cascade do |t|
    t.bigint "movie_id", null: false
    t.bigint "award_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["award_id"], name: "index_movie_awards_on_award_id"
    t.index ["movie_id", "award_id"], name: "index_movie_awards_on_movie_id_and_award_id", unique: true
    t.index ["movie_id"], name: "index_movie_awards_on_movie_id"
  end

  create_table "movie_celebrities", force: :cascade do |t|
    t.bigint "movie_id", null: false
    t.bigint "celebrity_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["celebrity_id"], name: "index_movie_celebrities_on_celebrity_id"
    t.index ["movie_id", "celebrity_id"], name: "index_movie_celebrities_on_movie_id_and_celebrity_id", unique: true
    t.index ["movie_id"], name: "index_movie_celebrities_on_movie_id"
  end

  create_table "movie_genres", force: :cascade do |t|
    t.bigint "movie_id", null: false
    t.bigint "genre_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["genre_id"], name: "index_movie_genres_on_genre_id"
    t.index ["movie_id", "genre_id"], name: "index_movie_genres_on_movie_id_and_genre_id", unique: true
    t.index ["movie_id"], name: "index_movie_genres_on_movie_id"
  end

  create_table "movie_rates", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "movie_id", null: false
    t.float "rate"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["movie_id"], name: "index_movie_rates_on_movie_id"
    t.index ["user_id", "movie_id"], name: "index_movie_rates_on_user_id_and_movie_id", unique: true
    t.index ["user_id"], name: "index_movie_rates_on_user_id"
  end

  create_table "movies", force: :cascade do |t|
    t.text "title", null: false
    t.text "description", null: false
    t.float "rating", default: 0.0
    t.date "release_date", null: false
    t.integer "director_id", null: false
    t.integer "film_rate_id", null: false
    t.boolean "featured", default: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "poster_path"
    t.string "language"
  end

# Could not dump table "news" because of following StandardError
#   Unknown type 'permission_type' for column 'posted_by'

  create_table "rates", force: :cascade do |t|
    t.text "rate", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["rate"], name: "index_rates_on_rate", unique: true
  end

  create_table "users", force: :cascade do |t|
    t.text "username", null: false
    t.text "email", null: false
    t.text "password", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["email"], name: "index_users_on_email", unique: true
  end

  create_table "watchlists", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "movie_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["movie_id"], name: "index_watchlists_on_movie_id"
    t.index ["user_id", "movie_id"], name: "index_watchlists_on_user_id_and_movie_id", unique: true
    t.index ["user_id"], name: "index_watchlists_on_user_id"
  end

  add_foreign_key "comments", "movies"
  add_foreign_key "comments", "users"
  add_foreign_key "movie_awards", "awards"
  add_foreign_key "movie_awards", "movies"
  add_foreign_key "movie_celebrities", "celebrities"
  add_foreign_key "movie_celebrities", "movies"
  add_foreign_key "movie_genres", "genres"
  add_foreign_key "movie_genres", "movies"
  add_foreign_key "movie_rates", "movies"
  add_foreign_key "movie_rates", "users"
  add_foreign_key "watchlists", "movies"
  add_foreign_key "watchlists", "users"
end
