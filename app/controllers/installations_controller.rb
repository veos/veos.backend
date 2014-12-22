class InstallationsController < ApplicationController

  skip_before_filter :verify_authenticity_token

  respond_to :json

  def index
    if params[:owner_name]
      @inst = Installation.includes(:latest_report)
                .where(["reports.owner_name = ?", params[:owner_name]])
                .page(params[:page] || 1)
                .per(params[:per_page] || 10)
    else
      @inst = Installation.includes(:latest_report)
                .page(params[:page] || 1)
                .per(params[:per_page] || 10)
    end

    # sort by owner_name, blank last
    # if names are identical, installations with newer reports go first
    @inst.sort! do |a,b|
      if a.owner_name.blank?
        1
      elsif b.owner_name.blank?
        -1
      else
        [a.owner_name && a.owner_name.downcase, a.latest_report && Time.now - a.latest_report.updated_at] <=> 
          [b.owner_name && b.owner_name.downcase, b.latest_report && Time.now - b.latest_report.updated_at]
      end
    end

    respond_with_installation(@inst)
  end

  def near
    @inst = Installation
      .near(params[:lat].to_f, params[:lng].to_f, params[:max_dist].nil? ? nil : params[:max_dist].to_f)
      .page(params[:page] || 1)
      .per(params[:per_page] || 10)
    @inst.sort_by!(&:distance) if params[:max_dist]
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
