module DrawBot
  module DiscordEvents
    # This event is processed when the bot joins a new server.
    module ServerCreate
      extend Discordrb::EventContainer
      server_create do |server|
        server = server.server
        BOT.channel(CONFIG.devchannel)
           .send_message "**Joined server:** #{server.name} (#{server.id})\n"\
                         "**Owner:** #{server.owner.distinct}\n"\
                         "**Members:** #{server.members.count}"
        server_sql = Database::Server.find(discord_id: server.id)
        if server_sql.nil?
          Database::Server.create(discord_id: server.id,
                                  discord_name: server.name,
                                  owner_id: server.owner.id)
        end
      end
    end
  end
end