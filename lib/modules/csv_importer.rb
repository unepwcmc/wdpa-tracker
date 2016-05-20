require 'csv'

module CsvImporter
  def self.import(path, wdpa_release=nil)
    wdpa_release = detect_release(path) unless wdpa_release

    ActiveRecord::Base.transaction do
      CSV.foreach(path, headers: true, header_converters: :symbol) do |row|
        protected_area = find_protected_area(row[:wdpaid])
        next if protected_area.nil?

        protected_area.name          = row[:name] || protected_area.name
        protected_area.countries     = find_countries(row[:iso3])
        protected_area.designation   = find_designation(row[:desig_eng], row[:desig_type])
        protected_area.wdpa_releases << wdpa_release
        protected_area.save!
      end
    end
  end

  def self.find_protected_area(wdpa_id)
    return nil if wdpa_id.blank?
    ProtectedArea.find_or_initialize_by(wdpa_id: wdpa_id)
  end

  ABOVE_NATIONAL_JURISDICTION = "ABNJ"
  def self.find_countries(isos3)
    return [] if isos3.blank? || isos3 == ABOVE_NATIONAL_JURISDICTION

    isos3.split(/[,;]/).map do |iso3|
      Country.find_or_initialize_by(iso3: iso3)
    end
  end

  def self.find_designation(name, type)
    return nil if name.blank? || type.blank?
    designation_type = DesignationType.find_or_initialize_by(name: type)
    designation = Designation.find_or_initialize_by(name: name, designation_type: designation_type)

    designation
  end

  def self.detect_release(path)
    filename = File.basename(path, ".csv")

    if filename =~ /year-(\d{4})/
      year = $1.to_i

      return WdpaRelease.create(
        name:       "WDPA_#{$1}",
        valid_from: DateTime.new(year),
        valid_to:   DateTime.new(year) + 1.year
      )
    end

    if filename =~ /month-(\d{2})-(\d{4})/
      month = $1.to_i
      year  = $2.to_i

      return WdpaRelease.create(
        name:       "WDPA_#{$1}",
        valid_from: DateTime.new(year, month),
        valid_to:   DateTime.new(year, month) + 1.month
      )
    end
  end
end
