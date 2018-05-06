# Policies

Policies are not separated by `frontend`, `backend` or `auth` and therefore do not need to be namespaced. [Pundit](https://github.com/varvet/pundit) is used for authorization.

Create your policy at `app/policies/archangel/foo.rb` add the following.

```
module Archangel
  class FooPolicy < ApplicationPolicy
  end
end
```

Extending `ApplicationPolicy` will set default authorization throughout the controller. The only reason you would need anything more than this is if you require more complex authorization policies.

Custom routes that are not RESTful need to added.

```
module Archangel
  class FooPolicy < ApplicationPolicy
    def custom?
      scope.where(id: record.id).exists?
    end
  end
end
```

To specifically check if the User is an `admin`, `ApplicationPolicy` has a method to do this.

```
module Archangel
  class FooPolicy < ApplicationPolicy
    def destroy?
      admin_user?
    end

    def custom?
      admin_user?
    end
  end
end
```
