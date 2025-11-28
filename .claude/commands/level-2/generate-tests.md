# Generate Tests Command

Generate comprehensive test suites using specialized test generation sub-agent.

## Purpose

Delegate test generation to focused sub-agent, keeping primary agent lean while getting complete test coverage.

## Usage

```bash
/generate-tests <file-or-function>
```

## Examples

```bash
/generate-tests src/api/users.py
/generate-tests src/auth/oauth.py:authenticate_user
/generate-tests src/utils/
```

## Output

```markdown
## Test Generation Summary

### Test File
tests/test_users.py

### Coverage Strategy
- Happy paths: 8 tests
- Edge cases: 12 tests
- Error conditions: 6 tests
- Total: 26 tests

### Generated Tests
```python
import pytest
from src.api.users import create_user, get_user, update_user

@pytest.fixture
def sample_user():
    return {"id": 1, "name": "Alice", "email": "alice@example.com"}

def test_create_user_with_valid_data_returns_user_object(sample_user):
    result = create_user(sample_user)
    assert result.id == 1
    assert result.name == "Alice"

def test_create_user_with_missing_email_raises_value_error():
    with pytest.raises(ValueError, match="Email required"):
        create_user({"name": "Bob"})

# ... 24 more tests
```

### Running Tests
```bash
pytest tests/test_users.py
pytest tests/test_users.py::test_create_user_with_valid_data
pytest --cov=src/api tests/
```

### Estimated Coverage
~92% line coverage expected
```

## Context Impact

```
Without delegation: 30-50K tokens in primary
With delegation: 4-6K tokens in primary (summary only)
Savings: 26-44K tokens
```

## Test Generation Includes

- Test fixtures
- Parametrized tests
- Edge cases
- Error conditions
- Mocking strategies
- Happy paths

## Best Practices

### DO:
- ✅ Generate tests for new features
- ✅ Improve coverage for untested code
- ✅ Use TDD (generate tests first)
- ✅ Review and adjust generated tests

### DON'T:
- ❌ Blindly commit generated tests
- ❌ Skip running generated tests
- ❌ Generate for trivial code
- ❌ Replace manual test design entirely

## TDD Workflow

```bash
# 1. Write specification
# 2. Generate tests
/generate-tests spec.md

# 3. Run tests (should fail)
pytest

# 4. Implement feature
# ... code ...

# 5. Run tests (should pass)
pytest
```

## Related Commands

- `/delegate` - Generic delegation
- `/review-code` - Code review
- `/expert` - Deep specialist (Level 4)

## See Also

- [Sub-Agents](../../agents/sub-agents/)
- [Level 2 Guide](../../docs/level-2-intermediate.md)
