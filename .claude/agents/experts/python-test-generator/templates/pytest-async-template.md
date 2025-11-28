# Pytest Async Testing Template

Patterns for testing asynchronous Python code using pytest-asyncio.

## Basic Async Test

```python
import pytest
import asyncio


@pytest.mark.asyncio
async def test_async_function():
    """Test an async function."""
    # Arrange
    input_data = "test"

    # Act
    result = await async_function(input_data)

    # Assert
    assert result == "expected"
```

## Async Fixtures

```python
@pytest.fixture
async def async_client():
    """Provide an async HTTP client."""
    async with httpx.AsyncClient() as client:
        yield client


@pytest.fixture
async def async_database():
    """Provide an async database connection."""
    db = await connect_to_database()
    yield db
    await db.close()


@pytest.mark.asyncio
async def test_with_async_fixtures(async_client, async_database):
    """Test using async fixtures."""
    await async_database.insert({"key": "value"})
    response = await async_client.get("/api/data")
    assert response.status_code == 200
```

## Testing Async Context Managers

```python
@pytest.mark.asyncio
async def test_async_context_manager():
    """Test async context manager."""
    async with AsyncResource() as resource:
        result = await resource.operation()
        assert result is not None
    # Context manager should have cleaned up


@pytest.mark.asyncio
async def test_async_context_manager_error_handling():
    """Test that async context manager handles errors."""
    with pytest.raises(CustomError):
        async with AsyncResource() as resource:
            await resource.failing_operation()
```

## Testing Concurrent Operations

```python
@pytest.mark.asyncio
async def test_concurrent_operations():
    """Test multiple concurrent async operations."""
    # Run operations concurrently
    results = await asyncio.gather(
        async_operation_1(),
        async_operation_2(),
        async_operation_3(),
    )

    assert len(results) == 3
    assert all(r is not None for r in results)


@pytest.mark.asyncio
async def test_concurrent_with_exception_handling():
    """Test concurrent operations with error handling."""
    results = await asyncio.gather(
        async_operation_success(),
        async_operation_failure(),
        return_exceptions=True,
    )

    assert results[0] == "success"
    assert isinstance(results[1], Exception)
```

## Testing Async Generators

```python
@pytest.mark.asyncio
async def test_async_generator():
    """Test async generator function."""
    items = []

    async for item in async_generator():
        items.append(item)

    assert len(items) == expected_count
    assert items[0] == expected_first_item


@pytest.mark.asyncio
async def test_async_generator_comprehension():
    """Test async generator with comprehension."""
    items = [item async for item in async_generator()]
    assert len(items) > 0
```

## Testing Timeouts

```python
@pytest.mark.asyncio
async def test_operation_completes_within_timeout():
    """Test that operation completes within time limit."""
    async with asyncio.timeout(1.0):  # Python 3.11+
        result = await slow_operation()
        assert result is not None


@pytest.mark.asyncio
async def test_operation_timeout_raises_error():
    """Test that slow operation times out."""
    with pytest.raises(asyncio.TimeoutError):
        async with asyncio.timeout(0.1):
            await very_slow_operation()
```

## Mocking Async Functions

```python
@pytest.mark.asyncio
async def test_with_mocked_async_function(mocker):
    """Test with mocked async function."""
    # Create async mock
    mock_async_func = mocker.AsyncMock(return_value="mocked_result")
    mocker.patch('module.async_function', mock_async_func)

    # Act
    result = await function_that_calls_async_function()

    # Assert
    assert result == "processed_mocked_result"
    mock_async_func.assert_awaited_once()


@pytest.mark.asyncio
async def test_mocking_async_api_call(mocker):
    """Test with mocked async API call."""
    mock_response = mocker.Mock()
    mock_response.status_code = 200
    mock_response.json = mocker.AsyncMock(return_value={"data": "test"})

    mock_client = mocker.AsyncMock()
    mock_client.get.return_value = mock_response

    result = await fetch_data(mock_client)
    assert result["data"] == "test"
```

## Testing Async Events and Callbacks

```python
@pytest.mark.asyncio
async def test_async_event():
    """Test async event handling."""
    event = asyncio.Event()
    results = []

    async def waiter():
        await event.wait()
        results.append("event_triggered")

    # Start waiter
    task = asyncio.create_task(waiter())

    # Trigger event
    event.set()

    # Wait for completion
    await task

    assert "event_triggered" in results


@pytest.mark.asyncio
async def test_async_callback():
    """Test async callback execution."""
    callback_executed = False

    async def async_callback():
        nonlocal callback_executed
        callback_executed = True

    await execute_with_callback(async_callback)

    assert callback_executed
```

## Testing Async Queues

```python
@pytest.mark.asyncio
async def test_async_queue():
    """Test async queue operations."""
    queue = asyncio.Queue()

    # Producer
    async def producer():
        for i in range(5):
            await queue.put(i)
        await queue.put(None)  # Sentinel

    # Consumer
    async def consumer():
        items = []
        while True:
            item = await queue.get()
            if item is None:
                break
            items.append(item)
        return items

    # Run concurrently
    producer_task = asyncio.create_task(producer())
    items = await consumer()
    await producer_task

    assert items == [0, 1, 2, 3, 4]
```

## Testing Async Locks and Synchronization

```python
@pytest.mark.asyncio
async def test_async_lock():
    """Test async lock prevents concurrent access."""
    lock = asyncio.Lock()
    counter = 0
    results = []

    async def increment():
        nonlocal counter
        async with lock:
            current = counter
            await asyncio.sleep(0.01)  # Simulate work
            counter = current + 1
            results.append(counter)

    # Run multiple increments concurrently
    await asyncio.gather(
        increment(),
        increment(),
        increment(),
    )

    assert counter == 3
    assert results == [1, 2, 3]  # Sequential due to lock


@pytest.mark.asyncio
async def test_async_semaphore():
    """Test async semaphore limits concurrency."""
    semaphore = asyncio.Semaphore(2)  # Max 2 concurrent
    active_count = 0
    max_active = 0

    async def task():
        nonlocal active_count, max_active
        async with semaphore:
            active_count += 1
            max_active = max(max_active, active_count)
            await asyncio.sleep(0.01)
            active_count -= 1

    await asyncio.gather(*(task() for _ in range(10)))

    assert max_active == 2  # Never more than 2 concurrent
```

## Testing Async Error Propagation

```python
@pytest.mark.asyncio
async def test_async_error_propagation():
    """Test that errors propagate correctly in async code."""
    async def failing_task():
        raise ValueError("Task failed")

    with pytest.raises(ValueError, match="Task failed"):
        await failing_task()


@pytest.mark.asyncio
async def test_async_gather_with_errors():
    """Test error handling in asyncio.gather."""
    async def success():
        return "ok"

    async def failure():
        raise ValueError("failed")

    # Without return_exceptions, first exception is raised
    with pytest.raises(ValueError):
        await asyncio.gather(success(), failure())

    # With return_exceptions, exceptions are returned
    results = await asyncio.gather(
        success(),
        failure(),
        return_exceptions=True,
    )

    assert results[0] == "ok"
    assert isinstance(results[1], ValueError)
```

## Testing Async Iterators

```python
@pytest.mark.asyncio
async def test_async_iterator():
    """Test async iterator protocol."""
    class AsyncRange:
        def __init__(self, n):
            self.n = n
            self.i = 0

        def __aiter__(self):
            return self

        async def __anext__(self):
            if self.i < self.n:
                result = self.i
                self.i += 1
                await asyncio.sleep(0.001)  # Simulate async work
                return result
            raise StopAsyncIteration

    items = [i async for i in AsyncRange(5)]
    assert items == [0, 1, 2, 3, 4]
```

## Testing Async Fixtures with Cleanup

```python
@pytest.fixture
async def async_resource_with_cleanup():
    """Async fixture with setup and teardown."""
    # Setup
    resource = await create_async_resource()
    await resource.initialize()

    yield resource

    # Cleanup
    await resource.cleanup()
    await resource.close()


@pytest.mark.asyncio
async def test_with_cleanup_fixture(async_resource_with_cleanup):
    """Test using fixture with async cleanup."""
    result = await async_resource_with_cleanup.operation()
    assert result is not None
```

## Testing Task Cancellation

```python
@pytest.mark.asyncio
async def test_task_cancellation():
    """Test that tasks can be cancelled."""
    async def long_running_task():
        try:
            await asyncio.sleep(10)
            return "completed"
        except asyncio.CancelledError:
            return "cancelled"

    task = asyncio.create_task(long_running_task())
    await asyncio.sleep(0.01)  # Let it start

    task.cancel()

    result = await task
    assert result == "cancelled"


@pytest.mark.asyncio
async def test_graceful_shutdown():
    """Test graceful shutdown of async tasks."""
    tasks = []

    async def worker():
        try:
            while True:
                await asyncio.sleep(0.1)
        except asyncio.CancelledError:
            return "shutdown"

    # Start workers
    for _ in range(3):
        tasks.append(asyncio.create_task(worker()))

    await asyncio.sleep(0.01)

    # Cancel all
    for task in tasks:
        task.cancel()

    results = await asyncio.gather(*tasks)
    assert all(r == "shutdown" for r in results)
```

## Parametrized Async Tests

```python
@pytest.mark.asyncio
@pytest.mark.parametrize("input_value,expected", [
    (1, 2),
    (2, 4),
    (3, 6),
])
async def test_async_parametrized(input_value, expected):
    """Parametrized async test."""
    result = await async_double(input_value)
    assert result == expected
```

## Testing Async Retry Logic

```python
@pytest.mark.asyncio
async def test_async_retry_success_after_failures(mocker):
    """Test retry logic succeeds after failures."""
    mock_operation = mocker.AsyncMock(
        side_effect=[
            Exception("First attempt fails"),
            Exception("Second attempt fails"),
            "success",  # Third attempt succeeds
        ]
    )

    result = await retry_async_operation(mock_operation, max_retries=3)

    assert result == "success"
    assert mock_operation.await_count == 3


@pytest.mark.asyncio
async def test_async_retry_exhausts_retries(mocker):
    """Test retry logic gives up after max retries."""
    mock_operation = mocker.AsyncMock(
        side_effect=Exception("Always fails")
    )

    with pytest.raises(Exception, match="Always fails"):
        await retry_async_operation(mock_operation, max_retries=3)

    assert mock_operation.await_count == 3
```

## Complete Example: Async API Client

```python
import pytest
import asyncio
import httpx


class AsyncAPIClient:
    def __init__(self, base_url):
        self.base_url = base_url
        self.client = None

    async def __aenter__(self):
        self.client = httpx.AsyncClient(base_url=self.base_url)
        return self

    async def __aexit__(self, exc_type, exc_val, exc_tb):
        await self.client.aclose()

    async def get_users(self):
        response = await self.client.get("/users")
        return response.json()


@pytest.fixture
async def mock_api_client(mocker):
    """Mock async API client."""
    mock_client = mocker.Mock()
    mock_client.get = mocker.AsyncMock()
    mock_client.get.return_value.json.return_value = [
        {"id": 1, "name": "Alice"},
        {"id": 2, "name": "Bob"},
    ]
    mock_client.aclose = mocker.AsyncMock()

    async_api = AsyncAPIClient("http://test.com")
    async_api.client = mock_client
    return async_api


@pytest.mark.asyncio
async def test_api_client_get_users(mock_api_client):
    """Test fetching users from API."""
    users = await mock_api_client.get_users()

    assert len(users) == 2
    assert users[0]["name"] == "Alice"
    mock_api_client.client.get.assert_awaited_once_with("/users")
```

## Best Practices

1. **Always use `@pytest.mark.asyncio`** decorator for async tests
2. **Use AsyncMock** for mocking async functions
3. **Test concurrent operations** with `asyncio.gather()`
4. **Test error handling** including cancellation
5. **Use async fixtures** for async setup/teardown
6. **Test timeouts** to ensure operations don't hang
7. **Verify mock awaits** with `assert_awaited_once()`
8. **Clean up tasks** properly to avoid warnings
