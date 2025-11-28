# Example: Good Python Code Review

This example demonstrates a well-structured code review with appropriate severity categorization and actionable recommendations.

## Code Under Review

```python
# user_service.py
import logging
from typing import Optional, List
from dataclasses import dataclass
import bcrypt

@dataclass
class User:
    id: int
    username: str
    email: str
    password_hash: str
    is_active: bool = True

class UserService:
    def __init__(self, database):
        self.db = database
        self.logger = logging.getLogger(__name__)

    def create_user(self, username: str, email: str, password: str) -> Optional[User]:
        """Create a new user with hashed password."""
        if not username or not email or not password:
            self.logger.warning("Missing required fields for user creation")
            return None

        password_hash = bcrypt.hashpw(password.encode(), bcrypt.gensalt())

        user = User(
            id=self._generate_id(),
            username=username,
            email=email,
            password_hash=password_hash.decode(),
        )

        self.db.save(user)
        self.logger.info(f"Created user: {username}")
        return user

    def get_users(self, active_only: bool = True) -> List[User]:
        """Retrieve users from database."""
        users = self.db.query(User).all()

        if active_only:
            return [u for u in users if u.is_active]
        return users

    def _generate_id(self) -> int:
        """Generate unique user ID."""
        # Implementation details
        return int(time.time() * 1000)
```

## Review Output

### Summary

This code demonstrates good Python practices with proper type hints, dataclasses, and security considerations. The code is well-structured and follows PEP 8 conventions. Found some minor issues and suggestions for improvement.

### Findings

#### CRITICAL
None

#### HIGH
None

#### MEDIUM

- **user_service.py:35** - Missing import for `time` module
  - Recommendation: Add `import time` at the top of the file with other imports
  ```python
  import logging
  import time  # Add this
  from typing import Optional, List
  ```

- **user_service.py:12** - Database dependency is not typed
  - Recommendation: Add type hint for better IDE support and type checking
  ```python
  def __init__(self, database: DatabaseConnection):  # Or appropriate protocol
      self.db = database
  ```

- **user_service.py:15** - Email validation is missing
  - Recommendation: Validate email format before creating user
  ```python
  import re

  EMAIL_REGEX = re.compile(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$')

  def create_user(self, username: str, email: str, password: str) -> Optional[User]:
      if not EMAIL_REGEX.match(email):
          self.logger.warning(f"Invalid email format: {email}")
          return None
  ```

#### LOW

- **user_service.py:9** - Consider adding `frozen=True` to dataclass
  - Recommendation: If users shouldn't be modified after creation, make it immutable
  ```python
  @dataclass(frozen=True)
  class User:
  ```

- **user_service.py:27** - Log message includes sensitive username
  - Recommendation: Consider logging user ID instead for privacy
  ```python
  self.logger.info(f"Created user with ID: {user.id}")
  ```

- **user_service.py:30-32** - Consider adding docstring with type information
  - Recommendation: Document the `active_only` parameter behavior
  ```python
  def get_users(self, active_only: bool = True) -> List[User]:
      """
      Retrieve users from database.

      Args:
          active_only: If True, return only active users. Defaults to True.

      Returns:
          List of User objects matching the criteria.
      """
  ```

### Positive Observations

- **Excellent use of type hints**: All public methods have proper type annotations
- **Security conscious**: Using `bcrypt` for password hashing (not plain text or weak hashing)
- **Proper logging**: Using `logging` module instead of `print()` statements
- **Dataclass usage**: Appropriate use of `@dataclass` for data container
- **Code organization**: Clear separation between public and private methods (`_generate_id`)
- **Resource injection**: Database is injected, making the class testable
- **Pythonic patterns**: List comprehension for filtering, proper use of Optional
- **Naming conventions**: Follows PEP 8 (snake_case for methods, PascalCase for class)

### Overall Assessment

**APPROVE WITH CHANGES**

The code quality is high with good security practices and Pythonic patterns. Address the MEDIUM issues (missing import, email validation) before merging. The LOW priority suggestions can be addressed in a follow-up PR or ignored if they don't align with project standards.

### Recommended Next Steps

1. Fix the missing `import time` statement
2. Add email validation before user creation
3. Consider adding type hint for the database parameter
4. Run tests to ensure everything works after changes
5. Optional: Address LOW priority suggestions if time permits

### Testing Recommendations

Ensure you have tests covering:
- User creation with valid data
- User creation with invalid/missing data
- Email format validation
- Password hashing (verify bcrypt is used)
- Retrieval of active vs all users
- Edge cases (empty username, duplicate email, etc.)
