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

ActiveRecord::Schema[7.1].define(version: 2024_02_09_181905) do
  create_table "academic_histories", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "title"
    t.string "institution"
    t.string "degree"
    t.datetime "start_date", precision: nil
    t.datetime "end_date", precision: nil
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "candidate_id", null: false
    t.index ["candidate_id"], name: "index_academic_histories_on_candidate_id"
  end

  create_table "application_exams", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "application_status_id", null: false
    t.index ["application_status_id"], name: "index_application_exams_on_application_status_id"
  end

  create_table "application_forms", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "application_status_id", null: false
    t.bigint "dynamic_form_id", null: false
    t.index ["application_status_id"], name: "index_application_forms_on_application_status_id"
    t.index ["dynamic_form_id"], name: "index_application_forms_on_dynamic_form_id"
  end

  create_table "application_statuses", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "status"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "hiring_process_id", null: false
    t.bigint "candidate_id", null: false
    t.index ["candidate_id"], name: "index_application_statuses_on_candidate_id"
    t.index ["hiring_process_id"], name: "index_application_statuses_on_hiring_process_id"
  end

  create_table "candidate_skills", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "candidate_id", null: false
    t.bigint "skill_id", null: false
    t.index ["candidate_id"], name: "index_candidate_skills_on_candidate_id"
    t.index ["skill_id"], name: "index_candidate_skills_on_skill_id"
  end

  create_table "candidates", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.string "phone_number1"
    t.string "phone_number2"
    t.boolean "employee"
    t.string "resume"
    t.string "birthplace"
    t.string "gender"
    t.date "birthdate"
    t.string "marital_status"
    t.string "address_neighborhood"
    t.string "address_city"
    t.string "mother_name"
    t.string "spouse_name"
    t.integer "number_of_children"
    t.string "residence_status"
    t.string "possessions"
    t.boolean "other_incomes"
    t.boolean "relatives_in_company"
    t.boolean "smoker"
    t.boolean "alcohol_consumer"
    t.boolean "medication_user"
    t.text "first_question"
    t.text "second_question"
    t.text "third_question"
    t.text "fourth_question"
    t.text "fifth_question"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "user_id", null: false
    t.index ["user_id"], name: "index_candidates_on_user_id"
  end

  create_table "companies", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "company_name"
    t.string "cnpj"
    t.string "sector"
    t.integer "company_size"
    t.string "company_location"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "documents", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "document_name"
    t.string "document_number"
    t.datetime "issue_date", precision: nil
    t.string "location"
    t.string "image"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "candidate_id", null: false
    t.index ["candidate_id"], name: "index_documents_on_candidate_id"
  end

  create_table "dynamic_exams", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "title"
    t.string "description"
    t.string "department"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "dynamic_forms", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "title"
    t.text "description"
    t.string "department"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "employment_histories", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "company_name"
    t.string "position"
    t.datetime "start_date", precision: nil
    t.datetime "end_date", precision: nil
    t.text "achievements"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "candidate_id", null: false
    t.index ["candidate_id"], name: "index_employment_histories_on_candidate_id"
  end

  create_table "exam_questions", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "text"
    t.string "type"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "dynamic_exam_id", null: false
    t.index ["dynamic_exam_id"], name: "index_exam_questions_on_dynamic_exam_id"
  end

  create_table "exam_responses", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "application_exam_id", null: false
    t.bigint "question_alternative_id", null: false
    t.index ["application_exam_id"], name: "index_exam_responses_on_application_exam_id"
    t.index ["question_alternative_id"], name: "index_exam_responses_on_question_alternative_id"
  end

  create_table "feedbacks", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "feedback_title"
    t.integer "overall_assessment"
    t.string "specific_comment"
    t.string "improvements"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "hiring_process_id", null: false
    t.index ["hiring_process_id"], name: "index_feedbacks_on_hiring_process_id"
  end

  create_table "form_fields", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.text "question"
    t.string "response_type"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "dynamic_form_id", null: false
    t.index ["dynamic_form_id"], name: "index_form_fields_on_dynamic_form_id"
  end

  create_table "form_responses", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.integer "number_value"
    t.text "text_value"
    t.string "string_value"
    t.boolean "boolean_value"
    t.date "date_value"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "application_form_id", null: false
    t.bigint "form_field_id", null: false
    t.index ["application_form_id"], name: "index_form_responses_on_application_form_id"
    t.index ["form_field_id"], name: "index_form_responses_on_form_field_id"
  end

  create_table "hiring_processes", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.datetime "start_date", precision: nil
    t.datetime "end_date", precision: nil
    t.string "stage"
    t.string "status"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "job_posting_id", null: false
    t.bigint "recruiter_id", null: false
    t.index ["job_posting_id"], name: "index_hiring_processes_on_job_posting_id"
    t.index ["recruiter_id"], name: "index_hiring_processes_on_recruiter_id"
  end

  create_table "interviews", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.datetime "date_time", precision: nil
    t.string "interview_type"
    t.text "resume"
    t.string "interview_feedback"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "hiring_process_id", null: false
    t.index ["hiring_process_id"], name: "index_interviews_on_hiring_process_id"
  end

  create_table "job_postings", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "title"
    t.string "description"
    t.text "requirements"
    t.string "job_location"
    t.string "regime"
    t.string "modality"
    t.string "salary"
    t.string "work_schedule"
    t.datetime "start_date", precision: nil
    t.datetime "end_date", precision: nil
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "company_id", null: false
    t.index ["company_id"], name: "index_job_postings_on_company_id"
  end

  create_table "notifications", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "title"
    t.string "notification_type"
    t.string "recipient"
    t.string "message"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "professional_links", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "title"
    t.string "link"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "candidate_id", null: false
    t.index ["candidate_id"], name: "index_professional_links_on_candidate_id"
  end

  create_table "question_alternatives", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.boolean "correct"
    t.string "tex"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "exam_question_id", null: false
    t.index ["exam_question_id"], name: "index_question_alternatives_on_exam_question_id"
  end

  create_table "recruiters", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.string "position"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "user_id", null: false
    t.index ["user_id"], name: "index_recruiters_on_user_id"
  end

  create_table "skills", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "title"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "social_medias", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "title"
    t.string "link"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "candidate_id", null: false
    t.index ["candidate_id"], name: "index_social_medias_on_candidate_id"
  end

  create_table "users", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "name"
    t.string "cpf"
    t.string "email"
    t.string "password_digest"
    t.string "role"
    t.string "photo"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "discarded_at", precision: nil
    t.index ["discarded_at"], name: "index_users_on_discarded_at"
  end

  add_foreign_key "academic_histories", "candidates"
  add_foreign_key "application_exams", "application_statuses"
  add_foreign_key "application_forms", "application_statuses"
  add_foreign_key "application_forms", "dynamic_forms"
  add_foreign_key "application_statuses", "candidates"
  add_foreign_key "application_statuses", "hiring_processes"
  add_foreign_key "candidate_skills", "candidates"
  add_foreign_key "candidate_skills", "skills"
  add_foreign_key "candidates", "users"
  add_foreign_key "documents", "candidates"
  add_foreign_key "employment_histories", "candidates"
  add_foreign_key "exam_questions", "dynamic_exams"
  add_foreign_key "exam_responses", "application_exams"
  add_foreign_key "exam_responses", "question_alternatives"
  add_foreign_key "feedbacks", "hiring_processes"
  add_foreign_key "form_fields", "dynamic_forms"
  add_foreign_key "form_responses", "application_forms"
  add_foreign_key "form_responses", "form_fields"
  add_foreign_key "hiring_processes", "job_postings"
  add_foreign_key "hiring_processes", "recruiters"
  add_foreign_key "interviews", "hiring_processes"
  add_foreign_key "job_postings", "companies"
  add_foreign_key "professional_links", "candidates"
  add_foreign_key "question_alternatives", "exam_questions"
  add_foreign_key "recruiters", "users"
  add_foreign_key "social_medias", "candidates"
end
