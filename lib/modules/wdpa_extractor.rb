module WdpaExtractor
  def self.extract(path)
    unless path = unzip_release(path)
      raise RuntimeError, "couldn't unzip the release"
    end

    points_table, polygons_table = wdpa_tables(path)

    points_csv_path   = path.sub(".gdb", "_points.csv")
    polygons_csv_path = path.sub(".gdb", "_polygons.csv")

    points_thread    = async_gdb2csv(ogr_query(points_table), points_csv_path, path)
    polygons_thread  = async_gdb2csv(ogr_query(polygons_table), polygons_csv_path, path)

    points_csv_path, polygons_csv_path = [points_thread, polygons_thread].map(&:value)

    if !points_csv_path || !polygons_csv_path
      raise RuntimeError, "ogr2ogr couldn't convert the release"
    end

    [points_csv_path, polygons_csv_path]
  end

  def self.unzip_release(path)
    gdb_path = path.sub("zip", "gdb")
    return gdb_path if gdb_path.exist?

    if system("unzip -j '#{path}' '\*.gdb/\*' -d '#{gdb_path}'")
      gdb_path
    else
      false
    end
  end

  def self.async_gdb2csv(query, csv_path, gdb_path)
    Thread.new {
      if system %Q(ogr2ogr -f "CSV" -overwrite -sql "#{query}" #{csv_path} #{gdb_path})
        csv_path
      else
        false
      end
    }
  end

  def self.ogr_query(table)
    "SELECT WDPAID,NAME,PARENT_ISO3,ISO3,DESIG_ENG,DESIG_TYPE FROM #{table}"
  end

  def self.wdpa_tables path
    ogr_info = OgrInfo.new(path)
    p ogr_info.layers
    [ogr_info.layers_matching(/point/i).first, ogr_info.layers_matching(/poly/i).first]
  end
end
