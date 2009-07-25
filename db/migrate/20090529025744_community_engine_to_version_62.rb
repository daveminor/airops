class CommunityEngineToVersion62 < ActiveRecord::Migration
  def self.up
    migrate_plugin(:community_engine, 62)  
  end

  def self.down
    migrate_plugin(0, :community_engine)    
  end
end
