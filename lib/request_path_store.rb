# frozen_string_literal: true

# Metadata from logline for paths
# done with simple hash
class RequestPathStore
  def initialize
    @store = {}
  end

  # Count uniq views per path
  # @return [Hash]
  def uniq_views_by_path
    @store.map do |path, ips_views|
      { path => ips_views.count }
    end
  end

  # Count all views per path
  # @return [Hash]
  def views_by_path
    @store.map do |path, ips_views|
      { path => ips_views.values.reduce(&:+) }
    end
  end

  # Emit logline to the this store
  # @param logline [#ip,#path]
  def emit(logline)
    @store[logline.path] ||= {}
    @store[logline.path][logline.ip] ||= 0
    @store[logline.path][logline.ip] += 1
  end
end
