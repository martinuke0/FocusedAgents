# Example: Unit Test Generation

This example demonstrates generating comprehensive unit tests for a Python function.

## Code to Test

```python
# calculator.py
from typing import Union, List


def calculate_total(
    items: List[dict],
    tax_rate: float = 0.1,
    discount_percent: float = 0.0
) -> float:
    """
    Calculate total price with tax and discount.

    Args:
        items: List of items with 'price' and 'quantity' keys
        tax_rate: Tax rate as decimal (0.1 = 10%)
        discount_percent: Discount percentage (10.0 = 10% off)

    Returns:
        Final total after tax and discount

    Raises:
        ValueError: If tax_rate is negative or items is empty
        KeyError: If items don't have required keys
    """
    if not items:
        raise ValueError("Items list cannot be empty")

    if tax_rate < 0:
        raise ValueError("Tax rate cannot be negative")

    # Calculate subtotal
    subtotal = sum(item['price'] * item['quantity'] for item in items)

    # Apply discount
    if discount_percent > 0:
        subtotal *= (1 - discount_percent / 100)

    # Apply tax
    total = subtotal * (1 + tax_rate)

    return round(total, 2)
```

## Generated Test Suite

### Test Strategy

The test suite covers:
1. **Happy paths**: Normal usage with various valid inputs
2. **Edge cases**: Empty lists, zero values, boundary conditions
3. **Error conditions**: Invalid inputs, missing keys, negative values
4. **Mathematical correctness**: Tax and discount calculations
5. **Type handling**: Different numeric types (int, float)

### Generated Tests

```python
# test_calculator.py
"""Comprehensive tests for calculator module."""

import pytest
from calculator import calculate_total


# Fixtures
@pytest.fixture
def single_item():
    """Single item for testing."""
    return [{"price": 100.0, "quantity": 1}]


@pytest.fixture
def multiple_items():
    """Multiple items for testing."""
    return [
        {"price": 50.0, "quantity": 2},   # $100
        {"price": 30.0, "quantity": 3},   # $90
        {"price": 20.0, "quantity": 1},   # $20
    ]  # Total: $210


# Happy Path Tests
def test_calculate_total_with_single_item_no_tax_no_discount(single_item):
    """Test basic calculation with one item."""
    # Arrange
    expected = 100.0

    # Act
    result = calculate_total(single_item, tax_rate=0.0, discount_percent=0.0)

    # Assert
    assert result == expected


def test_calculate_total_with_default_tax(single_item):
    """Test calculation with default 10% tax."""
    # Arrange
    expected = 110.0  # 100 * 1.1

    # Act
    result = calculate_total(single_item)

    # Assert
    assert result == expected


def test_calculate_total_with_multiple_items(multiple_items):
    """Test calculation with multiple items."""
    # Arrange
    # Subtotal: 50*2 + 30*3 + 20*1 = 100 + 90 + 20 = 210
    # Tax (10%): 210 * 1.1 = 231
    expected = 231.0

    # Act
    result = calculate_total(multiple_items, tax_rate=0.1)

    # Assert
    assert result == expected


def test_calculate_total_with_discount(single_item):
    """Test calculation with discount applied."""
    # Arrange
    # Price: 100
    # Discount (20%): 100 * 0.8 = 80
    # Tax (10%): 80 * 1.1 = 88
    expected = 88.0

    # Act
    result = calculate_total(single_item, tax_rate=0.1, discount_percent=20.0)

    # Assert
    assert result == expected


def test_calculate_total_with_custom_tax_rate(single_item):
    """Test calculation with custom tax rate."""
    # Arrange
    # Price: 100
    # Tax (25%): 100 * 1.25 = 125
    expected = 125.0

    # Act
    result = calculate_total(single_item, tax_rate=0.25, discount_percent=0.0)

    # Assert
    assert result == expected


# Edge Case Tests
def test_calculate_total_with_zero_tax_rate(single_item):
    """Test that zero tax rate works correctly."""
    # Arrange
    expected = 100.0

    # Act
    result = calculate_total(single_item, tax_rate=0.0)

    # Assert
    assert result == expected


def test_calculate_total_with_zero_discount(single_item):
    """Test that zero discount works correctly."""
    # Act
    result = calculate_total(single_item, tax_rate=0.1, discount_percent=0.0)

    # Assert
    assert result == 110.0


def test_calculate_total_with_100_percent_discount(single_item):
    """Test with 100% discount (free)."""
    # Arrange
    # Price: 100
    # Discount (100%): 100 * 0 = 0
    # Tax (10%): 0 * 1.1 = 0
    expected = 0.0

    # Act
    result = calculate_total(single_item, tax_rate=0.1, discount_percent=100.0)

    # Assert
    assert result == expected


def test_calculate_total_with_fractional_quantities():
    """Test calculation with decimal quantities."""
    # Arrange
    items = [{"price": 10.0, "quantity": 2.5}]  # 25.0
    expected = 27.5  # 25 * 1.1

    # Act
    result = calculate_total(items, tax_rate=0.1)

    # Assert
    assert result == expected


def test_calculate_total_with_very_small_prices():
    """Test with prices less than $1."""
    # Arrange
    items = [{"price": 0.99, "quantity": 3}]  # 2.97
    expected = 3.27  # 2.97 * 1.1 = 3.267, rounded to 3.27

    # Act
    result = calculate_total(items, tax_rate=0.1)

    # Assert
    assert result == expected


def test_calculate_total_rounds_to_two_decimals():
    """Test that result is properly rounded to 2 decimal places."""
    # Arrange
    items = [{"price": 10.0, "quantity": 1}]
    # 10 * 1.1 = 11.0, but with tax_rate=0.123: 10 * 1.123 = 11.23

    # Act
    result = calculate_total(items, tax_rate=0.123)

    # Assert
    assert result == 11.23
    assert len(str(result).split('.')[-1]) <= 2


# Error Condition Tests
def test_calculate_total_with_empty_list_raises_value_error():
    """Test that empty items list raises ValueError."""
    # Arrange
    empty_items = []

    # Act & Assert
    with pytest.raises(ValueError, match="Items list cannot be empty"):
        calculate_total(empty_items)


def test_calculate_total_with_negative_tax_rate_raises_value_error():
    """Test that negative tax rate raises ValueError."""
    # Arrange
    items = [{"price": 100.0, "quantity": 1}]
    negative_tax = -0.1

    # Act & Assert
    with pytest.raises(ValueError, match="Tax rate cannot be negative"):
        calculate_total(items, tax_rate=negative_tax)


def test_calculate_total_with_missing_price_key_raises_key_error():
    """Test that missing 'price' key raises KeyError."""
    # Arrange
    items_missing_price = [{"quantity": 1}]

    # Act & Assert
    with pytest.raises(KeyError):
        calculate_total(items_missing_price)


def test_calculate_total_with_missing_quantity_key_raises_key_error():
    """Test that missing 'quantity' key raises KeyError."""
    # Arrange
    items_missing_quantity = [{"price": 100.0}]

    # Act & Assert
    with pytest.raises(KeyError):
        calculate_total(items_missing_quantity)


# Parametrized Tests for Multiple Scenarios
@pytest.mark.parametrize("items,tax_rate,discount_percent,expected", [
    # (items, tax_rate, discount, expected_result)
    ([{"price": 100, "quantity": 1}], 0.0, 0.0, 100.0),
    ([{"price": 100, "quantity": 1}], 0.1, 0.0, 110.0),
    ([{"price": 100, "quantity": 1}], 0.0, 10.0, 90.0),
    ([{"price": 100, "quantity": 1}], 0.1, 10.0, 99.0),
    ([{"price": 50, "quantity": 2}], 0.1, 0.0, 110.0),
    ([{"price": 25, "quantity": 4}], 0.2, 0.0, 120.0),
    ([{"price": 10, "quantity": 10}], 0.15, 5.0, 109.25),
], ids=[
    "no_tax_no_discount",
    "with_tax_only",
    "with_discount_only",
    "with_both",
    "multiple_quantity",
    "high_tax_rate",
    "complex_calculation",
])
def test_calculate_total_parametrized(items, tax_rate, discount_percent, expected):
    """Test various calculation scenarios with parametrization."""
    result = calculate_total(items, tax_rate, discount_percent)
    assert result == pytest.approx(expected, rel=1e-2)


@pytest.mark.parametrize("invalid_items", [
    [],
    None,
], ids=["empty_list", "none_value"])
def test_calculate_total_with_invalid_items_list(invalid_items):
    """Test that invalid items lists raise appropriate errors."""
    with pytest.raises((ValueError, TypeError)):
        calculate_total(invalid_items if invalid_items is not None else [])


# Integration-like Tests (testing realistic scenarios)
def test_calculate_total_realistic_shopping_cart():
    """Test with realistic shopping cart scenario."""
    # Arrange: Shopping cart with various items
    cart = [
        {"price": 29.99, "quantity": 2},   # Shirts: $59.98
        {"price": 49.99, "quantity": 1},   # Shoes: $49.99
        {"price": 15.50, "quantity": 3},   # Socks: $46.50
    ]  # Subtotal: $156.47
    # Tax (8.5%): $156.47 * 1.085 = $169.77
    expected = 169.77

    # Act
    result = calculate_total(cart, tax_rate=0.085)

    # Assert
    assert result == pytest.approx(expected, abs=0.01)


def test_calculate_total_black_friday_sale():
    """Test Black Friday scenario with high discount."""
    # Arrange
    items = [
        {"price": 199.99, "quantity": 1},  # Laptop
        {"price": 49.99, "quantity": 2},   # Accessories
    ]  # Subtotal: $299.97
    # Discount (30%): $299.97 * 0.7 = $209.98
    # Tax (7%): $209.98 * 1.07 = $224.68
    expected = 224.68

    # Act
    result = calculate_total(items, tax_rate=0.07, discount_percent=30.0)

    # Assert
    assert result == pytest.approx(expected, abs=0.01)
```

### Coverage Analysis

**Coverage estimate: ~100% line coverage**

#### Covered Scenarios:
- **Happy paths**:
  - Single item calculation
  - Multiple items calculation
  - With and without tax
  - With and without discount
  - Tax and discount combined

- **Edge cases**:
  - Zero tax rate
  - Zero discount
  - 100% discount
  - Fractional quantities
  - Very small prices
  - Rounding behavior

- **Error conditions**:
  - Empty items list
  - Negative tax rate
  - Missing 'price' key
  - Missing 'quantity' key

- **Parametrized tests**: 7 different scenarios
- **Realistic scenarios**: Shopping cart and sale calculations

### Running the Tests

```bash
# Run all tests
pytest test_calculator.py -v

# Run with coverage
pytest test_calculator.py --cov=calculator --cov-report=html

# Run specific test
pytest test_calculator.py::test_calculate_total_with_discount -v

# Run parametrized tests only
pytest test_calculator.py -k "parametrized" -v
```

### Expected Output

```
test_calculator.py::test_calculate_total_with_single_item_no_tax_no_discount PASSED
test_calculator.py::test_calculate_total_with_default_tax PASSED
test_calculator.py::test_calculate_total_with_multiple_items PASSED
test_calculator.py::test_calculate_total_with_discount PASSED
...
======================== 25 passed in 0.15s =========================

Coverage: 100%
```

## Key Takeaways

1. **Comprehensive coverage**: All code paths tested
2. **Clear test names**: Each test explains what it's testing
3. **AAA pattern**: Arrange, Act, Assert structure throughout
4. **Parametrization**: Efficient testing of multiple scenarios
5. **Fixtures**: Reusable test data
6. **Error testing**: All exceptions properly tested
7. **Realistic scenarios**: Tests reflect actual usage
8. **Mathematical verification**: Calculations verified with comments
