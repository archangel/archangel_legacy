# Uploaders

Uploaders are built on top of Carrierwave and should extend `Archangel::ApplicationUploader`.

Below is a basic example of an Uploader

```
# frozen_string_literal: true

module Archangel
  class AmazingUploader < ApplicationUploader
    version :large do
      process resize_to_fit: [256, 256]
    end

    version :medium, from_version: :large do
      process resize_to_fit: [128, 128]
    end

    version :small, from_version: :medium do
      process resize_to_fit: [64, 64]
    end

    version :tiny, from_version: :small do
      process resize_to_fit: [32, 32]
    end

    def default_path
      "archangel/fallback/" + [version_name, "amazing.png"].compact.join("_")
    end

    def filename
      "amazing.#{file.extension}" if original_filename.present?
    end
  end
end
```

## Default Image Path

When no file has been uploaded, fallback images for Carrierwave will need to be provided as well as default path to the fallback images.

Assuming `original`, `large`, `medium`, `small` and `tiny` as the sizes specified, the following images will need to be created; 

* `archangel/fallback/amazing.jpg`
* `archangel/fallback/large_amazing.jpg`
* `archangel/fallback/medium_amazing.jpg`
* `archangel/fallback/small_amazing.jpg`
* `archangel/fallback/tiny_amazing.jpg`

These images will need to be added to the `app/assets/images/` directory. To change this path where fallback images life, override the `default_path` method.

## Upload Path

When `AmazingUploader` is used in the Page controller, `uploads/archangel/pages/amazing/123` will become the path for uploaded files. To change this path, override the `store_dir` method.
