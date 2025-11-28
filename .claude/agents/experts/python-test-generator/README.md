# Python Test Generator Expert Agent

A specialized agent for generating comprehensive pytest-based test suites for Python code.

## Purpose

This agent generates high-quality Python tests with expertise in:
- pytest framework and best practices
- Test coverage strategies (happy paths, edge cases, errors)
- Fixture design and dependency injection
- Parametrized testing for multiple scenarios
- Mocking external dependencies
- Async/await test patterns

## When to Use

Use this agent when:
- Starting a new Python project (generate tests first - TDD)
- Adding tests to existing untested code
- Improving test coverage for production code
- Learning pytest patterns and best practices
- Need comprehensive test suites quickly
- Implementing test-driven development

## How to Invoke

### Via Claude Code
```
Generate tests for: [file path or code snippet]
```

### With Specific Requirements
```
Generate pytest tests for src/users.py focusing on:
- Edge cases for empty inputs
- Error handling for invalid data
- Mocking the database calls
```

### Test-Driven Development
```
Generate tests for this function specification:
Function: calculate_discount(price, user_type)
Returns: discounted price based on user type
Rules: VIP users get 20%, regular users 10%, guests 0%
```

## Input Requirements

The agent can generate tests for:
- Python functions, methods, or classes
- Entire modules
- Code specifications (for TDD)
- Existing untested code

Provide either:
- File paths to the code
- Code snippets directly
- Functional specifications

## Output Format

```markdown
## Test Strategy
Brief overview of testing approach

## Test File Structure
```python
# Complete, runnable pytest test file
```

## Coverage Analysis
- Happy paths covered
- Edge cases covered
- Error conditions covered
- Estimated coverage percentage

## Fixtures and Mocks
Explanation of test fixtures and mocking strategy

## Running the Tests
bash commands to execute tests

## Additional Recommendations
Suggestions for test organization or additional test files
```

## Supporting Files

### templates/
Ready-to-use pytest templates:
- **pytest-unit-template.md**: Basic unit test pattern
- **pytest-fixtures-template.md**: Fixture design patterns
- **pytest-parametrize-template.md**: Parametrized test patterns
- **pytest-async-template.md**: Async/await test patterns

### examples/
- **unit-test-generation-example.md**: Sample unit test generation
- **integration-test-example.md**: Sample integration test generation

### checklist.md
Comprehensive checklist ensuring:
- All code paths are tested
- Edge cases are covered
- Error conditions are handled
- Tests follow best practices

## Composition Suggestions

### Test-Driven Development
```
1. Write specification
2. python-test-generator → Generate failing tests
3. Implement code to pass tests
4. python-reviewer → Review implementation
```

### Improve Coverage
```
1. Identify untested code
2. python-test-generator → Generate tests
3. Run tests and check coverage
4. Iterate on edge cases
```

### Quality Pipeline
```
1. python-test-generator → Generate comprehensive tests
2. Run tests (should pass)
3. python-reviewer → Review both code and tests
4. python-security-auditor → Security check
```

## What This Agent Does NOT Do

- **Does not** run tests (only generates them)
- **Does not** measure coverage (generates tests that aim for high coverage)
- **Does not** review or refactor implementation code
- **Does not** fix bugs (generates tests that may expose them)

## Best Practices

1. **Provide context**: Mention what the code does and any special requirements
2. **Specify focus areas**: "Focus on error handling" or "Test async operations"
3. **Include dependencies**: Mention external services that need mocking
4. **Review generated tests**: Ensure they match your project's testing style
5. **Run and iterate**: Generated tests may need minor adjustments

## Example Usage

### Basic Test Generation
```
User: Generate tests for this function:
      def calculate_total(items, tax_rate=0.1):
          subtotal = sum(item['price'] for item in items)
          return subtotal * (1 + tax_rate)

Agent: [Generates comprehensive test suite with fixtures, parametrization, edge cases]
```

### TDD Workflow
```
User: I need to implement a user registration function. Generate tests first.
      Requirements:
      - Validate email format
      - Hash password with bcrypt
      - Check for duplicate usernames
      - Return User object on success

Agent: [Generates failing tests based on specification]

User: [Implements function to pass tests]
```

### Improving Coverage
```
User: Generate additional tests for src/api/auth.py focusing on:
      - Invalid token formats
      - Expired tokens
      - Missing authorization headers

Agent: [Generates targeted tests for specified scenarios]
```

## Configuration

Generated tests assume:
- pytest framework (pytest >= 7.0)
- pytest-cov for coverage
- pytest-mock for mocking (mocker fixture)
- pytest-asyncio for async tests
- Python 3.8+

Mention your specific setup if different.

## Running Generated Tests

```bash
# Run all tests
pytest

# Run with coverage
pytest --cov=src --cov-report=html

# Run specific test file
pytest tests/test_module.py

# Run tests matching pattern
pytest -k "test_user"

# Verbose output
pytest -v
```

## Related Agents

- `python-reviewer`: Review both implementation and generated tests
- `python-security-auditor`: Ensure tests cover security scenarios
- `python-performance-optimizer`: Generate performance benchmarks
- `generic-test-generator`: Fallback for non-Python code
- `objective-critic`: Review testing strategy and approach

## Source

Based on expert agent principles from: https://martinuke0.github.io/posts/expert-agents/
