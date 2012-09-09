class InstallationsController < ApplicationController

  skip_before_filter :verify_authenticity_token

  respond_to :json

  def index
    if params[:owner_name]
      @inst = Installation.find(:all, 
        :conditions => ["reports.owner_name = ?", params[:owner_name]],
        :include => :reports
      )
    else
      @inst = Installation.find(:all,
        :include => :latest_report)
    end
    @inst.sort_by{|inst| inst.owner_name || ""}
    respond_with_installation(@inst)
  end

  def near
    @inst = Installation.near(params[:lat].to_f, params[:lng].to_f, params[:max_dist].to_f)
    @inst.sort_by!(&:distance)
    respond_with_installation(@inst)
  end

  def show
    @inst = Installation.find(params[:id])
    respond_with_installation(@inst)
  end

  def autocomplete_owner_name
    @reports = Report.find(:all,
        :conditions => ["reports.owner_name LIKE ?", (params[:term]||"")+'%'])
    respond_with(@reports.collect {|r| r.owner_name}.uniq)
  end

  protected
  def respond_with_installation(inst)
    meths = [:latest_report, :loc_lat, :loc_lng, :loc_description, 
      :owner_name, :owner_aliases, :owner_type, :photos, :tags, :compliance_level]

    respond_with(inst, :methods => meths)
  end

end
