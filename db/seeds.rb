Task.delete_all
List.delete_all
Task.reset_autoincrement
List.reset_autoincrement
 
puts 'Creating sample lists'

['Todo', 'Tarefa Video Rebonatto'].each_with_index do |list|
  List.find_or_create_by(name: list)
end
 
puts 'Creating sample tasks'
['Ir ao supermercado', 'Limpar a casa'].each do |task|
  Task.find_or_create_by(name: task, list: List.where(name: 'Todo').first)
end
 
['Criar web service rest em ruby', 'Criar Consumidor de rest em java'].each do |task|
  Task.find_or_create_by(name: task, list: List.where(name: 'Tarefa Video Rebonatto').first)
end