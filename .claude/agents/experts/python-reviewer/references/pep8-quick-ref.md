# PEP 8 Quick Reference

Essential Python style guidelines at a glance.

## Naming Conventions

```python
# Modules and packages
mymodule.py
mypackage/

# Functions and variables
def my_function():
    local_variable = 1

# Classes
class MyClass:
    pass

# Constants
MAX_CONNECTIONS = 100
API_KEY = "..."

# Private (internal use)
_internal_function()
_InternalClass()
__private_attribute

# Special/magic methods
__init__()
__str__()
```

## Indentation and Line Length

```python
# Use 4 spaces (never tabs)
def function():
    if condition:
        do_something()

# Line length: 88 characters (Black) or 79 (PEP 8 strict)
result = some_function(argument1, argument2,
                       argument3, argument4)

# Hanging indent
result = some_function(
    argument1,
    argument2,
    argument3,
)
```

## Whitespace

```python
# YES
x = 1
y = 2
result = x + y
my_list = [1, 2, 3]
my_dict = {'key': 'value'}

# NO
x=1
y= 2
result =x+y
my_list = [ 1,2, 3 ]
my_dict = {'key' : 'value'}

# Function calls
func(arg1, arg2, kwarg=value)  # YES
func( arg1, arg2, kwarg = value )  # NO

# Slicing
list[1:5]  # YES
list[1 : 5]  # NO
```

## Imports

```python
# Standard library imports
import os
import sys
from pathlib import Path

# Third-party imports
import numpy as np
import requests

# Local application imports
from myproject import module1
from myproject.utils import helper

# Avoid star imports
from module import *  # NO

# One import per line for 'import'
import os
import sys

# OK for 'from' imports
from subprocess import Popen, PIPE
```

## Blank Lines

```python
# Two blank lines between top-level definitions
def function1():
    pass


def function2():
    pass


class MyClass:
    # One blank line between methods
    def method1(self):
        pass

    def method2(self):
        pass
```

## String Quotes

```python
# Single or double quotes (be consistent)
my_string = 'hello'
my_string = "hello"

# Triple quotes for docstrings
def function():
    """This is a docstring."""
    pass

# Use the other quote to avoid escaping
message = "Don't do that"
message = 'He said "hello"'
```

## Comments

```python
# Block comments
# This is a block comment explaining
# the following code section.

# Inline comments (use sparingly)
x = x + 1  # Increment x

# Docstrings for modules, classes, functions
def function(arg):
    """
    Brief description.

    Args:
        arg: Argument description

    Returns:
        Return value description
    """
    pass
```

## Expression and Statement Best Practices

```python
# Comparisons to None
if x is None:  # YES
if x == None:  # NO

# Comparisons to True/False
if greeting:  # YES
if greeting == True:  # NO
if greeting is True:  # NO

# Empty sequences
if not seq:  # YES
if len(seq) == 0:  # NO

# Multiple conditions
if x and y and z:  # YES
if x == True and y == True:  # NO

# Use 'in' for membership
if key in dictionary:  # YES
if dictionary.has_key(key):  # NO (Python 2)
```

## Function and Method Arguments

```python
# Default arguments should be immutable
def function(arg, default=None):  # YES
    if default is None:
        default = []

def function(arg, default=[]):  # NO - mutable default!

# *args and **kwargs
def function(*args, **kwargs):
    pass

# Type hints (Python 3.5+)
def function(name: str, age: int) -> bool:
    return age > 18
```

## Modern Python (3.8+)

```python
# f-strings (Python 3.6+)
name = "Alice"
message = f"Hello, {name}!"  # YES
message = "Hello, {}!".format(name)  # OK but older
message = "Hello, %s!" % name  # NO - outdated

# Walrus operator (Python 3.8+)
if (match := pattern.search(text)):
    print(match.group())

# Type hints (Python 3.5+)
from typing import List, Dict, Optional

def process(items: List[str]) -> Dict[str, int]:
    pass

# Union operator (Python 3.10+)
def function(x: int | str) -> int | None:
    pass
```

## Common Idioms

```python
# List comprehensions
squares = [x**2 for x in range(10)]

# Dict comprehensions
counts = {k: 0 for k in keys}

# Enumerate for indexing
for i, value in enumerate(my_list):
    print(i, value)

# Zip for parallel iteration
for a, b in zip(list1, list2):
    print(a, b)

# Context managers
with open('file.txt') as f:
    content = f.read()

# Multiple context managers (Python 3.1+)
with open('in.txt') as infile, open('out.txt', 'w') as outfile:
    outfile.write(infile.read())
```

## Type Hints Reference

```python
from typing import List, Dict, Tuple, Optional, Union, Any, Callable

# Basic types
def func(x: int) -> str:
    return str(x)

# Collections
def func(items: List[str]) -> Dict[str, int]:
    return {item: len(item) for item in items}

# Optional (can be None)
def func(x: Optional[int] = None) -> str:
    pass

# Union (multiple types)
def func(x: Union[int, str]) -> bool:
    pass

# Callable
def func(callback: Callable[[int, int], int]) -> int:
    return callback(1, 2)

# Type aliases
UserId = int
UserMap = Dict[UserId, str]

def get_user(user_id: UserId) -> Optional[str]:
    pass
```

## Don'ts

```python
# Don't compare types with ==
if type(x) == list:  # NO
if isinstance(x, list):  # YES

# Don't use len() for emptiness
if len(seq) == 0:  # NO
if not seq:  # YES

# Don't catch everything
try:
    something()
except:  # NO - catches KeyboardInterrupt too
    pass

try:
    something()
except Exception as e:  # YES - specific
    pass

# Don't use mutable default arguments
def func(items=[]):  # NO
    items.append(1)
    return items

def func(items=None):  # YES
    if items is None:
        items = []
    items.append(1)
    return items
```

## Tools

- **black**: Automatic code formatter (88 char line length)
- **flake8**: Style guide enforcement
- **pylint**: Comprehensive static analysis
- **mypy**: Static type checker
- **isort**: Import sorting
- **autopep8**: Automatic PEP 8 fixes

## Quick Checklist

- [ ] 4 spaces for indentation
- [ ] Lines ≤ 88 characters
- [ ] Imports organized (stdlib, third-party, local)
- [ ] Two blank lines between functions/classes
- [ ] One blank line between methods
- [ ] snake_case for functions/variables
- [ ] PascalCase for classes
- [ ] UPPER_CASE for constants
- [ ] Type hints on public APIs
- [ ] Docstrings for public functions
- [ ] f-strings for formatting
- [ ] Context managers for resources

## Reference

Full PEP 8: https://peps.python.org/pep-0008/
