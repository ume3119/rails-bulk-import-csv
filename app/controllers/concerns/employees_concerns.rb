module EmployeesConcerns
  extend ActiveSupport::Concern

  def import
    file = bulk_import_params[:file]
    report_errors = []
    CSV.foreach(file.path,headers: true) do |row|
      hash = row.to_hash
      unless (nil_or_blank(hash["Employee Name"]) || nil_or_blank(hash["Email"]))

        report_to = Employee.find_by(email: hash["Report To"])&.id
        employee = @company.employees.create(name: hash["Employee Name"],email: hash["Email"],phone: hash["Phone"],parent_id: report_to)
        if employee.persisted?
          policies = hash["Assigned Policies"].split('|')
          policies.each do |name|
            policy = Policy.find_or_create_by(name: name,company_id: @company.id)
            employee.policies << policy
          end
        else
          report_errors.append({email: employee.email,errors: employee.errors.to_a})
        end
      end
    end
    return  report_errors
  end

  def check_file
      if bulk_import_params[:file].nil?
        flash[:error] = "No File Uploaded."
        redirect_to upload_csv_url
      end
  end

  private

    def nil_or_blank(val)
      val.nil? || val.blank?
    end
end