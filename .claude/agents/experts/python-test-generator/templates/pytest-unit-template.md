# Pytest Unit Test Template

Basic unit test pattern for testing individual functions/methods in isolation.

## Template Structure

```python
"""Tests for [module_name] module."""

import pytest
from unittest.mock import Mock, patch
from [module_path] import [function_or_class_to_test]


# Fixtures
@pytest.fixture
def sample_input():
    """Provide sample input data for tests."""
    return {
        "key": "value",
        "number": 42,
    }


@pytest.fixture
def mock_dependency(mocker):
    """Mock external dependency."""
    mock = mocker.Mock()
    mock.method.return_value = "mocked_result"
    return mock


# Happy Path Tests
def test_function_with_valid_input_returns_expected_output(sample_input):
    """Test that function works correctly with valid input."""
    # Arrange
    expected = "expected_value"

    # Act
    result = function_to_test(sample_input)

    # Assert
    assert result == expected


def test_function_handles_typical_use_case():
    """Test the most common usage pattern."""
    # Arrange
    input_data = "typical_input"

    # Act
    result = function_to_test(input_data)

    # Assert
    assert result is not None
    assert isinstance(result, ExpectedType)


# Edge Case Tests
def test_function_with_empty_input_returns_default():
    """Test function behavior with empty input."""
    # Arrange
    empty_input = ""

    # Act
    result = function_to_test(empty_input)

    # Assert
    assert result == DEFAULT_VALUE


def test_function_with_none_input_raises_value_error():
    """Test that None input is rejected."""
    # Arrange
    none_input = None

    # Act & Assert
    with pytest.raises(ValueError, match="Input cannot be None"):
        function_to_test(none_input)


def test_function_with_boundary_values():
    """Test function with minimum and maximum valid values."""
    # Test minimum
    result_min = function_to_test(MIN_VALUE)
    assert result_min == expected_min

    # Test maximum
    result_max = function_to_test(MAX_VALUE)
    assert result_max == expected_max


# Error Condition Tests
def test_function_with_invalid_type_raises_type_error():
    """Test that invalid input type raises TypeError."""
    # Arrange
    invalid_input = 12345  # When string is expected

    # Act & Assert
    with pytest.raises(TypeError):
        function_to_test(invalid_input)


def test_function_with_invalid_value_raises_value_error():
    """Test that invalid input value raises ValueError."""
    # Arrange
    invalid_value = "invalid"

    # Act & Assert
    with pytest.raises(ValueError, match="Invalid value"):
        function_to_test(invalid_value)


# Mocking External Dependencies
def test_function_calls_external_service(mocker):
    """Test that function correctly interacts with external service."""
    # Arrange
    mock_service = mocker.patch('module.external_service')
    mock_service.return_value = "service_response"

    # Act
    result = function_to_test("input")

    # Assert
    mock_service.assert_called_once_with("expected_arg")
    assert result == "processed_service_response"


def test_function_handles_external_service_failure(mocker):
    """Test error handling when external service fails."""
    # Arrange
    mock_service = mocker.patch('module.external_service')
    mock_service.side_effect = ConnectionError("Service unavailable")

    # Act & Assert
    with pytest.raises(ConnectionError):
        function_to_test("input")


# Class Method Tests (if testing a class)
class TestMyClass:
    """Tests for MyClass."""

    @pytest.fixture
    def instance(self):
        """Create instance for testing."""
        return MyClass(param1="value1", param2="value2")

    def test_init_creates_instance_with_correct_attributes(self):
        """Test that __init__ sets attributes correctly."""
        # Act
        obj = MyClass(param1="a", param2="b")

        # Assert
        assert obj.param1 == "a"
        assert obj.param2 == "b"

    def test_method_returns_expected_value(self, instance):
        """Test that method works correctly."""
        # Act
        result = instance.method("input")

        # Assert
        assert result == "expected_output"

    def test_method_modifies_state_correctly(self, instance):
        """Test that method changes object state as expected."""
        # Arrange
        initial_state = instance.state

        # Act
        instance.method_that_modifies_state()

        # Assert
        assert instance.state != initial_state
        assert instance.state == "expected_new_state"
```

## Key Patterns

### 1. Arrange-Act-Assert (AAA)
```python
def test_example():
    # Arrange: Set up test data and conditions
    input_data = create_test_data()

    # Act: Execute the code under test
    result = function_under_test(input_data)

    # Assert: Verify the outcome
    assert result == expected_value
```

### 2. Testing Exceptions
```python
def test_function_raises_exception():
    with pytest.raises(ExceptionType, match="error message pattern"):
        function_that_raises(bad_input)
```

### 3. Using Fixtures
```python
@pytest.fixture
def common_test_data():
    return {"shared": "data"}

def test_with_fixture(common_test_data):
    result = function(common_test_data)
    assert result is not None
```

### 4. Mocking with pytest-mock
```python
def test_with_mock(mocker):
    mock_obj = mocker.patch('module.dependency')
    mock_obj.return_value = "mocked"

    result = function_using_dependency()

    mock_obj.assert_called_once()
    assert result == "expected"
```

### 5. Parametrized Tests (for multiple similar cases)
```python
@pytest.mark.parametrize("input,expected", [
    ("a", 1),
    ("b", 2),
    ("c", 3),
])
def test_multiple_cases(input, expected):
    assert function(input) == expected
```

## Coverage Checklist

- [ ] Happy path tested
- [ ] Edge cases tested (empty, None, boundaries)
- [ ] Error conditions tested (invalid types, invalid values)
- [ ] External dependencies mocked
- [ ] Side effects verified
- [ ] Return types checked
- [ ] Exception types and messages verified

## Tips

1. **One assertion per test** (or closely related assertions)
2. **Descriptive test names** that explain the scenario and expected outcome
3. **Independent tests** that can run in any order
4. **Use fixtures** for common setup/teardown
5. **Mock external dependencies** (database, network, filesystem)
6. **Test behavior, not implementation** details
