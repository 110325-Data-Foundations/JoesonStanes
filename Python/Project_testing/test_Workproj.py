import pytest

import Workproj as wp
from Workproj import FOOD_LIST

def test_get_menu_lines_returns_formatted_strings():

    menu = FOOD_LIST
    lines = wp.get_menu_lines(menu)
    assert lines[1] == "2. Spicy Chicken Burger   -   $7.29"

def test_normalize_food_name_removes_prefix():
    numbered_name = "1. Margherita Pizza"
    normalized = wp.normalize_food_name(numbered_name)
    assert normalized == "Margherita Pizza"
def test_add_choice_to_orders_valid():
    orders = {}
    choice = "2"

    ok, msg = wp.add_choice_to_orders(orders, choice)

    assert ok is True
    assert msg == "Added Spicy Chicken Burger ($7.29) to your order."
def test_summarize_orders():
    orders = {"Margherita Pizza": 9.49, "Spicy Chicken Burger": 7.29}
    lines, total = wp.summarize_orders(orders)
    assert lines == ["- Margherita Pizza: $9.49", "- Spicy Chicken Burger: $7.29"]
    assert total == 16.78


