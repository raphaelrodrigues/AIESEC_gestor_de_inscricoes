# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20130326232103) do

  create_table "candidatos", :force => true do |t|
    t.string   "nome"
    t.string   "telemovel"
    t.string   "data_nascimento"
    t.integer  "comite_id"
    t.integer  "tipo"
    t.integer  "recrutamento_id"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
    t.string   "email"
  end

  create_table "comites", :force => true do |t|
    t.string   "nome"
    t.string   "password_hash"
    t.string   "password_salt"
    t.string   "descricao"
    t.string   "email"
    t.string   "telefone"
    t.string   "morada"
    t.string   "email_ocp"
    t.string   "auth_token"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
  end

  create_table "estados", :force => true do |t|
    t.string   "nome"
    t.date     "data"
    t.text     "descricao"
    t.string   "responsavel"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
    t.integer  "candidato_id"
  end

  create_table "formularios", :force => true do |t|
    t.string   "nome"
    t.integer  "comite_id"
    t.integer  "estado",          :default => 1
    t.integer  "tipo"
    t.datetime "created_at",                     :null => false
    t.datetime "updated_at",                     :null => false
    t.integer  "recrutamento_id"
  end

  create_table "pergunta", :force => true do |t|
    t.string   "titulo"
    t.string   "descricao"
    t.integer  "tipo"
    t.boolean  "activa"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.integer  "comite_id"
  end

  create_table "pergunta_forms", :force => true do |t|
    t.integer  "perguntum_id"
    t.integer  "ordem"
    t.boolean  "obrigatoria"
    t.integer  "formulario_id"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
  end

  create_table "recrutamentos", :force => true do |t|
    t.boolean  "estado"
    t.integer  "tipo"
    t.integer  "comite_id"
    t.date     "finished_at"
    t.datetime "created_at",                          :null => false
    t.datetime "updated_at",                          :null => false
    t.boolean  "inscricao_activa", :default => false
  end

  create_table "resposta", :force => true do |t|
    t.integer  "candidato_id"
    t.integer  "pergunta_id"
    t.text     "resposta"
    t.integer  "tipo"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
  end

end
