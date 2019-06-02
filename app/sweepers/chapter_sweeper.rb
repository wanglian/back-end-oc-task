class ChapterSweeper < ActionController::Caching::Sweeper
  observe Chapter

  def after_create(record)
    cache_dir = ActionController::Base.page_cache_directory
    FileUtils.rm Dir.glob(cache_dir + "/maze/room/*")
  end
end