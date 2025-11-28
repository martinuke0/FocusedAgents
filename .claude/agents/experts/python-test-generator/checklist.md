# Python Test Generation Checklist

Use this checklist to ensure comprehensive test coverage when generating tests.

## Test Organization

- [ ] Test file named `test_*.py` or `*_test.py` (pytest discovery)
- [ ] Test file location mirrors source structure (e.g., `src/module.py` → `tests/test_module.py`)
- [ ] Test classes named `Test*` (if using classes)
- [ ] Test functions named `test_*`
- [ ] Related tests grouped in classes or modules
- [ ] Clear separation between unit, integration, and e2e tests

## Test Coverage Categories

### Happy Path Tests
- [ ] Main functionality works with valid inputs
- [ ] Function returns expected type and value
- [ ] Object state is correct after operations
- [ ] Side effects occur as expected

### Edge Cases
- [ ] Empty inputs (empty list, empty string, empty dict)
- [ ] None/null values
- [ ] Boundary values (min/max integers, float precision)
- [ ] Single-item collections
- [ ] Large inputs (stress testing)
- [ ] Special characters in strings
- [ ] Unicode handling

### Error Conditions
- [ ] Invalid input types raise appropriate exceptions
- [ ] Invalid input values raise appropriate exceptions
- [ ] Missing required parameters raise exceptions
- [ ] Exception messages are descriptive
- [ ] Exception types are correct
- [ ] Error handling doesn't swallow important errors

### State and Side Effects
- [ ] Database operations (create, read, update, delete)
- [ ] File system operations
- [ ] Network calls
- [ ] Environment variables
- [ ] Global state changes
- [ ] Cache invalidation
- [ ] Logging calls

## Test Structure (AAA Pattern)

- [ ] **Arrange**: Setup is clear and minimal
- [ ] **Act**: Operation under test is obvious
- [ ] **Assert**: Assertions are specific and complete
- [ ] Comments used to separate AAA sections if needed

## Test Quality

### Independence
- [ ] Tests can run in any order
- [ ] No shared mutable state between tests
- [ ] Each test sets up its own data
- [ ] Tests don't depend on external state
- [ ] Database/files cleaned up after each test

### Clarity
- [ ] Test names describe what is being tested
- [ ] Test names include expected outcome
- [ ] One logical assertion per test (or closely related)
- [ ] Test intent is obvious without reading implementation
- [ ] Minimal cognitive load

### Completeness
- [ ] All public methods/functions tested
- [ ] All code paths covered (if statements, loops)
- [ ] All exception paths tested
- [ ] Integration points tested
- [ ] Configuration variations tested

## pytest Features

### Fixtures
- [ ] Fixtures defined for common test data
- [ ] Fixtures have appropriate scope (function, class, module, session)
- [ ] Fixtures use `yield` for cleanup when needed
- [ ] Fixture dependencies are minimal
- [ ] Fixtures are reusable across tests

### Parametrization
- [ ] `@pytest.mark.parametrize` used for multiple similar tests
- [ ] Parameter names are descriptive
- [ ] Parameter values cover important scenarios
- [ ] Edge cases included in parameters
- [ ] Test IDs used for clarity (ids=["case1", "case2"])

### Markers
- [ ] Slow tests marked with `@pytest.mark.slow`
- [ ] Integration tests marked appropriately
- [ ] Skip/xfail used with reasons
- [ ] Custom markers defined in pytest.ini if needed

### Mocking
- [ ] External dependencies mocked (database, network, filesystem)
- [ ] Mocks verify calls (assert_called_once, assert_called_with)
- [ ] Mocks return appropriate data for test scenario
- [ ] Mocking doesn't make tests brittle
- [ ] Using mocker fixture from pytest-mock (not unittest.mock directly)

## Async Testing

- [ ] Async tests marked with `@pytest.mark.asyncio`
- [ ] Async fixtures use `async def` and `await`
- [ ] Concurrent operations tested
- [ ] Race conditions considered
- [ ] Async context managers tested
- [ ] Event loop properly managed

## Test Data

- [ ] Test data is realistic but minimal
- [ ] No production data in tests
- [ ] No hardcoded secrets or credentials
- [ ] Faker library used for realistic fake data if needed
- [ ] Test data documented or self-explanatory

## Assertions

- [ ] Assertions are specific (not just `assert result`)
- [ ] Error messages added for complex assertions
- [ ] Using pytest assertions (not unittest assert methods)
- [ ] Collection assertions use `in`, `not in`, etc.
- [ ] Floating point comparisons use `pytest.approx()`
- [ ] Exception assertions use `pytest.raises()` with `match` parameter

## External Dependencies

### Database
- [ ] Database mocked for unit tests
- [ ] Real database used for integration tests (with fixtures)
- [ ] Test database cleaned up after each test
- [ ] Transactions rolled back if appropriate
- [ ] Database fixtures provide clean state

### Filesystem
- [ ] File operations use temp directories (`tmp_path` fixture)
- [ ] Files cleaned up after tests
- [ ] Path handling uses `pathlib.Path`
- [ ] File contents validated

### Network/API
- [ ] HTTP requests mocked (using `responses` or `httpretty`)
- [ ] API responses realistic
- [ ] Error responses tested (404, 500, timeouts)
- [ ] Retry logic tested

### Time
- [ ] Time-dependent code uses `freezegun` or similar
- [ ] Timezone handling tested
- [ ] Date boundaries tested

## Performance Considerations

- [ ] Tests run quickly (unit tests < 1s, integration < 10s)
- [ ] No unnecessary setup/teardown
- [ ] Fixtures shared appropriately (function vs. session scope)
- [ ] Large data generation minimized
- [ ] Database queries optimized

## Documentation

- [ ] Complex test logic has comments
- [ ] Fixtures have docstrings explaining purpose
- [ ] Non-obvious test data explained
- [ ] Test file has module docstring if needed

## Common Patterns Implemented

### Testing Exceptions
```python
- [ ] with pytest.raises(ExceptionType):
- [ ] with pytest.raises(ExceptionType, match="error message"):
```

### Testing Side Effects
```python
- [ ] Mock calls verified (assert_called_once)
- [ ] Mock call arguments checked (assert_called_with)
- [ ] Mock call count checked
```

### Testing Async Code
```python
- [ ] @pytest.mark.asyncio decorator used
- [ ] await used on async functions
- [ ] Async fixtures defined with async def
```

### Property-Based Testing
```python
- [ ] hypothesis used for complex scenarios
- [ ] Properties defined that should always hold
- [ ] Edge cases automatically discovered
```

## Coverage Metrics

- [ ] Line coverage > 90% for critical paths
- [ ] Branch coverage checked (all if/else paths)
- [ ] No unreachable code
- [ ] Dead code identified

## Integration with CI/CD

- [ ] Tests can run in CI environment
- [ ] No dependencies on local environment
- [ ] Tests produce machine-readable output
- [ ] Coverage reports generated
- [ ] Failed tests provide useful debugging info

## Code Quality

- [ ] Tests follow same style as production code
- [ ] Tests are type-hinted (if production code is)
- [ ] No test code duplication (use fixtures/helpers)
- [ ] Tests pass linting (flake8, pylint)
- [ ] Tests formatted consistently (black)

## Special Cases

### Testing Private Methods
- [ ] Focus on public API
- [ ] Private methods tested through public interface
- [ ] Only test private methods if truly necessary

### Testing Class Inheritance
- [ ] Parent class functionality tested
- [ ] Child class overrides tested
- [ ] Multiple inheritance tested if applicable

### Testing Decorators
- [ ] Decorator behavior tested
- [ ] Decorated function behavior tested
- [ ] Decorator parameters tested

### Testing Context Managers
- [ ] `__enter__` tested
- [ ] `__exit__` tested
- [ ] Exception handling in context manager tested
- [ ] Resource cleanup verified

### Testing Generators
- [ ] Generator produces correct sequence
- [ ] Generator handles StopIteration
- [ ] Generator state tested
- [ ] Generator expressions vs. functions

## Antipatterns to Avoid

- [ ] No sleep() calls in tests (use mocking/freezegun)
- [ ] No test interdependencies
- [ ] No print statements (use logging if needed)
- [ ] No hardcoded ports or URLs
- [ ] No reliance on test execution order
- [ ] No catching all exceptions in tests
- [ ] No testing implementation details
- [ ] No over-mocking (test becomes meaningless)

## Final Checklist

- [ ] All tests pass locally
- [ ] Coverage report generated and reviewed
- [ ] No skipped tests without good reason
- [ ] No xfail tests without ticket reference
- [ ] Tests are maintainable and readable
- [ ] Tests provide value (not just coverage)
- [ ] Tests will catch regressions
- [ ] Tests document expected behavior
