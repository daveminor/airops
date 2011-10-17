class CommunityEngineToVersion76 < ActiveRecord::Migration
  def self.up
    migrate_plugin(:community_engine, 76)  
  end

  def self.down
    migrate_plugin(:community_engine, 62)    
  end
end
