class WdpaImportWorker
  include Sidekiq::Worker
  sidekiq_options retry: false

  def perform(s3_key)
    s3 = Aws::S3::Resource.new
    bucket = s3.bucket(Rails.application.secrets.s3_import_bucket)

    release = bucket.object(s3_key)
    path = download_release(release)

    points_csv, polygons_csv = WdpaExtractor.extract(path)

    wdpa_release = create_release(path)
    CsvImporter.import(points_csv, wdpa_release)
    CsvImporter.import(polygons_csv, wdpa_release)
  end

  private

  def download_release(release)
    Rails.root.join("tmp/#{release.key}").tap { |path|
      release.get(response_target: path)
    }
  end

  def create_release(path)
    release_name = File.basename(path, ".gdb")
    WdpaRelease.create(name: release_name, valid_from: DateTime.now)
  end
end
