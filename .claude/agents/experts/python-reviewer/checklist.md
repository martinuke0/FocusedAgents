# Python Code Review Checklist

Use this checklist when reviewing Python code to ensure comprehensive coverage of all quality aspects.

## PEP 8 Style Compliance

- [ ] Line length ≤ 88 characters (Black standard) or ≤ 79 (PEP 8 strict)
- [ ] Proper indentation using 4 spaces (no tabs)
- [ ] Correct naming conventions:
  - `snake_case` for functions and variables
  - `PascalCase` for classes
  - `UPPER_CASE` for constants
  - `_leading_underscore` for private/internal
- [ ] Two blank lines between top-level definitions
- [ ] One blank line between method definitions
- [ ] Proper whitespace around operators and after commas
- [ ] No trailing whitespace
- [ ] Imports organized: stdlib, third-party, local (separated by blank lines)
- [ ] No wildcard imports (`from x import *`)
- [ ] Module-level dunders after docstring, before imports

## Type Safety

- [ ] Type hints on all public function parameters
- [ ] Type hints on all public function return values
- [ ] Use of `Optional[T]` for nullable values
- [ ] Use of `Union[X, Y]` or `X | Y` (Python 3.10+) for multiple types
- [ ] Generic types (`list[str]`, `dict[str, int]`) instead of bare `list`, `dict`
- [ ] Avoid using `Any` unless absolutely necessary
- [ ] Use `TypeVar` for generic functions
- [ ] Use `Protocol` for structural subtyping
- [ ] Type hints are forward-compatible (strings for forward references)
- [ ] Complex types use `typing` module constructs appropriately

## Code Quality

- [ ] Functions are focused and single-purpose (SRP)
- [ ] Functions are not too long (< 50 lines ideally, < 100 max)
- [ ] No code duplication (DRY principle)
- [ ] Meaningful variable and function names (self-documenting)
- [ ] No commented-out code blocks
- [ ] No `print()` statements (use `logging` module)
- [ ] Proper exception handling (no bare `except:`)
- [ ] Resources use context managers (`with` statements)
- [ ] No mutable default arguments (e.g., `def func(x=[]):`)
- [ ] Constants defined at module level, not magic numbers
- [ ] Complex conditions extracted to well-named variables/functions

## Pythonic Idioms

- [ ] List/dict/set comprehensions used appropriately
- [ ] Generator expressions for large datasets
- [ ] `enumerate()` instead of manual counters
- [ ] `zip()` for parallel iteration
- [ ] `itertools` for complex iterations
- [ ] `@property` decorators for computed attributes
- [ ] `@dataclass` for data containers (Python 3.7+)
- [ ] f-strings for string formatting (not `%` or `.format()`)
- [ ] Walrus operator `:=` where it improves readability (Python 3.8+)
- [ ] `match` statements for complex conditionals (Python 3.10+)
- [ ] `pathlib` instead of `os.path`
- [ ] Context managers for resource management
- [ ] Decorators for cross-cutting concerns

## Performance

- [ ] Efficient data structures chosen (list vs set vs dict)
- [ ] No unnecessary `list()` conversions of iterables
- [ ] Generators used for large datasets
- [ ] Expensive operations not repeated in loops
- [ ] `__slots__` used for memory optimization (when appropriate)
- [ ] `@lru_cache` or `@cache` for expensive pure functions
- [ ] `@cached_property` for expensive computed properties
- [ ] String concatenation uses `''.join()` for large lists
- [ ] Sets used for membership testing (not lists)
- [ ] Dict/set lookups preferred over list iteration

## Asyncio (if applicable)

- [ ] `async`/`await` syntax used correctly
- [ ] `asyncio.gather()` for concurrent operations
- [ ] No blocking I/O in async functions
- [ ] Proper use of `asyncio.create_task()`
- [ ] Context variables for async-safe state
- [ ] No mixing of sync and async code without proper handling

## Security

- [ ] No hardcoded credentials or API keys
- [ ] Environment variables or secrets manager for sensitive data
- [ ] SQL queries use parameterization (no string concatenation)
- [ ] User input is validated and sanitized
- [ ] File operations validate paths (prevent traversal attacks)
- [ ] `secrets` module used for cryptographic randomness (not `random`)
- [ ] No use of `eval()`, `exec()`, or `pickle.loads()` on untrusted data
- [ ] Proper handling of sensitive data in logs and errors
- [ ] Dependencies pinned to specific versions
- [ ] No XML external entity (XXE) vulnerabilities
- [ ] HTTPS enforced for external requests

## Error Handling

- [ ] Specific exceptions caught (not bare `except:`)
- [ ] Custom exceptions defined for domain errors
- [ ] Error messages are descriptive and actionable
- [ ] Resources cleaned up in `finally` blocks or context managers
- [ ] No silent exception swallowing
- [ ] Exceptions not used for flow control
- [ ] `raise ... from` used to preserve exception context
- [ ] Errors logged before re-raising

## Documentation

- [ ] Module-level docstrings present
- [ ] Class docstrings present
- [ ] Docstrings for all public functions/methods
- [ ] Docstrings follow consistent format (Google, NumPy, or Sphinx style)
- [ ] Complex logic has explanatory inline comments
- [ ] TODO/FIXME comments include context and owner
- [ ] API documentation generated (if library)

## Testing Considerations

- [ ] Critical business logic has test coverage
- [ ] Edge cases are testable
- [ ] Error conditions are testable
- [ ] Dependencies are injectable (not hardcoded)
- [ ] Functions are pure where possible (easier to test)
- [ ] No direct database/network calls (use dependency injection)
- [ ] Test fixtures are available or easy to create

## Imports and Dependencies

- [ ] Imports organized: stdlib, third-party, local
- [ ] No circular imports
- [ ] Unused imports removed
- [ ] Star imports avoided (`from x import *`)
- [ ] Relative imports used consistently within packages
- [ ] External dependencies are necessary (not over-engineered)
- [ ] Version conflicts unlikely

## Modern Python Features (3.8+)

- [ ] `pathlib.Path` instead of `os.path` operations
- [ ] `datetime` module for date/time (not `time`)
- [ ] `typing.Protocol` for structural subtyping
- [ ] `@dataclass` for data containers
- [ ] `match` statements for pattern matching (3.10+)
- [ ] Union types with `|` operator (3.10+)
- [ ] `str.removeprefix()` / `str.removesuffix()` (3.9+)
- [ ] `dict` merge operator `|` (3.9+)
- [ ] Positional-only `/` and keyword-only `*` parameters

## Code Organization

- [ ] Related functionality grouped together
- [ ] Clear separation of concerns
- [ ] Proper use of modules and packages
- [ ] `__init__.py` files are minimal (re-exports only)
- [ ] Circular dependencies avoided
- [ ] Configuration separated from code
- [ ] Business logic separated from infrastructure

## Memory and Resource Management

- [ ] Large files processed in chunks (not loaded entirely)
- [ ] Iterators/generators used for large datasets
- [ ] Connections and file handles properly closed
- [ ] Database connections use connection pooling
- [ ] No memory leaks (circular references with `__del__`)
- [ ] Weak references used where appropriate

## Concurrency (if applicable)

- [ ] Thread-safe if using threads
- [ ] Process-safe if using multiprocessing
- [ ] Proper locking mechanisms used
- [ ] Deadlock potential analyzed
- [ ] GIL implications considered
- [ ] Shared state minimized

## Special Considerations

- [ ] Backwards compatibility maintained (if library)
- [ ] Deprecation warnings for removed features
- [ ] Semantic versioning followed
- [ ] Breaking changes documented
- [ ] Performance-critical paths profiled
