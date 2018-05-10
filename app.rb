require 'sinatra'
require "sinatra/namespace"
require 'sinatra/cross_origin'
require 'sinatra/activerecord'
require './config/environments'
require './config/cors'
require './models/list'
require './models/task'
require 'json'

class TodoListRestApi < Sinatra::Application
    
    before do
        content_type :json
    end

    namespace '/api/lists' do
        get '' do
            List.all.to_json(include: :tasks)
        end
        
        get '/:id' do
            List.where(id: params['id']).first.to_json(include: :tasks)
        end
        
        post '' do
            payload = JSON.parse(request.body.read).symbolize_keys            
            puts payload
            list = List.new(payload)
            if list.save
                list.to_json(include: :tasks)
            else
                halt 422, list.errors.full_messages.to_json
            end
        end
        
        put '/:id' do
            list = List.where(id: params['id']).first
            
            if list
                list.name = params['name'] if params.has_key?('name')
                list.color = params['color'] if params.has_key?('color')
            
                if list.save
                    list.to_json
                else
                    halt 422, list.errors.full_messages.to_json
                end
            end
        end
        
        delete '/:id' do
            list = List.where(id: params['id'])
            
            if list.destroy_all
                {success: "ok"}.to_json
            else
                halt 500
            end
        end
    end

    namespace '/api/tasks' do
        get '' do
            Task.all.to_json
        end
        
        get '/:id' do
            Task.where(id: params['id']).first.to_json
        end
        
        post '' do
            payload = JSON.parse(request.body.read).symbolize_keys            
            puts payload
            task = Task.new(payload)
            if task.save
                task.to_json
            else
                halt 422, task.errors.full_messages.to_json
            end
        end
        
        put '/:id' do
            task = Task.where(id: params['id']).first
            
            if task
                task.name = params['name'] if params.has_key?('name')
            
                if task.save
                task.to_json
                else
                halt 422, task.errors.full_messages.to_json
                end
            end
        end
        
        delete '/:id' do
            task = Task.where(id: params['id'])
            
            if task.destroy_all
                {success: "ok"}.to_json
            else
                halt 500
            end
        end
    end

    namespace '/api' do
        get '' do
            content_type :html
            send_file './public/index.html'
        end
        
        get '/refresh' do
            load './db/seeds.rb'
        end
    end
end