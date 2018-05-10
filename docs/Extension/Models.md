# Models

Models are not separated by `frontend`, `backend` or `auth` and therefore do not need to be namespaced.

Create your model at `app/models/archangel/foo.rb` add the following.

```
module Archangel
  class Foo < ApplicationRecord
    before_validation :parameterize_slug

    validates :bar, presence: true
    validates :slug, presence: true, uniqueness: { scope: :site_id }

    belongs_to :site

    protected

    def parameterize_slug
      self.slug = slug.to_s.downcase.parameterize
    end
  end
end
```

To change the `id` for constructing a URL to this object you can override `#to_param` in your model to make `foo_path` construct a path using the record `slug` instead of the `id`. See [`#to_param`](https://apidock.com/rails/ActiveRecord/Base/to_param) for further explanation.

```
def to_param
  slug
end
```
