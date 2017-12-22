class Allocation < ActiveRecord::Base
  belongs_to :country
  belongs_to :protected_area
  belongs_to :user

  def self.to_csv
    csv = ''
    allocation_columns = Allocation.new.attributes.keys
    allocation_columns.delete_if { |k, v| ["created_at", "updated_at", "country_id"].include? k }
    allocation_columns << "Country"

    allocation_columns.map! { |e|
      e.gsub("_", " ").capitalize
    }

    csv << allocation_columns.join(',')
    csv << "\n"

    allocations = Allocation.all

    allocations.to_a.each do |allocation|
      allocation_attributes = allocation.attributes
      allocation_attributes[:country] = allocation.country.iso3
      allocation_attributes.delete_if { |k, v| ["created_at", "updated_at", "country_id"].include? k }

      allocation_attributes = allocation_attributes.values.map{ |e| "\"#{e}\"" }
      csv << allocation_attributes.join(',').to_s
      csv << "\n"
    end

    csv

  end
end
