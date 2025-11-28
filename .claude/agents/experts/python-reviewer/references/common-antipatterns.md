# Common Python Antipatterns

A catalog of common mistakes and how to fix them.

## 1. Mutable Default Arguments

### Problem
```python
def append_to_list(item, target=[]):
    target.append(item)
    return target

# Bug! All calls share the same list
list1 = append_to_list(1)  # [1]
list2 = append_to_list(2)  # [1, 2] - Unexpected!
```

### Solution
```python
def append_to_list(item, target=None):
    if target is None:
        target = []
    target.append(item)
    return target
```

### Why
Default arguments are evaluated once at function definition time, not at call time. Mutable defaults are shared across all calls.

---

## 2. Bare Except Clauses

### Problem
```python
try:
    risky_operation()
except:  # Catches EVERYTHING including KeyboardInterrupt
    pass
```

### Solution
```python
try:
    risky_operation()
except ValueError as e:
    logging.error(f"Invalid value: {e}")
except IOError as e:
    logging.error(f"IO error: {e}")
```

### Why
Bare `except:` catches system exceptions like `KeyboardInterrupt` and `SystemExit`, making it impossible to stop the program.

---

## 3. Using `==` Instead of `is` for None

### Problem
```python
if x == None:  # Works but not idiomatic
    pass
```

### Solution
```python
if x is None:  # Correct way
    pass
```

### Why
`None` is a singleton. Use `is` for identity checks, `==` for equality checks. Classes can override `__eq__` to return unexpected results.

---

## 4. Checking Length for Emptiness

### Problem
```python
if len(my_list) == 0:
    print("Empty")

if len(my_string) > 0:
    print("Not empty")
```

### Solution
```python
if not my_list:  # Pythonic way
    print("Empty")

if my_string:  # Pythonic way
    print("Not empty")
```

### Why
Empty sequences are falsy in Python. Direct boolean evaluation is more readable and efficient.

---

## 5. Manual Index Tracking

### Problem
```python
i = 0
for item in items:
    print(i, item)
    i += 1
```

### Solution
```python
for i, item in enumerate(items):
    print(i, item)
```

### Why
`enumerate()` is the Pythonic way to get both index and value.

---

## 6. Not Using Context Managers

### Problem
```python
f = open('file.txt')
content = f.read()
f.close()  # Might not execute if exception occurs
```

### Solution
```python
with open('file.txt') as f:
    content = f.read()
# File automatically closed even if exception occurs
```

### Why
Context managers guarantee cleanup even if exceptions occur.

---

## 7. String Concatenation in Loops

### Problem
```python
result = ""
for item in large_list:
    result += str(item)  # O(n²) time complexity
```

### Solution
```python
result = ''.join(str(item) for item in large_list)  # O(n)
```

### Why
Strings are immutable. Each `+=` creates a new string, copying all previous data.

---

## 8. Type Checking with `type()`

### Problem
```python
if type(x) == list:
    process_list(x)
```

### Solution
```python
if isinstance(x, list):
    process_list(x)

# Even better: check for behavior, not type
if hasattr(x, '__iter__'):
    process_iterable(x)
```

### Why
`isinstance()` respects inheritance. `type()` does not. Duck typing is even more Pythonic.

---

## 9. Not Using List Comprehensions

### Problem
```python
squares = []
for x in range(10):
    squares.append(x**2)
```

### Solution
```python
squares = [x**2 for x in range(10)]
```

### Why
List comprehensions are more readable, more Pythonic, and often faster.

---

## 10. Using Lists for Membership Testing

### Problem
```python
valid_ids = [1, 2, 3, ..., 1000]  # List

if user_id in valid_ids:  # O(n) lookup
    grant_access()
```

### Solution
```python
valid_ids = {1, 2, 3, ..., 1000}  # Set

if user_id in valid_ids:  # O(1) lookup
    grant_access()
```

### Why
Sets use hash tables for O(1) membership testing. Lists require O(n) iteration.

---

## 11. Modifying List While Iterating

### Problem
```python
items = [1, 2, 3, 4, 5]
for item in items:
    if item % 2 == 0:
        items.remove(item)  # Skips elements!
```

### Solution
```python
# Option 1: List comprehension
items = [item for item in items if item % 2 != 0]

# Option 2: Iterate over copy
for item in items[:]:
    if item % 2 == 0:
        items.remove(item)
```

### Why
Modifying a list while iterating over it causes the iterator to skip elements.

---

## 12. Overusing `global`

### Problem
```python
counter = 0

def increment():
    global counter
    counter += 1
```

### Solution
```python
class Counter:
    def __init__(self):
        self.value = 0

    def increment(self):
        self.value += 1

counter = Counter()
counter.increment()
```

### Why
Global state makes code harder to test and reason about. Use classes or pass state explicitly.

---

## 13. Using `eval()` or `exec()`

### Problem
```python
user_input = "print('hello')"
eval(user_input)  # Security vulnerability!
```

### Solution
```python
# Use safer alternatives
import ast
tree = ast.parse(user_input)
# Validate and process AST safely

# Or use json for data
import json
data = json.loads(user_input_json)
```

### Why
`eval()` and `exec()` execute arbitrary code, creating severe security vulnerabilities.

---

## 14. Catching and Re-raising Without Context

### Problem
```python
try:
    risky_operation()
except ValueError:
    logging.error("Error occurred")
    raise ValueError("Something went wrong")  # Loses original traceback
```

### Solution
```python
try:
    risky_operation()
except ValueError as e:
    logging.error(f"Error occurred: {e}")
    raise  # Preserves original traceback

# Or chain exceptions
try:
    risky_operation()
except ValueError as e:
    raise CustomError("Something went wrong") from e
```

### Why
Preserving exception context helps with debugging. Use `raise` without arguments or `raise ... from`.

---

## 15. Using `*` in `except` Clauses

### Problem
```python
try:
    operation()
except Exception:  # Too broad
    pass
```

### Solution
```python
try:
    operation()
except (ValueError, KeyError) as e:  # Specific exceptions
    handle_error(e)
```

### Why
Catching broad exceptions masks bugs. Be specific about what you're handling.

---

## 16. Not Using `with` for Locks

### Problem
```python
lock.acquire()
try:
    critical_section()
finally:
    lock.release()
```

### Solution
```python
with lock:
    critical_section()
```

### Why
Context managers are cleaner and guarantee lock release even if exceptions occur.

---

## 17. Using `dict.keys()` for Iteration

### Problem
```python
for key in my_dict.keys():  # Unnecessary .keys()
    print(key, my_dict[key])
```

### Solution
```python
# Option 1: Iterate over keys (default)
for key in my_dict:
    print(key, my_dict[key])

# Option 2: Iterate over items
for key, value in my_dict.items():
    print(key, value)
```

### Why
`.keys()` is redundant. Dicts are iterable by default over keys.

---

## 18. Using `range(len())` for Indexing

### Problem
```python
for i in range(len(items)):
    print(items[i])
```

### Solution
```python
for item in items:
    print(item)

# If you need the index:
for i, item in enumerate(items):
    print(i, item)
```

### Why
Direct iteration is more Pythonic. Use `enumerate()` when you need indices.

---

## 19. Not Using `pathlib`

### Problem
```python
import os

path = os.path.join('dir', 'subdir', 'file.txt')
if os.path.exists(path):
    with open(path) as f:
        content = f.read()
```

### Solution
```python
from pathlib import Path

path = Path('dir') / 'subdir' / 'file.txt'
if path.exists():
    content = path.read_text()
```

### Why
`pathlib` is object-oriented, cross-platform, and more readable.

---

## 20. Using `import *`

### Problem
```python
from module import *  # Pollutes namespace
```

### Solution
```python
# Option 1: Import specific names
from module import function1, function2

# Option 2: Import module
import module
module.function1()

# Option 3: Alias for convenience
from long_module_name import MyClass as MC
```

### Why
Star imports make it unclear where names come from and can cause name collisions.

---

## 21. SQL Injection via String Formatting

### Problem
```python
username = request.get('username')
query = f"SELECT * FROM users WHERE username = '{username}'"
cursor.execute(query)  # SQL INJECTION!
```

### Solution
```python
username = request.get('username')
query = "SELECT * FROM users WHERE username = ?"
cursor.execute(query, (username,))  # Safe - parameterized
```

### Why
String formatting in SQL queries allows attackers to inject malicious SQL code. Always use parameterized queries.

---

## 22. Using `random` for Cryptography

### Problem
```python
import random

token = ''.join(random.choices('abcdef0123456789', k=32))  # NOT SECURE
```

### Solution
```python
import secrets

token = secrets.token_hex(16)  # Cryptographically secure
```

### Why
`random` is predictable and not suitable for security. Use `secrets` for tokens, passwords, etc.

---

## 23. Comparing Boolean to True

### Problem
```python
if x == True:  # Redundant and error-prone
    do_something()
```

### Solution
```python
if x:  # Simple and Pythonic
    do_something()
```

### Why
Truthiness is broader than `True`. `if x` works for non-empty strings, non-zero numbers, etc.

---

## 24. Using `time.time()` for Code Timing

### Problem
```python
import time

start = time.time()
operation()
duration = time.time() - start  # Affected by system clock changes
```

### Solution
```python
import time

start = time.perf_counter()  # Monotonic clock
operation()
duration = time.perf_counter() - start
```

### Why
`time.time()` can jump if the system clock changes. `perf_counter()` is monotonic and higher resolution.

---

## 25. Returning Multiple Types from Function

### Problem
```python
def get_user(user_id):
    if user_found:
        return user_object  # Returns User
    else:
        return None  # Returns None
    # Sometimes returns False or empty dict elsewhere
```

### Solution
```python
def get_user(user_id) -> Optional[User]:
    if user_found:
        return user_object
    else:
        return None  # Consistent: User or None
```

### Why
Inconsistent return types make code hard to use and error-prone. Use type hints to enforce consistency.

---

## Summary

Common themes:
1. **Use built-in idioms**: `enumerate()`, `zip()`, comprehensions
2. **Use context managers**: `with` for resources
3. **Be specific**: Specific exceptions, specific types
4. **Use the right data structure**: Sets for membership, dicts for lookup
5. **Think about security**: No `eval()`, parameterize SQL, use `secrets`
6. **Use `pathlib`**: Modern path manipulation
7. **Type hint**: Catch errors early with mypy
8. **Avoid mutability pitfalls**: Mutable defaults, modifying while iterating

## Tools to Catch These

- **pylint**: Catches many antipatterns
- **flake8**: Style and some logic issues
- **bandit**: Security issues
- **mypy**: Type inconsistencies
- **ruff**: Fast linter combining multiple tools
