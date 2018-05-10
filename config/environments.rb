configure :production, :development do
    set :show_exceptions, true

    db = URI.parse(ENV['DATABASE_URL'] || 'postgres://localhost/videosd')
    ActiveRecord::Base.establish_connection(
        adapter: 'postgresql',
        host: 'localhost',
        username: 'postgres',
        password: 'masterkey',
        database: 'videosd',
        encoding: 'utf8'
    )

    ActiveRecord::Base.class_eval do
        def self.reset_autoincrement(options={})
            options[:to] ||= 1
            case self.connection.adapter_name
                when 'MySQL'
                    self.connection.execute "ALTER TABLE #{self.table_name} AUTO_INCREMENT=#{options[:to]}"
                when 'PostgreSQL'
                    self.connection.execute "ALTER SEQUENCE #{self.table_name}_id_seq RESTART WITH #{options[:to]};"
                when 'SQLite'
                    self.connection.execute "UPDATE sqlite_sequence SET seq=#{options[:to]} WHERE name='#{self.table_name}';"
                else
            end
        end
    end
end