class CreatePhase2Schema < ActiveRecord::Migration
  def change
    create_table :organizations do |t|
      t.string  :name
      t.string  :org_type
      t.string  :privacy_officer_name
      t.string  :privacy_officer_email
      t.string  :privacy_officer_telephone
      t.text    :privacy_officer_note
    end

    create_table :installations do |t|
      t.integer     :compliance_level
      t.integer     :compliance_level_override
      t.text        :compliance_note
      t.belongs_to  :organization, :null => true
      t.string      :jurisdiction
    end

    add_index :installations, :organization_id
    add_foreign_key(:installations, :organizations, :dependent => :nullify)

    create_table :reports do |t|
      t.belongs_to  :installation
      t.float       :loc_lat_from_gps
      t.float       :loc_lng_from_gps
      t.string      :loc_description_from_google
      t.float       :loc_lat_from_user
      t.float       :loc_lng_from_user
      t.string      :loc_description_from_user
      t.boolean     :owner_identifiable
      t.string      :owner_name
      t.string      :owner_type
      t.string      :operator_name
      t.integer     :camera_count
      t.boolean     :has_sign
      t.text        :sign_text
      t.string      :sign_visibility
      t.text        :notes
      t.string      :contributor_id
      t.timestamps
    end

    add_index :reports, :installation_id
    add_foreign_key(:reports, :installations, :dependent => :nullify)

    create_table :photos do |t|
      t.belongs_to  :report
      t.text        :notes
      t.has_attached_file :image
      t.timestamps
    end

    add_index :photos, :report_id
    add_foreign_key(:photos, :reports, :dependent => :nullify)

    create_table :photo_tags do |t|
      t.belongs_to  :photo
      t.string      :tag
    end

    add_index :photo_tags, :photo_id
    add_foreign_key(:photo_tags, :photos, :dependent => :delete)

    create_table :sign_tags do |t|
      t.belongs_to  :report
      t.string      :tag
      t.string      :tag_type
      t.timestamps
    end

    add_index :sign_tags, :report_id
    add_foreign_key(:sign_tags, :reports, :dependent => :delete)
  end
end
