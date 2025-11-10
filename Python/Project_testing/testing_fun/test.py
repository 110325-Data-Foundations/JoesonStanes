import pytest

from code import celsius_to_fahrenheit


def test_celsius_to_fahrenheit_zero():
    # Arrange
    temperature_c = 0

    # Act
    result = celsius_to_fahrenheit(temperature_c)

    # Assert
    assert result == 32