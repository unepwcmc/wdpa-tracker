class WdpaPollingWorker
  include Sidekiq::Worker
  include Sidetiq::Schedulable

  recurrence { hourly }

  def perform
    s3 = Aws::S3::Resource.new
    bucket = s3.bucket(Rails.application.secrets.s3_import_bucket)
    last_item_in_bucket = bucket.objects.sort_by(&:last_modified).last

    if newer_release?(WdpaRelease.order(:created_at).last, last_item_in_bucket)
      WdpaImportWorker.perform_async(last_item_in_bucket.key)
    end
  end

  private

  def newer_release?(current_release, newest_in_bucket)
    newest_in_bucket.last_modified > current_release.created_at
  end
end
