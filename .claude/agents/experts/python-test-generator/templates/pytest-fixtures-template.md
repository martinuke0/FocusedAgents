# Pytest Fixtures Template

Patterns for creating reusable test fixtures with different scopes and cleanup strategies.

## Basic Fixture

```python
@pytest.fixture
def sample_user():
    """Provide a sample user for testing."""
    return {
        "id": 1,
        "username": "testuser",
        "email": "test@example.com",
    }
```

## Fixture with Setup and Teardown

```python
@pytest.fixture
def temp_file(tmp_path):
    """Create a temporary file for testing."""
    # Setup
    file_path = tmp_path / "test_file.txt"
    file_path.write_text("initial content")

    # Provide to test
    yield file_path

    # Teardown (runs after test completes)
    if file_path.exists():
        file_path.unlink()
```

## Fixture Scopes

### Function Scope (default)
```python
@pytest.fixture(scope="function")
def database_connection():
    """New connection for each test function."""
    conn = create_connection()
    yield conn
    conn.close()
```

### Class Scope
```python
@pytest.fixture(scope="class")
def expensive_resource():
    """Shared across all tests in a class."""
    resource = create_expensive_resource()
    yield resource
    resource.cleanup()
```

### Module Scope
```python
@pytest.fixture(scope="module")
def database_schema():
    """Set up once per test module."""
    db = create_database()
    db.create_schema()
    yield db
    db.drop_schema()
    db.close()
```

### Session Scope
```python
@pytest.fixture(scope="session")
def application_config():
    """Set up once for entire test session."""
    config = load_config("test_config.yaml")
    yield config
    # Cleanup if needed
```

## Fixture Dependencies

```python
@pytest.fixture
def database():
    """Database connection."""
    return create_database()


@pytest.fixture
def user_repository(database):
    """User repository that depends on database."""
    return UserRepository(database)


@pytest.fixture
def user_service(user_repository):
    """User service that depends on repository."""
    return UserService(user_repository)


def test_user_creation(user_service):
    """Test using the complete fixture chain."""
    user = user_service.create_user("test", "test@example.com")
    assert user.username == "test"
```

## Parametrized Fixtures

```python
@pytest.fixture(params=[
    {"name": "Alice", "age": 30},
    {"name": "Bob", "age": 25},
    {"name": "Charlie", "age": 35},
])
def user_data(request):
    """Provide multiple user data sets."""
    return request.param


def test_user_creation(user_data):
    """Test runs three times, once for each parameter."""
    user = create_user(**user_data)
    assert user.name == user_data["name"]
    assert user.age == user_data["age"]
```

## Autouse Fixtures

```python
@pytest.fixture(autouse=True)
def reset_database():
    """Automatically reset database before each test."""
    database.reset()
    yield
    # No need to explicitly use this fixture in tests


def test_something():
    """Database is automatically reset before this test."""
    # Test code here
```

## Factory Fixtures

```python
@pytest.fixture
def user_factory():
    """Factory for creating test users."""
    created_users = []

    def _create_user(username="default", email=None):
        if email is None:
            email = f"{username}@example.com"
        user = User(username=username, email=email)
        created_users.append(user)
        return user

    yield _create_user

    # Cleanup all created users
    for user in created_users:
        user.delete()


def test_multiple_users(user_factory):
    """Create multiple users in a single test."""
    user1 = user_factory("alice")
    user2 = user_factory("bob", "bob@custom.com")
    assert user1.username == "alice"
    assert user2.email == "bob@custom.com"
```

## Database Fixtures

```python
@pytest.fixture(scope="session")
def database_engine():
    """Create database engine once per session."""
    engine = create_engine("sqlite:///:memory:")
    yield engine
    engine.dispose()


@pytest.fixture(scope="function")
def database_session(database_engine):
    """Provide clean database session for each test."""
    connection = database_engine.connect()
    transaction = connection.begin()
    session = Session(bind=connection)

    yield session

    session.close()
    transaction.rollback()
    connection.close()


@pytest.fixture
def sample_data(database_session):
    """Insert sample data into database."""
    user1 = User(username="alice")
    user2 = User(username="bob")
    database_session.add_all([user1, user2])
    database_session.commit()
    return [user1, user2]


def test_user_query(database_session, sample_data):
    """Test with database and sample data."""
    users = database_session.query(User).all()
    assert len(users) == 2
```

## Mock Fixtures

```python
@pytest.fixture
def mock_api_client(mocker):
    """Mock API client for testing."""
    mock = mocker.Mock()
    mock.get.return_value = {"status": "success", "data": []}
    mock.post.return_value = {"status": "created", "id": 123}
    return mock


@pytest.fixture
def mock_database(mocker):
    """Mock database operations."""
    mock_db = mocker.Mock()
    mock_db.query.return_value.all.return_value = []
    mock_db.query.return_value.first.return_value = None
    return mock_db


def test_service_with_mocks(mock_api_client, mock_database):
    """Test service with mocked dependencies."""
    service = MyService(api_client=mock_api_client, db=mock_database)
    result = service.fetch_data()
    mock_api_client.get.assert_called_once()
```

## Async Fixtures

```python
@pytest.fixture
async def async_database():
    """Async database connection."""
    db = await create_async_database()
    yield db
    await db.close()


@pytest.fixture
async def async_client():
    """Async HTTP client."""
    async with httpx.AsyncClient() as client:
        yield client


@pytest.mark.asyncio
async def test_async_operation(async_database):
    """Test with async fixture."""
    result = await async_database.query("SELECT * FROM users")
    assert result is not None
```

## Temporary File/Directory Fixtures

```python
@pytest.fixture
def temp_directory(tmp_path):
    """Create temporary directory structure."""
    (tmp_path / "subdir1").mkdir()
    (tmp_path / "subdir2").mkdir()
    (tmp_path / "file.txt").write_text("content")
    return tmp_path


@pytest.fixture
def config_file(tmp_path):
    """Create temporary config file."""
    config_path = tmp_path / "config.yaml"
    config_content = """
    database:
      host: localhost
      port: 5432
    """
    config_path.write_text(config_content)
    return config_path
```

## Environment Variable Fixtures

```python
@pytest.fixture
def mock_environment(monkeypatch):
    """Set up mock environment variables."""
    monkeypatch.setenv("API_KEY", "test_key_123")
    monkeypatch.setenv("DATABASE_URL", "sqlite:///:memory:")
    monkeypatch.setenv("DEBUG", "true")


def test_with_environment(mock_environment):
    """Test with mocked environment."""
    import os
    assert os.environ["API_KEY"] == "test_key_123"
```

## Fixture Best Practices

### 1. Single Responsibility
```python
# Good: Each fixture has one job
@pytest.fixture
def database():
    return create_database()

@pytest.fixture
def sample_users():
    return [User("alice"), User("bob")]

# Bad: Fixture does too much
@pytest.fixture
def everything():
    db = create_database()
    users = create_users()
    api = create_api()
    return db, users, api  # Confusing
```

### 2. Clear Names
```python
# Good: Descriptive names
@pytest.fixture
def authenticated_user():
    return User(username="test", is_authenticated=True)

# Bad: Vague names
@pytest.fixture
def data():
    return User(username="test", is_authenticated=True)
```

### 3. Appropriate Scope
```python
# Good: Use session scope for expensive operations
@pytest.fixture(scope="session")
def ml_model():
    return load_expensive_model()

# Bad: Loading expensive model for every test
@pytest.fixture
def ml_model():
    return load_expensive_model()  # Too slow!
```

### 4. Cleanup
```python
# Good: Cleanup with yield
@pytest.fixture
def resource():
    r = acquire_resource()
    yield r
    r.cleanup()

# Also good: Context manager
@pytest.fixture
def resource():
    with resource_context() as r:
        yield r
```

## Common Fixture Patterns

### Realistic Fake Data
```python
from faker import Faker

@pytest.fixture
def fake():
    """Provide Faker instance for generating test data."""
    return Faker()

def test_user_creation(fake):
    user = create_user(
        username=fake.user_name(),
        email=fake.email(),
        phone=fake.phone_number(),
    )
    assert user.email  # Has realistic email
```

### Time Mocking
```python
from freezegun import freeze_time

@pytest.fixture
def frozen_time():
    """Freeze time for testing."""
    with freeze_time("2024-01-01 12:00:00"):
        yield

def test_time_dependent_logic(frozen_time):
    # Time is frozen at 2024-01-01 12:00:00
    result = get_current_date()
    assert result == date(2024, 1, 1)
```

### Fixture Composition
```python
@pytest.fixture
def base_user():
    return {"username": "base"}

@pytest.fixture
def admin_user(base_user):
    return {**base_user, "role": "admin"}

@pytest.fixture
def authenticated_admin(admin_user):
    return {**admin_user, "authenticated": True}

def test_admin_access(authenticated_admin):
    assert authenticated_admin["role"] == "admin"
    assert authenticated_admin["authenticated"] is True
```
