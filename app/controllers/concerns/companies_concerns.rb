module CompaniesConcerns
  extend ActiveSupport::Concern

  def company
    @company = Company.find_by(id: bulk_import_params[:company])
    unless @company
      @companies = Company.all
      flash[:error] = "Company not found."
      redirect_to upload_csv_url
    end
    #If Company Does not exists move back.
  end
end