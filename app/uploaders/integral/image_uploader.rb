module Integral
  # Handles uploading images
  class ImageUploader < CarrierWave::Uploader::Base
    include ::CarrierWave::Backgrounder::Delay
    include CarrierWave::MiniMagick
    include CarrierWave::ImageOptimizer

    # Process image
    process optimize: [{ quality: Integral.configuration.image_compression_quality }]
    process :store_dimensions
    process :store_file_size

    # Override the directory where uploaded files will be stored.
    def store_dir
      "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
    end

    # Extension white list
    def extension_white_list
      %w(jpg jpeg gif png)
    end

    # Override the filename of the uploaded files
    def filename
      return unless original_filename

      if model.respond_to?("#{mounted_as}_filename")
        filename = model.send("#{mounted_as}_filename")
      else
        filename = model.title.parameterize
      end

      # Safe-guard against customized filename methods or parameterize returning an empty string
      return original_filename if filename.blank?

      "#{filename}.#{file.extension}"
    end

    # Return original URL if processing hasn't been complete (no versions available)
    def url *args
      version_name, _ = args

      if model.send("#{mounted_as}_processing?".to_sym)
        # Without Args
        super()
      else
        # With Args
        super
      end
    end

    # Override full_filename to set version name at the end
    def full_filename(for_file)
      if parent_name = super(for_file)
        extension = File.extname(parent_name)
        base_name = parent_name.chomp(extension)
        if version_name
          base_name = base_name[version_name.size.succ..-1]
        end
        [base_name, version_name].compact.join("-") + extension
      end
    end

    # Override full_original_filename to set version name at the end
    def full_original_filename
      parent_name = super
      extension = File.extname(parent_name)
      base_name = parent_name.chomp(extension)
      if version_name
        base_name = base_name[version_name.size.succ..-1]
      end
      [base_name, version_name].compact.join("-") + extension
    end

    # Large Version
    version :large do
      process :resize_to_fit => Integral.configuration.image_large_size
    end

    # Medium Version
    version :medium, from_version: :large do
      process :resize_to_fit => Integral.configuration.image_medium_size
    end

    # Small Version
    version :small, from_version: :medium do
      process :resize_to_fit => Integral.configuration.image_small_size
    end

    # Thumbnail Version
    version :thumbnail, from_version: :small do
      process :resize_to_fill => Integral.configuration.image_thumbnail_size
    end

    private

    def store_dimensions
      return unless file && model
      return unless model.respond_to?(:width=) && model.respond_to?(:height=)

      model.width, model.height = ::MiniMagick::Image.open(file.file)[:dimensions]
    end

    def store_file_size
      return unless file && model
      return unless model.respond_to?(:file_size=)

      model.file_size = file.size
    end
  end
end
