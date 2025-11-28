# Example: Integration Test Generation

This example demonstrates generating integration tests for a UserService that interacts with a database.

## Code to Test

```python
# user_service.py
from typing import Optional, List
from sqlalchemy.orm import Session
from models import User
import bcrypt


class UserService:
    """Service for managing users with database persistence."""

    def __init__(self, db_session: Session):
        self.db = db_session

    def create_user(
        self,
        username: str,
        email: str,
        password: str
    ) -> User:
        """Create a new user with hashed password."""
        # Validate input
        if not username or not email or not password:
            raise ValueError("All fields are required")

        # Check for existing user
        existing = self.db.query(User).filter(
            (User.username == username) | (User.email == email)
        ).first()

        if existing:
            raise ValueError("Username or email already exists")

        # Hash password
        password_hash = bcrypt.hashpw(
            password.encode(),
            bcrypt.gensalt()
        ).decode()

        # Create user
        user = User(
            username=username,
            email=email,
            password_hash=password_hash,
            is_active=True
        )

        self.db.add(user)
        self.db.commit()
        self.db.refresh(user)

        return user

    def get_user_by_id(self, user_id: int) -> Optional[User]:
        """Retrieve user by ID."""
        return self.db.query(User).filter(User.id == user_id).first()

    def get_user_by_username(self, username: str) -> Optional[User]:
        """Retrieve user by username."""
        return self.db.query(User).filter(User.username == username).first()

    def authenticate(self, username: str, password: str) -> Optional[User]:
        """Authenticate user by username and password."""
        user = self.get_user_by_username(username)

        if not user:
            return None

        if bcrypt.checkpw(password.encode(), user.password_hash.encode()):
            return user

        return None

    def deactivate_user(self, user_id: int) -> bool:
        """Deactivate a user account."""
        user = self.get_user_by_id(user_id)

        if not user:
            return False

        user.is_active = False
        self.db.commit()

        return True

    def list_active_users(self) -> List[User]:
        """Get all active users."""
        return self.db.query(User).filter(User.is_active == True).all()
```

## Generated Integration Test Suite

### Test Strategy

Integration tests verify:
1. **Database interactions**: CRUD operations with real database
2. **Transaction handling**: Commits and rollbacks work correctly
3. **Data persistence**: Data survives across sessions
4. **Query correctness**: Database queries return expected results
5. **Constraint enforcement**: Unique constraints, foreign keys work
6. **Business logic**: Service methods integrate correctly with database

### Generated Tests

```python
# test_user_service_integration.py
"""Integration tests for UserService with database."""

import pytest
from sqlalchemy import create_engine
from sqlalchemy.orm import sessionmaker, Session
from models import Base, User
from user_service import UserService
import bcrypt


# Database Fixtures
@pytest.fixture(scope="session")
def database_engine():
    """Create in-memory SQLite database for testing."""
    engine = create_engine("sqlite:///:memory:", echo=False)
    Base.metadata.create_all(engine)
    yield engine
    engine.dispose()


@pytest.fixture(scope="function")
def db_session(database_engine):
    """Provide clean database session for each test."""
    # Create connection and transaction
    connection = database_engine.connect()
    transaction = connection.begin()

    # Create session bound to connection
    SessionLocal = sessionmaker(bind=connection)
    session = SessionLocal()

    yield session

    # Rollback and cleanup
    session.close()
    transaction.rollback()
    connection.close()


@pytest.fixture
def user_service(db_session):
    """Provide UserService instance."""
    return UserService(db_session)


@pytest.fixture
def sample_user_data():
    """Provide sample user data for tests."""
    return {
        "username": "testuser",
        "email": "test@example.com",
        "password": "SecurePassword123!"
    }


# Happy Path Integration Tests
def test_create_user_persists_to_database(user_service, sample_user_data):
    """Test that creating user saves to database."""
    # Arrange & Act
    user = user_service.create_user(**sample_user_data)

    # Assert
    assert user.id is not None
    assert user.username == sample_user_data["username"]
    assert user.email == sample_user_data["email"]
    assert user.is_active is True
    assert user.password_hash != sample_user_data["password"]  # Hashed


def test_create_user_password_is_hashed(user_service, sample_user_data):
    """Test that password is properly hashed."""
    # Act
    user = user_service.create_user(**sample_user_data)

    # Assert
    # Password hash should be valid bcrypt hash
    assert user.password_hash.startswith('$2b$')
    assert len(user.password_hash) == 60

    # Original password should authenticate
    assert bcrypt.checkpw(
        sample_user_data["password"].encode(),
        user.password_hash.encode()
    )


def test_get_user_by_id_retrieves_correct_user(user_service, sample_user_data):
    """Test retrieving user by ID."""
    # Arrange
    created_user = user_service.create_user(**sample_user_data)

    # Act
    retrieved_user = user_service.get_user_by_id(created_user.id)

    # Assert
    assert retrieved_user is not None
    assert retrieved_user.id == created_user.id
    assert retrieved_user.username == created_user.username
    assert retrieved_user.email == created_user.email


def test_get_user_by_username_retrieves_correct_user(user_service, sample_user_data):
    """Test retrieving user by username."""
    # Arrange
    user_service.create_user(**sample_user_data)

    # Act
    retrieved_user = user_service.get_user_by_username(sample_user_data["username"])

    # Assert
    assert retrieved_user is not None
    assert retrieved_user.username == sample_user_data["username"]


def test_authenticate_with_correct_credentials_returns_user(
    user_service,
    sample_user_data
):
    """Test authentication with correct password."""
    # Arrange
    user_service.create_user(**sample_user_data)

    # Act
    authenticated_user = user_service.authenticate(
        sample_user_data["username"],
        sample_user_data["password"]
    )

    # Assert
    assert authenticated_user is not None
    assert authenticated_user.username == sample_user_data["username"]


def test_deactivate_user_sets_is_active_to_false(user_service, sample_user_data):
    """Test deactivating user."""
    # Arrange
    user = user_service.create_user(**sample_user_data)
    assert user.is_active is True

    # Act
    result = user_service.deactivate_user(user.id)

    # Assert
    assert result is True

    # Verify in database
    deactivated_user = user_service.get_user_by_id(user.id)
    assert deactivated_user.is_active is False


def test_list_active_users_returns_only_active(user_service):
    """Test listing active users excludes deactivated ones."""
    # Arrange
    user1 = user_service.create_user("user1", "user1@example.com", "pass1")
    user2 = user_service.create_user("user2", "user2@example.com", "pass2")
    user3 = user_service.create_user("user3", "user3@example.com", "pass3")

    user_service.deactivate_user(user2.id)

    # Act
    active_users = user_service.list_active_users()

    # Assert
    assert len(active_users) == 2
    active_usernames = [u.username for u in active_users]
    assert "user1" in active_usernames
    assert "user2" not in active_usernames
    assert "user3" in active_usernames


# Edge Case Integration Tests
def test_get_user_by_id_with_nonexistent_id_returns_none(user_service):
    """Test that querying nonexistent user returns None."""
    # Act
    user = user_service.get_user_by_id(99999)

    # Assert
    assert user is None


def test_get_user_by_username_with_nonexistent_username_returns_none(user_service):
    """Test that querying nonexistent username returns None."""
    # Act
    user = user_service.get_user_by_username("nonexistent")

    # Assert
    assert user is None


def test_authenticate_with_wrong_password_returns_none(user_service, sample_user_data):
    """Test authentication with incorrect password."""
    # Arrange
    user_service.create_user(**sample_user_data)

    # Act
    result = user_service.authenticate(
        sample_user_data["username"],
        "WrongPassword"
    )

    # Assert
    assert result is None


def test_authenticate_with_nonexistent_user_returns_none(user_service):
    """Test authentication with nonexistent user."""
    # Act
    result = user_service.authenticate("nonexistent", "password")

    # Assert
    assert result is None


def test_deactivate_nonexistent_user_returns_false(user_service):
    """Test deactivating nonexistent user."""
    # Act
    result = user_service.deactivate_user(99999)

    # Assert
    assert result is False


# Error Condition Integration Tests
def test_create_user_with_duplicate_username_raises_error(
    user_service,
    sample_user_data
):
    """Test that duplicate username raises ValueError."""
    # Arrange
    user_service.create_user(**sample_user_data)

    # Act & Assert
    with pytest.raises(ValueError, match="Username or email already exists"):
        user_service.create_user(
            sample_user_data["username"],
            "different@example.com",
            "password"
        )


def test_create_user_with_duplicate_email_raises_error(
    user_service,
    sample_user_data
):
    """Test that duplicate email raises ValueError."""
    # Arrange
    user_service.create_user(**sample_user_data)

    # Act & Assert
    with pytest.raises(ValueError, match="Username or email already exists"):
        user_service.create_user(
            "differentuser",
            sample_user_data["email"],
            "password"
        )


def test_create_user_with_empty_fields_raises_error(user_service):
    """Test that empty required fields raise ValueError."""
    # Test empty username
    with pytest.raises(ValueError, match="All fields are required"):
        user_service.create_user("", "email@example.com", "password")

    # Test empty email
    with pytest.raises(ValueError, match="All fields are required"):
        user_service.create_user("username", "", "password")

    # Test empty password
    with pytest.raises(ValueError, match="All fields are required"):
        user_service.create_user("username", "email@example.com", "")


# Multi-User Scenarios
def test_create_multiple_users_all_persist(user_service):
    """Test creating multiple users in same session."""
    # Arrange & Act
    users = []
    for i in range(5):
        user = user_service.create_user(
            f"user{i}",
            f"user{i}@example.com",
            f"password{i}"
        )
        users.append(user)

    # Assert
    all_active = user_service.list_active_users()
    assert len(all_active) == 5

    for i, user in enumerate(users):
        assert user.id is not None
        assert user.username == f"user{i}"


def test_user_operations_across_multiple_sessions(database_engine):
    """Test that user data persists across sessions."""
    # Session 1: Create user
    Session1 = sessionmaker(bind=database_engine)
    session1 = Session1()
    service1 = UserService(session1)

    user = service1.create_user("persistent", "persist@example.com", "password")
    user_id = user.id

    session1.close()

    # Session 2: Retrieve same user
    Session2 = sessionmaker(bind=database_engine)
    session2 = Session2()
    service2 = UserService(session2)

    retrieved_user = service2.get_user_by_id(user_id)

    assert retrieved_user is not None
    assert retrieved_user.username == "persistent"

    session2.close()


# Performance/Load Tests
def test_create_and_query_many_users(user_service):
    """Test system handles multiple users efficiently."""
    # Arrange & Act: Create 100 users
    for i in range(100):
        user_service.create_user(
            f"bulkuser{i}",
            f"bulk{i}@example.com",
            "password"
        )

    # Assert: Can query all users
    all_users = user_service.list_active_users()
    assert len(all_users) == 100

    # Assert: Can find specific user quickly
    found_user = user_service.get_user_by_username("bulkuser50")
    assert found_user is not None
    assert found_user.username == "bulkuser50"


# Transaction and Rollback Tests
def test_failed_creation_does_not_persist(user_service, sample_user_data):
    """Test that failed user creation doesn't leave partial data."""
    # Arrange: Create first user
    user_service.create_user(**sample_user_data)

    # Act: Try to create duplicate (will fail)
    try:
        user_service.create_user(**sample_user_data)
    except ValueError:
        pass

    # Assert: Only one user exists
    all_users = user_service.list_active_users()
    assert len(all_users) == 1


# Realistic Integration Scenarios
def test_complete_user_lifecycle(user_service):
    """Test complete user lifecycle from creation to deactivation."""
    # Step 1: Create user
    user = user_service.create_user(
        "lifecycleuser",
        "lifecycle@example.com",
        "InitialPassword123"
    )
    assert user.is_active is True

    # Step 2: Authenticate successfully
    auth_result = user_service.authenticate("lifecycleuser", "InitialPassword123")
    assert auth_result is not None

    # Step 3: User appears in active list
    active_users = user_service.list_active_users()
    assert any(u.username == "lifecycleuser" for u in active_users)

    # Step 4: Deactivate user
    deactivated = user_service.deactivate_user(user.id)
    assert deactivated is True

    # Step 5: User no longer in active list
    active_users = user_service.list_active_users()
    assert not any(u.username == "lifecycleuser" for u in active_users)

    # Step 6: User still exists but inactive
    inactive_user = user_service.get_user_by_id(user.id)
    assert inactive_user is not None
    assert inactive_user.is_active is False
```

### Coverage Analysis

**Integration coverage: ~95% of service methods**

#### Covered Integration Scenarios:
- **Database persistence**: CRUD operations
- **Transaction handling**: Commits and rollbacks
- **Query operations**: Filters and joins
- **Constraint enforcement**: Unique usernames/emails
- **Password security**: bcrypt integration
- **Multi-user scenarios**: Multiple users in same session
- **Cross-session persistence**: Data survives session close
- **Complete lifecycle**: Creation → use → deactivation

### Running Integration Tests

```bash
# Run integration tests
pytest test_user_service_integration.py -v

# Run with coverage
pytest test_user_service_integration.py --cov=user_service --cov-report=html

# Run specific test
pytest test_user_service_integration.py::test_create_user_persists_to_database -v

# Run slower tests marked as slow
pytest test_user_service_integration.py -m slow
```

### Test Database Strategy

These tests use:
1. **In-memory SQLite**: Fast, isolated testing
2. **Session-scoped engine**: Created once per test session
3. **Function-scoped sessions**: Clean database for each test
4. **Transaction rollback**: Fast cleanup without DELETE statements

### Expected Output

```
test_user_service_integration.py::test_create_user_persists_to_database PASSED
test_user_service_integration.py::test_create_user_password_is_hashed PASSED
test_user_service_integration.py::test_get_user_by_id_retrieves_correct_user PASSED
...
====================== 23 passed in 1.45s =======================

Coverage: 95%
```

## Key Integration Testing Principles

1. **Real database**: Use actual database (even if in-memory)
2. **Transaction isolation**: Each test gets clean slate
3. **End-to-end flows**: Test complete operations
4. **Data verification**: Verify data actually persists
5. **Constraint testing**: Test unique constraints, foreign keys
6. **Performance awareness**: Test with realistic data volumes
7. **Lifecycle testing**: Test creation → use → deletion flows
