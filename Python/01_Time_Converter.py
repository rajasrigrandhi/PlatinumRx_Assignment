def convert_minutes(minutes):
    hours = minutes // 60
    mins = minutes % 60
    return f"{hours} hrs {mins} minutes"

# Example
print(convert_minutes(130))
print(convert_minutes(110))