module RealtyHelper
  def cover_path_for(realty, version)
    realty.cover_url(version) || image_path('admin/no_cover_bg.png')
  end
end
