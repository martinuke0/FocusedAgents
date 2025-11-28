# Pytest Parametrize Template

Patterns for running the same test with multiple input/output combinations using `@pytest.mark.parametrize`.

## Basic Parametrization

```python
@pytest.mark.parametrize("input,expected", [
    (1, 2),
    (2, 4),
    (3, 6),
    (0, 0),
    (-1, -2),
])
def test_double(input, expected):
    """Test double function with various inputs."""
    assert double(input) == expected
```

## Named Test Cases

```python
@pytest.mark.parametrize("input,expected", [
    (1, 2),
    (2, 4),
    (3, 6),
], ids=["one", "two", "three"])
def test_double_with_ids(input, expected):
    """Test cases have readable names in output."""
    assert double(input) == expected
```

## Multiple Parameters

```python
@pytest.mark.parametrize("base,exponent,expected", [
    (2, 3, 8),
    (3, 2, 9),
    (5, 0, 1),
    (10, 1, 10),
    (2, -1, 0.5),
])
def test_power(base, exponent, expected):
    """Test power function with various combinations."""
    assert power(base, exponent) == expected
```

## Dictionary Parameters

```python
@pytest.mark.parametrize("user_data", [
    {"username": "alice", "age": 30, "email": "alice@example.com"},
    {"username": "bob", "age": 25, "email": "bob@example.com"},
    {"username": "charlie", "age": 35, "email": "charlie@example.com"},
])
def test_user_creation(user_data):
    """Test user creation with different data sets."""
    user = create_user(**user_data)
    assert user.username == user_data["username"]
    assert user.age == user_data["age"]
```

## Testing Error Conditions

```python
@pytest.mark.parametrize("invalid_input,expected_error", [
    (None, ValueError),
    ("", ValueError),
    (-1, ValueError),
    (1.5, TypeError),
], ids=["none", "empty", "negative", "float"])
def test_function_raises_on_invalid_input(invalid_input, expected_error):
    """Test that function raises appropriate errors."""
    with pytest.raises(expected_error):
        function(invalid_input)
```

## Edge Cases and Boundaries

```python
@pytest.mark.parametrize("value,expected", [
    # Boundary values
    (0, "zero"),
    (1, "one"),
    (99, "many"),
    (100, "many"),
    # Edge cases
    (-1, "invalid"),
    (None, "invalid"),
    ("", "invalid"),
], ids=[
    "zero",
    "one",
    "upper_boundary",
    "over_boundary",
    "negative",
    "none",
    "empty_string",
])
def test_categorize_number(value, expected):
    """Test number categorization with boundaries and edge cases."""
    assert categorize(value) == expected
```

## Complex Scenarios

```python
@pytest.mark.parametrize("scenario", [
    {
        "description": "successful login",
        "username": "valid_user",
        "password": "correct_password",
        "expected_result": True,
        "expected_redirect": "/dashboard",
    },
    {
        "description": "invalid username",
        "username": "nonexistent",
        "password": "any_password",
        "expected_result": False,
        "expected_redirect": "/login",
    },
    {
        "description": "wrong password",
        "username": "valid_user",
        "password": "wrong_password",
        "expected_result": False,
        "expected_redirect": "/login",
    },
], ids=lambda s: s["description"])
def test_login_scenarios(scenario):
    """Test various login scenarios."""
    result = login(scenario["username"], scenario["password"])
    assert result.success == scenario["expected_result"]
    assert result.redirect == scenario["expected_redirect"]
```

## Multiple Parametrize Decorators (Cartesian Product)

```python
@pytest.mark.parametrize("input_type", ["json", "xml", "yaml"])
@pytest.mark.parametrize("encoding", ["utf-8", "ascii", "latin-1"])
def test_parser_combinations(input_type, encoding):
    """Test all combinations of input type and encoding.

    This generates 3 x 3 = 9 test cases.
    """
    data = generate_test_data(input_type, encoding)
    result = parse(data, format=input_type, encoding=encoding)
    assert result is not None
```

## Parametrize with Fixtures

```python
@pytest.fixture
def database():
    return create_test_database()


@pytest.mark.parametrize("user_data", [
    {"username": "alice", "email": "alice@example.com"},
    {"username": "bob", "email": "bob@example.com"},
])
def test_user_insertion(database, user_data):
    """Combine parametrize with fixtures."""
    user = database.insert_user(**user_data)
    assert user.username == user_data["username"]
```

## Conditional Parametrization

```python
@pytest.mark.parametrize("algorithm,expected_time", [
    ("quicksort", 0.1),
    ("mergesort", 0.15),
    pytest.param("slowsort", 10.0, marks=pytest.mark.slow),
    pytest.param("superslow", 60.0, marks=pytest.mark.skip(reason="Too slow")),
])
def test_sorting_algorithms(algorithm, expected_time):
    """Test different sorting algorithms."""
    duration = measure_sort(algorithm, test_data)
    assert duration < expected_time
```

## Parametrize with pytest.param

```python
@pytest.mark.parametrize("input,expected", [
    pytest.param(1, 2, id="one"),
    pytest.param(2, 4, id="two"),
    pytest.param(3, 6, id="three"),
    pytest.param(999999, 1999998, id="large_number", marks=pytest.mark.slow),
])
def test_with_param_objects(input, expected):
    """Use pytest.param for more control."""
    assert double(input) == expected
```

## Parametrize for Property Testing

```python
@pytest.mark.parametrize("x,y", [
    (a, b) for a in range(-10, 11) for b in range(-10, 11)
])
def test_addition_commutative(x, y):
    """Test that addition is commutative: x + y == y + x."""
    assert add(x, y) == add(y, x)
```

## String Variations

```python
@pytest.mark.parametrize("input_string,expected", [
    ("hello", "HELLO"),
    ("WORLD", "WORLD"),
    ("MixedCase", "MIXEDCASE"),
    ("123", "123"),
    ("", ""),
    ("  spaces  ", "  SPACES  "),
    ("🚀emoji", "🚀EMOJI"),
], ids=["lowercase", "uppercase", "mixed", "numbers", "empty", "spaces", "emoji"])
def test_uppercase_conversion(input_string, expected):
    """Test string uppercase conversion."""
    assert to_upper(input_string) == expected
```

## Boolean Combinations

```python
@pytest.mark.parametrize("is_admin,is_authenticated,expected_access", [
    (True, True, True),
    (True, False, False),
    (False, True, False),
    (False, False, False),
], ids=[
    "admin_authenticated",
    "admin_not_authenticated",
    "user_authenticated",
    "user_not_authenticated",
])
def test_access_control(is_admin, is_authenticated, expected_access):
    """Test access control with different permission combinations."""
    user = User(is_admin=is_admin, is_authenticated=is_authenticated)
    assert has_access(user) == expected_access
```

## HTTP Status Codes

```python
@pytest.mark.parametrize("status_code,expected_result", [
    (200, "success"),
    (201, "created"),
    (400, "client_error"),
    (401, "unauthorized"),
    (403, "forbidden"),
    (404, "not_found"),
    (500, "server_error"),
    (503, "unavailable"),
], ids=lambda code: f"status_{code[0]}")
def test_status_code_handling(status_code, expected_result):
    """Test HTTP status code interpretation."""
    assert interpret_status(status_code) == expected_result
```

## Data Types

```python
@pytest.mark.parametrize("value", [
    42,
    3.14,
    "string",
    [1, 2, 3],
    {"key": "value"},
    None,
    True,
], ids=type)  # Use type as id function
def test_serialization(value):
    """Test serialization of different data types."""
    serialized = serialize(value)
    deserialized = deserialize(serialized)
    assert deserialized == value
```

## File Formats

```python
@pytest.mark.parametrize("file_extension,parser,content", [
    (".json", parse_json, '{"key": "value"}'),
    (".yaml", parse_yaml, 'key: value'),
    (".xml", parse_xml, '<root><key>value</key></root>'),
    (".csv", parse_csv, 'key,value\\nfield,data'),
], ids=lambda x: f"format{x[0]}")
def test_file_parsers(file_extension, parser, content, tmp_path):
    """Test different file format parsers."""
    file_path = tmp_path / f"test{file_extension}"
    file_path.write_text(content)
    result = parser(file_path)
    assert "key" in result
```

## Indirect Parametrization (Advanced)

```python
@pytest.fixture
def user(request):
    """Fixture that receives parametrized values."""
    user_type = request.param
    if user_type == "admin":
        return User(username="admin", role="admin")
    elif user_type == "regular":
        return User(username="user", role="user")
    else:
        return User(username="guest", role="guest")


@pytest.mark.parametrize("user", ["admin", "regular", "guest"], indirect=True)
def test_user_permissions(user):
    """Test using indirect parametrization."""
    assert user.username is not None
    assert user.role in ["admin", "user", "guest"]
```

## Comprehensive Example

```python
@pytest.mark.parametrize("test_case", [
    {
        "id": "valid_email",
        "input": {"email": "user@example.com", "age": 25},
        "expected_valid": True,
        "expected_errors": [],
    },
    {
        "id": "invalid_email",
        "input": {"email": "not-an-email", "age": 25},
        "expected_valid": False,
        "expected_errors": ["email"],
    },
    {
        "id": "age_too_young",
        "input": {"email": "user@example.com", "age": 15},
        "expected_valid": False,
        "expected_errors": ["age"],
    },
    {
        "id": "multiple_errors",
        "input": {"email": "bad-email", "age": 5},
        "expected_valid": False,
        "expected_errors": ["email", "age"],
    },
    {
        "id": "missing_email",
        "input": {"age": 25},
        "expected_valid": False,
        "expected_errors": ["email"],
    },
], ids=lambda tc: tc["id"])
def test_validation_comprehensive(test_case):
    """Comprehensive validation testing."""
    result = validate_user(test_case["input"])
    assert result.is_valid == test_case["expected_valid"]
    assert set(result.errors) == set(test_case["expected_errors"])
```

## Best Practices

### 1. Use IDs for Readability
```python
# Good
@pytest.mark.parametrize("input,expected", [
    (1, 2),
    (2, 4),
], ids=["single", "double"])

# Bad (no IDs, output is confusing)
@pytest.mark.parametrize("input,expected", [
    (1, 2),
    (2, 4),
])
```

### 2. Group Related Test Cases
```python
# Good: Logical grouping
@pytest.mark.parametrize("valid_input", [
    "user@example.com",
    "test@domain.co.uk",
])
def test_valid_emails(valid_input):
    assert is_valid_email(valid_input)

@pytest.mark.parametrize("invalid_input", [
    "not-an-email",
    "@example.com",
    "user@",
])
def test_invalid_emails(invalid_input):
    assert not is_valid_email(invalid_input)
```

### 3. Don't Over-Parametrize
```python
# Bad: Too many combinations, hard to maintain
@pytest.mark.parametrize("a", range(100))
@pytest.mark.parametrize("b", range(100))
def test_combination(a, b):
    # 10,000 test cases!
    assert function(a, b)

# Good: Test representative cases
@pytest.mark.parametrize("a,b", [
    (0, 0),
    (1, 1),
    (50, 50),
    (99, 99),
])
def test_combination(a, b):
    assert function(a, b)
```

### 4. Use Meaningful Variable Names
```python
# Good
@pytest.mark.parametrize("user_age,is_adult", [
    (17, False),
    (18, True),
])

# Bad
@pytest.mark.parametrize("x,y", [
    (17, False),
    (18, True),
])
```
